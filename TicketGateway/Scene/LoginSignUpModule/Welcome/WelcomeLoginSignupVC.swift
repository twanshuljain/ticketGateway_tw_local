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
    @IBOutlet weak var lblTicketgatewayCom: UILabel!
    @IBOutlet weak var lblJoinTheMillon: UILabel!
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setUI()
    }
    
    // MARK: - Custom Functions
    func setUI() {
        lblTicketgatewayCom.text = WELCOME_TITLE
        lblJoinTheMillon.text = WELCOME_DESCRIPTION
        btnSkip.titleLabel?.text = SKIP
        btnSignIn.titleLabel?.text = SIGN_IN
        btnSignUp.titleLabel?.text = NEW_HERE
    }
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
        UserDefaultManager.share.guestUserLogin(value: false, key: .isGuestLogin)
        let view = self.createView(storyboard: .main, storyboardID: .LoginVC)
        let viewC = view as? LoginVC
        viewC?.viewModel.isFromWelcomeScreen = true
        self.navigationController?.pushViewController(view, animated: true)
    }
    func btnSkipAction() {
        UserDefaultManager.share.guestUserLogin(value: true, key: .isGuestLogin)
        objSceneDelegate.showTabBar()
    }
    func btnSignAction() {
        UserDefaultManager.share.guestUserLogin(value: false, key: .isGuestLogin)
        let view = self.createView(storyboard: .main, storyboardID: .SignUpVC)
        let viewC = view as? SignUpVC
        viewC?.viewModel.isFromWelcomeScreen = true
        UserDefaultManager.share.guestUserLogin(value: false, key: .isGuestLogin)
        self.navigationController?.pushViewController(view, animated: true)
    }
}
