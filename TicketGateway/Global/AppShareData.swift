//
//  AppShareData.swift
//  TicketGateway
//
//  Created by Apple  on 20/04/23.
//

import UIKit
import Foundation

let objAppShareData = AppShareData.sharedObject()
class AppShareData {
    // MARK: All Properties
    private var numOfPageKey: String = "NumberOfPage"
    private let session = URLSession.shared
    //MARK: - Shared object
    private static var sharedManager: AppShareData = {
        let manager = AppShareData()
        //        var strUSERID : String = ""
        return manager
    }()
    // MARK: - Accessors
    class func sharedObject() -> AppShareData {
        return sharedManager
    }
    // NewVariable
    var dicToHoldDataOnSignUpModule : DataHoldOnSignUpProcessModel?
    var userAuth = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
    
    func saveNumOfPage(numOfPage: Int) {
        UserDefaults.standard.set(numOfPage, forKey: numOfPageKey)
    }
    
    func setRootToHomeVCAndMoveToFAQ() {
        guard let objHomeViewController = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else {
            return
        }
       let navigationController = UINavigationController(rootViewController: objHomeViewController)
       navigationController.isNavigationBarHidden = true
       //selectedTabBarIndex = selectedIndex
       UIApplication.shared.windows.first?.rootViewController = navigationController
       UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        guard let objFAQController = UIStoryboard.init(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "FAQVC") as? FAQVC else {
            return
        }
        navigationController.pushViewController(objFAQController, animated: false)
    }
    func updateUserProfile(isForImage: Bool = false, methodType: MethodType, parameters: UpdateUserModel, completion: @escaping (Result<GetUserProfileModel, Error>) -> Void) {
        let boundary = "Boundary-\(NSUUID().uuidString)"
        guard let requestURL = URL(string: "http://3.21.114.70/auth/user/update/profile/") else {
            completion(.failure("invalid url"))
            return
        }
        print("requestURL", requestURL)
        var request = URLRequest(url: requestURL)
        request.httpMethod = methodType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
        
        if let token = userModel?.accessToken {
            print("userModel?.accessToken........ ",userModel!.accessToken! )
            request.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
        }
        if isForImage {
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        } else {
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
            request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language")
        }
        var body = Data()
        if !isForImage {
            // User name update
            let param = ["full_name": parameters.name]
            let postString = getPostString(params: param)
            request.httpBody = postString.data(using: .utf8)
        } else {
            // Image field
            let image = parameters.image // Replace with your actual image
            guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                print("Error converting image to data")
                return
            }
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.png\"\r\n")
            body.append("Content-Type: image/png\r\n\r\n")
            body.append(imageData)
            body.append("\r\n")
            body.append("--\(boundary)--\r\n")
            request.httpBody = body
        }
        session.dataTask(with: request) { data, response, error in
            var httpStatusCode = 0
            if let httpResponse = response as? HTTPURLResponse {
                httpStatusCode = httpResponse.statusCode
            }
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "Something went wrong"))
            } else {
                if httpStatusCode == 401 {
                    // Refresh Token
                    if let fbData = data {
                        let message = String(decoding: fbData, as: UTF8.self)
                        completion(.failure(message))
                    } else {
                        let message = response?.url?.lastPathComponent
                        completion(.failure("API \(message ?? "") Invalid Response."))
                    }
                } else if httpStatusCode == 200, let data = data {
                    let JSON = self.nsdataToJSON(data: data as NSData)
                    print("----------------JSON in APIClient",JSON as Any)
                    do {
                        let responseModel = try JSONDecoder().decode(GetUserProfileModel.self, from: data)
                        completion(.success(responseModel))
                    }
                    catch{
                        print(error)
                    }
                } else {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        completion(.failure(json["message"] as? String ?? "something went wrong"))
                    } catch {
                        completion(.failure("Unable to get json."))
                    }
                }
            }
        }.resume()
    }
    func nsdataToJSON(data: NSData) -> AnyObject? {
        do {
            return try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as AnyObject
        } catch let myJSONError {
            debugPrint(myJSONError)
        }
        return nil
    }
    func getPostString(params:[String:Any]) -> String {
        var data = [String]()
        for(key, value) in params {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    // MARK: Comman Like/Dislike API Functions
    func commanEventLikeApiCall(
        likeStatus: Bool,
        eventId: Int,
        completion: @escaping (Bool, String) -> Void
    ) {
        print("eventId:- \(eventId), likeStatus:- \(likeStatus)")
        let param = FavoriteRequestModel(event_id: eventId, like_status: likeStatus)
        APIHandler.shared.executeRequestWith(apiName: .favoriteEvents, parameters: param, methodType: .POST) { (result: Result<ResponseModal<GetEventModel>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        // Setting "true" to userDefault object for knowing on HomeTab to refresh event list.
                        UserDefaultManager.share.setIsLikedAnyEvent(isLikedAnyEvent: true)
                        if let message = response.message {
                            print("success like api")
                            completion(true, message)
                        }
                    }
                }
            case .failure(let error):
                print("failure like api, Error:", error)
                completion(false, error as? String ?? "")
            }
        }
    }
    // MARK: Comman Follow/Unfollow API Functions
    func commanFollowUnfollowApi(organizerId: Int, complition: @escaping (Bool, String) -> Void) {
        let api = APIName.followUnfollow.rawValue + "\(organizerId)/"
        print("organizerId:- \(organizerId)")
        APIHandler.shared.executeRequestWith(apiName: .followUnfollow, parameters: EmptyModel?.none, methodType: .POST, getURL: api, authRequired: true, authTokenString: true) { (result: Result<ResponseModal<EventDetail>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    print("Follow api success")
                    complition(true, response.message ?? "")
                } else {
                    complition(false, response.message ?? "Error message")
                }
            case .failure(let error):
                complition(false, "\(error)")
            }
        }
    }
    
    func getTicketCurrency(currencyType:String) -> String{
        if currencyType == "EUR"{
            return currencyType
        }else if currencyType == "CAD"{
            return "\(currencyType)$"
        }else if currencyType == "INR"{
            return currencyType
        }
        return "CAD$"
    }
}
