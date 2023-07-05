//
//  GoogleSignInVC.swift
//  TicketGateway
//
//  Created by Apple  on 24/04/23.
//

import UIKit
import GoogleSignIn
import FacebookLogin
import AuthenticationServices


final class SocialSignInVC : UIViewController{
    
    // MARK: - Variable
    var viewModel = SocialSignInViewModel()
    
    
    // MARK: - Functions
    func funGoogleSignIn(uiviewController : UIViewController){
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: GOOGLE_CLIENT_ID)
                
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: uiviewController) { signInResult, error in
            
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            let user = signInResult.user
            self.viewModel.strUserID  = user.userID ?? ""
            print(self.viewModel.strUserID  )
            
            self.viewModel.strEmail = user.profile?.email ?? ""
            print(self.viewModel.strEmail )
            
            let strName = user.profile?.name ?? ""
            print(self.viewModel.strName)
            
            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            self.viewModel.strProfile = "\(profilePicUrl!)"
            print(self.viewModel.strProfile )
            
            let givenName = user.profile?.givenName
            print(givenName ?? "" )
            
            let familyName = user.profile?.familyName
            print(familyName ?? "")
            
            }
        let obj = DataHoldOnSocialSignUpProcessModel(strEmail: self.viewModel.strEmail,strNumber: self.viewModel.strNumber, strStatus: "", strDialCountryCode: "", strCountryCode: "", strName: self.viewModel.strName,strProfile:"" )
        }
            
            func funcFaceBookSignIn(uiviewController : UIViewController) {
                let fbloginManger: LoginManager = LoginManager()
                fbloginManger.logIn(permissions: ["email","public_profile"], from: uiviewController) { (result, error) -> Void in
                    if(error == nil){
                        let fbLoginResult: LoginManagerLoginResult  = result!
                        
                        if( result?.isCancelled)!{
                            return }
                        if(fbLoginResult .grantedPermissions.contains("email")){
                            self.getFbId()
                        }
                        }
                }
             }
            func getFbId(){
                let requestMe: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "picture.type(large), name, gender, email, first_name, last_name,birthday"])
                let connection: GraphRequestConnection = GraphRequestConnection()
                connection.add(requestMe) { (FBSDKGraphRequestConnection, result, error) in
                    if (result != nil){
                        let dicFbData: NSDictionary = result as! NSDictionary
                        print("dicFbData \(dicFbData)")
                        print(dicFbData["first_name"] as? String)
                        DispatchQueue.main.async(execute: {
                            
                        })
                    }else{
                        DispatchQueue.main.async(execute: {
                            
                        })
                    }
                };
                connection.start()
            }
    }

extension UIViewController : ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding

{
    // MARK: - Apple
    @available(iOS 13.0, *)
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    @available(iOS 13.0, *)
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
       
        
        switch authorization.credential {
            
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userid = appleIDCredential.user
            let email = appleIDCredential.email
            let firstName = appleIDCredential.fullName?.givenName
            let lastName = appleIDCredential.fullName?.familyName
      //      let fullName = firstName + " " + lastName
//            Keychain.userid = userid
//            Keychain.firstName = firstName
//            Keychain.lastName = lastName
//            Keychain.email = email
//            let obj =  SocialSignupDataModel.init(socialToken: "", socialUserId: userid, socialType: "3", socialName:  fullName, socialEmail: email, socialNumber: "", socialFullname: fullName , socialImage: "")
//            objAppShareData.DicSocialSignUpData = obj
//            self.Call_ForWebService_CheckSocialSatuts(strSocialType: "3")
            
            case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            print(username)
            print(password)
            
           
           
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                // self.showPasswordCredentialAlert(username: username, password: password)
            }
            
        default:
            break
        }
    }
    
    func funcAppleLoginIntegration(uiviewController : UIViewController)
    {
        if #available(iOS 13.0, *) {
            //  objWebserviceManager.StartIndicator()
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = uiviewController as any ASAuthorizationControllerDelegate
            authorizationController.presentationContextProvider = uiviewController as any ASAuthorizationControllerPresentationContextProviding
            authorizationController.performRequests()
        } else {
            
        }
    }
    
}
