//
//  LoginNmberWithEmailVC.swift
//  TicketGateway
//
//  Created by Apple  on 25/04/23.
// swiftlint: disable line_length

import UIKit
import SVProgressHUD

class LoginNmberWithEmailVC: UIViewController, NavigationBarViewDelegate {
    // MARK: - Outlets
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var imgCountryCode: UIImageView!
    @IBOutlet weak var lblCountryDialCode: UILabel!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var lblHeadingDescription: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var tblEmailList: UITableView!
    @IBOutlet weak var lblSelectEmail: UILabel!
    // MARK: - Variable
    var viewModel: LoginNmberWithEmailViewModel?
    var isComingFrom: IsComingFrom  = .Login
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = LoginNmberWithEmailViewModel(loginVC: self)
        setup()
        // Do any additional setup after loading the view.
    }
}
// MARK: - Functions
extension LoginNmberWithEmailVC {
    private func setup() {
        [self.btnContinue].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        let imagePath = "CountryPicker.bundle/\(objAppShareData.dicToHoldDataOnSignUpModule?.strCountryCode ?? "").png"
        self.imgCountryCode.image = UIImage(named: imagePath)
        self.txtNumber.text = objAppShareData.dicToHoldDataOnSignUpModule?.strNumber ?? ""
        self.lblCountryDialCode.text = objAppShareData.dicToHoldDataOnSignUpModule?.strDialCountryCode ?? ""
        self.tblEmailList.dataSource = self
        self.tblEmailList.delegate = self
        self.tblEmailList.reloadData()
        self.btnContinue.setTitles(text: TITLE_CONTINUE, font: .systemFont(ofSize: 14), tintColour: .black)
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        navigationView.lblTitle.text = TITLE_LOGIN
        navigationView.btnBack.isHidden = false
        navigationView.delegateBarAction = self
        self.viewModel?.strSelectedEmail =  self.viewModel?.arrMail.first?.email ?? "test1@gmail.com"
        self.lblMobileNumber.text = MOBILE_NUMBER
        self.lblSelectEmail.text =  SELECT_THE_EMAIL_ACCOUNT
    }
}

// MARK: - Actions
extension LoginNmberWithEmailVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        default:
            break
        }
    }
    func btnContinueAction() {
        if Reachability.isConnectedToNetwork() {
            SVProgressHUD.show()
            viewModel?.signInAPI { isTrue, messageShowToast in
                if isTrue == true {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        if self.isComingFrom == .Login{
                            objSceneDelegate.showTabBar()
                        }else{
                            
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.showToast(message: messageShowToast)
                    }
                }
            }
        } else {
            self.showToast(message: ValidationConstantStrings.networkLost)
        }
    }
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LoginNmberWithEmailVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.arrMail.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "LoginNmberWithEmailCell", for: indexPath) as? LoginNmberWithEmailCell)!
        let obj = self.viewModel?.arrMail[indexPath.row]
        cell.lblName.text = obj?.name
        cell.lblEmail.text = obj?.email
        cell.lblShortName.text = self.viewModel?.funcpersonNameComponents(strValue: obj?.name ?? "")
        if self.viewModel?.strSelectedEmail == obj?.email {
            cell.imageView?.image =  UIImage(named: ACTIVE_ICON)
        } else {
            cell.imageView?.image =  UIImage(named: UNACTIVE_ICON)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.viewModel?.arrMail[indexPath.row]
        self.viewModel?.strSelectedEmail = obj?.email ?? ""
        self.tblEmailList.reloadData()
    }
}
