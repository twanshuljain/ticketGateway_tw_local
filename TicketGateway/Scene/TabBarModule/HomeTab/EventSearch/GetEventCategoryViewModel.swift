//
//  GetEventCategoryViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 05/06/23.
//

import UIKit
import SVProgressHUD


final class GetEventCategoryViewModel {
    
    //MARK: - Variables
    var arrCategoryData : [GetEventCategoryModel] = [GetEventCategoryModel]()
    
}

//MARK: - Functions
extension GetEventCategoryViewModel {
    func funcCallApi(vc:EventSearchHomeVC?){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            self.GetEventCategoryApi(complition: { isTrue, messageShowToast in
                if isTrue == true {
                    SVProgressHUD.dismiss()
                    DispatchQueue.main.async {
                        vc?.collVwEvent.arrData = self.arrCategoryData
                        vc?.collVwEventSubCategory.arrData = self.arrCategoryData
                        vc?.collVwEvent.reloadData()
                        vc?.collVwEventSubCategory.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        vc?.showToast(message: messageShowToast)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                vc?.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
    
    func GetEventCategoryApi(complition: @escaping (Bool,String) -> Void ) {
        
        APIHandler.shared.executeRequestWith(apiName: .GetEventCategoryList, parameters: EmptyModel?.none, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<[GetEventCategoryModel]>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    print("response....",response)
                    DispatchQueue.main.async {
                        self.arrCategoryData = response.data!
                        print(self.arrCategoryData)
                        complition(true, response.message ?? "")
                    }
                    complition(true, response.message ?? "")
                }else{
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                complition(false,"\(error)")
            }
        }
    }
    
    func newGetEventCategoryApi(completion: @escaping(Bool, String) -> Void) {
        APIHandler.shared.executeRequestWith(apiName: .GetEventCategoryList, parameters: EmptyModel?.none, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<[GetEventCategoryModel]>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    print("response....",response)
                    DispatchQueue.main.async {
                        self.arrCategoryData = response.data!
                        print(self.arrCategoryData)
                        completion(true, response.message ?? "")
                    }
                    completion(true, response.message ?? "")
                }else{
                    completion(false,response.message ?? "error message")
                }
            case .failure(let error):
                completion(false,"\(error)")
            }
        }
        
    }
    
}
