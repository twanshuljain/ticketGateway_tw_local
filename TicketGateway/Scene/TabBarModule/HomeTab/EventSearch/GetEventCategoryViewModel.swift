//
//  GetEventCategoryViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 05/06/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count

import UIKit
import SVProgressHUD


final class GetEventCategoryViewModel {
    
    //MARK: - Variables
    var arrCategoryData : [GetEventCategoryModel] = [GetEventCategoryModel]()
    var arrSearchCategoryData = [GetEventModel]()
    var arrSearchData = [GetEventModel]()
}

//MARK: - Functions
extension GetEventCategoryViewModel {
    func funcCallApi(vc:EventSearchHomeVC?){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            vc?.view.showLoading(centreToView: vc?.view ?? UIView())
            self.GetEventCategoryApi(complition: { isTrue, messageShowToast in
                if isTrue == true {
                    DispatchQueue.main.async {
                        vc?.view.stopLoading()
                        vc?.collVwEvent.arrData = self.arrCategoryData
                        vc?.collVwEventSubCategory.arrData = self.arrCategoryData
                        vc?.collVwEvent.reloadData()
                        vc?.collVwEventSubCategory.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        vc?.view.stopLoading()
                        vc?.showToast(message: messageShowToast)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                vc?.view.stopLoading()
                vc?.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
    
    func GetEventCategoryApi(complition: @escaping (Bool,String) -> Void ) {
        
        APIHandler.shared.executeRequestWith(apiName: .getEventCategoryList, parameters: EmptyModel?.none, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<[GetEventCategoryModel]>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    print("response....",response)
                    DispatchQueue.main.async {
                        if let categoryData = response.data {
                            self.arrCategoryData = categoryData

                        }
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
    
    func getEventSearchCategoryApi(category: String, complition: @escaping (Bool,String) -> Void ) {
        let parameters =  GetEventSearchByCategoryRequest(category: category)
        APIHandler.shared.executeRequestWith(apiName: .getEventSearchByCategory, parameters: parameters, methodType: .GET, authRequired: true) { (result: Result<ResponseModal<[GetEventModel]>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        if let categorySearchData = response.data {
                            self.arrSearchCategoryData = categorySearchData
                            print("----------------",self.arrSearchCategoryData)
                        }
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
    
    
    func getEventSearchApi(searchText: String, complition: @escaping (Bool,String) -> Void ) {
        let parameters =  GetEventSearch(search_key: searchText)
        APIHandler.shared.executeRequestWith(apiName: .getEventSearch, parameters: parameters, methodType: .GET, authRequired: true) { (result: Result<ResponseModal<SearchModel>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                  //  DispatchQueue.main.async {
                    if let searchData = response.data?.items {
                            self.arrSearchData = searchData
                        }
                        complition(true, response.message ?? "")
                  //  }
                  //  complition(true, response.message ?? "")
                }else{
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                
                complition(false,"\(error)")
            }
        }
    }
  
}
