//
//  ManageEventProfileViewModel.swift
//  TicketGateway
//
//  Created by apple on 8/31/23.
//

import Foundation
final class ManageEventProfileViewModel {
    // MARK: All Properties
    var getUserProfileData = GetUserProfileModel()
    var updateUserModel = UpdateUserModel()
    // MARK: Custom Functions
    func getUserProfileData(complition: @escaping (Bool, String) -> Void ) {
        APIHandler.shared.executeRequestWith(apiName: .getUserProfileData, parameters: EmptyModel?.none, methodType: .GET) { (result: Result<ResponseModal<GetUserProfileModel>, Error>) in
            switch result {
            case .success(let response):
                print("response....",response)
                DispatchQueue.main.async {
                    if let data = response.data {
                        self.getUserProfileData = data
                    }
                    self.updateProfile()
                    complition(true, "success")
                }
            case .failure(let error):
                complition(false,"\(error)")
            }
        }
    }
    func updateUserProfileData(complition: @escaping (Bool, String) -> Void ) {
        AppShareData.sharedObject().updateUserProfile(isForImage: true, methodType: .POST, parameters: updateUserModel) { (result: Result<GetUserProfileModel, Error>) in
            switch result {
            case .success(let response):
                print("response....",response)
                DispatchQueue.main.async {
                    self.getUserProfileData = response
                    complition(true, "success")
                }
            case .failure(let error):
                complition(false,"\(error)")
            }
        }
    }
    
    func updateProfile(){
        var userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
        userModel?.image = self.getUserProfileData.userData?.image ?? ""
        userModel?.fullName = self.getUserProfileData.userData?.fullName ?? ""
        UserDefaultManager.share.storeModelToUserDefault(userData: userModel, key: .userAuthData)
    }
}
