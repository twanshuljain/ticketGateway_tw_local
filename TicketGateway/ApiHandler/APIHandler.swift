//
//  APIHandler.swift
//  BrakingCalculator
//
//  Created by Apple on 28/06/22.
//

// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name
import SVProgressHUD
import UIKit
public enum MethodType: String {
    case POST, GET, PUT, DELETE
}
public enum APIName: String {
    //******SignUp*******//
    case signUpEmail = "auth/signup-email/"
    case signInNumber = "auth/user/login/mobile/"
    case verifyEmailOtp = "auth/verify-otp/"
    case verifyNumberOtp = "auth/user/login/mobile/otp/verify/"
    case registerUser = "auth/register/"
    case signInUser = "auth/user/login/"
    case signInUserByNumberEmail = "auth/user/mobile-linked/email/login/"
    case forgotPassword = "auth/user/forget-password/"
    case logoutUser = ""
    //******HOME*******//
    case GetEventList = "events/list/"
    case GetEventListCategoryWise = "events/filter-types/list/"
    case GetEventDetail = "events/detail/"
    case GetEventCategoryList = "events/category/list/"
    case GetEventSubCategoryList =  "events/sub/category/list/"
    case GetEventSuggestedCategoryList = "events/category/"
    case GetOrganizersList = "organizer/featured-organizer/list/"
    
    case GetEventSearchByCategory = "events/event/search/category/"
    case GetEventSearch = "events/event/search/category/?"
    
    case GetTicketList = "events/ticket-list/"
    case getAddOnList = "events/ticket-add-on-list/"
    
