//
//  WelocomeLoginSignup.swift
//  TicketGateway
//
//  Created by Apple  on 11/04/23.
//

import UIKit

class WelcomeLoginSignupVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Functions
extension WelcomeLoginSignupVC {
    private func setup() {
        [self.btnSkip, self.btnSignIn, self.btnSignUp].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
    }
}

// MARK: - Actions
extension WelcomeLoginSignupVC {
   
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnSkip:
            self.btnSkipAction()
        case btnSignIn:
            self.btnLoginAction()
        case btnSignUp:
            self.btnSignAction()
            
        default:
            break
        }
   }
    
    func btnLoginAction() {
        let view = self.createView(storyboard: .main, storyboardID: .LoginVC)
        let viewC = view as? LoginVC
        viewC?.viewModel.isFromWelcomeScreen = true
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func btnSkipAction() {
        objSceneDelegate.showTabBar()
    }
    
    func btnSignAction() {
        let view = self.createView(storyboard: .main, storyboardID: .SignUpVC)
        let viewC = view as? SignUpVC
        viewC?.viewModel.isFromWelcomeScreen = true
        self.navigationController?.pushViewController(view, animated: true)
    }
}