    case GetFeeStructure = "default/data/fee/structure/get/"
    case favoriteEvents = "events/like/unlike/"
}
public enum GroupApiName: String {
    case auth = "auth"
}
struct ResponseCode {
    static let success = 200
    static let sessionExpire = 401
    static let serverError = 500
}
class APIHandler: NSObject {
    static var shared = APIHandler()
    private override init() {}
    private let session = URLSession.shared
    let baseURL = "http://18.118.114.2/"
    private let boundary = "Boundary-\(NSUUID().uuidString)"
    
    
    func executeRequestWith<T: Decodable, U: Encodable>(of type: T.Type = T.self, apiName: APIName, parameters: U?, methodType: MethodType, getURL: String? = "",  authRequired: Bool = true, complition: @escaping(Result<ResponseModal<T>, Error>) -> Void) {
        
        var finalURL = baseURL + apiName.rawValue
        
        if methodType == .GET{
            if let URL = getURL, URL != ""  {
                finalURL = baseURL + URL
            }
        }else if methodType == .POST && parameters == nil{
            if let URL = getURL, URL != ""  {
                finalURL = baseURL + URL
            }
        }
        
        guard var requestURL = URL(string: finalURL) else {
            complition(.failure("Incorrect request URL"))
            return
        }
      finalURL = finalURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        if methodType == .GET{
//            if let URL = getURL, URL != ""  {
//                if #available(iOS 16.0, *) {
//                    requestURL = requestURL.appending(queryItems: [URLQueryItem.init(name: "", value: "39")])
//                } else {
//                    // Fallback on earlier versions
//                }
//            }
//        }
        
        if methodType == .GET{
            if parameters != nil {
              //  if #available(iOS 16.0, *) {
                    let param = try? JSONEncoder().encode(parameters!)
                    do {
                        let json = try JSONSerialization.jsonObject(with: param!, options: []) as? [String : Any]
                       // print("---------------", json ?? "")
//                        requestURL = requestURL.appending(queryItems: [URLQueryItem.init(name: json?.keys.first ?? "", value: (json?.values.first as? String) ?? "")])
                        var queryItems = [URLQueryItem]()
                        for (key, value) in json! {
                            let queryItem = URLQueryItem(name: key, value: "\(value)")
                            queryItems.append(queryItem)
                        }
                        requestURL =  requestURL.appending(queryItems) ?? requestURL
                        
                    } catch {
                        print("errorMsg")
                    }
                    //requestURL = requestURL.appending(queryItems: [URLQueryItem.init(name: param, value: "39")])
//                } else {
//                    // Fallback on earlier versions
//                }
            }
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = methodType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
        
        if authRequired, let token = userModel?.accessToken {
            print("userModel?.accessToken........ ",userModel!.accessToken! )
            request.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
        }
        debugPrint("finalURL is \(finalURL)")
        debugPrint("parameters is \(String(describing: parameters))")
        
        if methodType == .POST{
            if parameters != nil {
                let param = try? JSONEncoder().encode(parameters!)
                request.httpBody = param
            }
        }
        
       
      
        print("\(request.httpMethod ?? "") \(request.url)")
        let str = String(decoding: request.httpBody ?? Data(), as: UTF8.self)
        print("BODY \n \(str)")
        print("HEADERS \n \(request.allHTTPHeaderFields)")
        
        session.dataTask(with: request) { data, response, error in
            var httpStatusCode = 0
            if let httpResponse = response as? HTTPURLResponse {
                httpStatusCode = httpResponse.statusCode
            }
            if error != nil {
                complition(.failure(error?.localizedDescription ?? "Something went wrong"))
            } else {
                if httpStatusCode == 401 {
                    // Refresh Token
                    if let fbData = data {
                        let message = String(decoding: fbData, as: UTF8.self)
                        complition(.failure(message))
                    } else {
                        let message = response?.url?.lastPathComponent
                        complition(.failure("API \(message ?? "") Invlid Response."))
                    }
                } else if httpStatusCode == 200, let data = data {
                    do {
                        let JSON = self.nsdataToJSON(data: data as NSData)
                 print("----------------",JSON)
                        do {
                            let responseModel = try JSONDecoder().decode(ResponseModal<T>.self, from: data)
                            complition(.success(responseModel))
                        }
                        catch{
                            print(error)
                        }
                        
                        
                    } catch {
                        debugPrint(data)
                        complition(.failure("Something went wrong"))
                    }
                } else {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        complition(.failure(json["message"] as? String ?? "something went wrong"))
                    } catch {
                        complition(.failure("Unable to get json."))
                    }
                }
            }
        }.resume()
    }
    
    
    // Api Calling//etc called
    func executeClientRequestWith<U: Encodable>(apiName: String, parameters: U?, methodType: MethodType, authRequired: Bool = true, complition: @escaping(Data?, Error?) -> Void) {
        SVProgressHUD.show()
        let finalURL = baseURL + apiName
        guard let requestURL = URL(string: finalURL) else {
            complition(nil, "Incorrect request URL")
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = methodType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if authRequired, let token = UserDefaults.standard.token {
            request.setValue(token, forHTTPHeaderField: "Authorization")
        }
        debugPrint("finalURL is \(finalURL)")
        debugPrint("parameters is \(String(describing: parameters))")
        if parameters != nil {
            let param = try? JSONEncoder().encode(parameters!)
            request.httpBody = param
        }
        session.dataTask(with: request) { data, response, error in
            var httpStatusCode = 0
            if let httpResponse = response as? HTTPURLResponse {
                httpStatusCode = httpResponse.statusCode
            }
            if error != nil {
                complition(nil, error?.localizedDescription ?? "Something went wrong")
                SVProgressHUD.dismiss()
            } else {
                if httpStatusCode > 200 && httpStatusCode < 500 {
                    // Refresh Token
                    if let fbData = data {
                        let message = String(decoding: fbData, as: UTF8.self)
                        complition(nil, message)
                        SVProgressHUD.dismiss()
                    } else {
                        let message = "Something went wrong with api \(response?.url?.lastPathComponent ?? "")"
                        complition(nil, message)
                        SVProgressHUD.dismiss()
                    }
                } else if httpStatusCode == 200, let data = data {
                    do {
                        complition(data, nil)
                        SVProgressHUD.dismiss()
                    } catch {
                        debugPrint(data)
                        complition(nil, "Something went wrong")
                        SVProgressHUD.dismiss()
                    }
                } else {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        complition(nil , (json["message"] as? String ?? "something went wrong"))
                        SVProgressHUD.dismiss()
                    } catch {
                        complition(nil, "Something went wrong")
                        SVProgressHUD.dismiss()
                    }
                }
            }
        }.resume()
    }
    
    
    func backgroundRequest(apiName: APIName, methodType: MethodType) {
        let strWorkoutId = "RealmDBManager.shared.tasks.last?.workoutId"
        let sem = DispatchSemaphore(value: 0)
        let finalURL = baseURL + apiName.rawValue
        guard let requestURL = URL(string: finalURL) else {
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = UserDefaults.standard.token {
            request.setValue(token, forHTTPHeaderField: "Authorization")
        }
        let params = ["status_id": strWorkoutId]
        if params != nil {
            let param = try? JSONEncoder().encode(params)
            request.httpBody = param
        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            sem.signal()//When task complete then signal will call
        })
        task.resume()
        // sem.signal()
        sem.wait()//waiting until task complete
    }
    func nsdataToJSON(data: NSData) -> AnyObject? {
        do {
            return try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as AnyObject
        } catch let myJSONError {
            debugPrint(myJSONError)
        }
        return nil
    }
}
// You can take this extension outside of that class also
extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}











