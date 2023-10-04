//
//  ManageEventEditProfileVC.swift
//  TicketGateway
//
//  Created by Apple  on 24/05/23.

import UIKit

class ManageEventEditProfileVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var btnCancel: CustomButtonNormal!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var vwNumber: UIView!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var lblDialCountryCode: UILabel!
    @IBOutlet weak var btnSelectCountry: UIButton!

    // MARK: - Variable
    let viewModel = ManageEventEditProfileViewModel()
    let createAccountViewModel = CreateAccountViewModel()
    var name: String = ""
    var number: String = ""
    var email: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()

    }
}
// MARK: - Functions
extension ManageEventEditProfileVC {
    private func setup() {
        self.viewModel.countries = self.jsonSerial()
        self.viewModel.collectCountries()
        [self.btnContinue, self.btnSelectCountry,self.btnCancel].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.txtFullName.delegate = self
        self.txtMobileNumber.delegate = self
        self.txtEmailAddress.delegate = self
        self.btnCancel.setTitles(text: CANCEL, font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .titleColourDarkBlue))
        self.btnContinue.setTitles(text: SAVE_CHANGES, font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
        //self.btnContinue.addRightIcon(image: UIImage(named: SAVE_ICON))
        self.navigationView.lblTitle.text = EDIT_PROFILE
        self.navigationView.btnBack.isHidden = false
        self.navigationView.lblSeprator.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.vwBorder.isHidden = false
        self.txtEmailAddress.textColor = UIColor.setColor(colorType: .tgGrey)
        self.txtMobileNumber.textColor = UIColor.setColor(colorType: .tgGrey)
        self.setIntialUiDesign()
        self.funcSetProfile()
    }
    func setIntialUiDesign()
    {
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
        //Defoult Country
        //UI Changes---
        self.imgCountry.image = nil
        if self.imgCountry.image == nil
        {
            var str = ""
            var arr = viewModel.RScountriesModel.filter({$0.dialCode == str})

            if userModel?.strDialCountryCode != nil && userModel?.strDialCountryCode != ""{
                str = userModel?.strDialCountryCode ?? ""
                arr = viewModel.RScountriesModel.filter({$0.dialCode == str})

                if !arr.indices.contains(0) {
                    str = NSLocale.current.regionCode ?? ""
                    arr = viewModel.RScountriesModel.filter({$0.countryCode == str})
                }
            } else {
                str = NSLocale.current.regionCode ?? ""
                arr = viewModel.RScountriesModel.filter({$0.countryCode == str})
            }

            self.lblDialCountryCode.text = "+91"

            var imagePath = "CountryPicker.bundle/\(str).png"

            if arr.count == 2{
                arr.removeAll { country in
                    country.countryCode != (NSLocale.current.regionCode ?? "")
                }
            }

            if let flagImg = UIImage(named: imagePath) {
                self.imgCountry.image = flagImg
            } else {
                if arr.indices.contains(0) {
                    str = arr[0].countryCode
                    imagePath = "CountryPicker.bundle/\(str).png"
                    self.imgCountry.image = UIImage(named: imagePath)
                }
            }

//            let imagePath = "CountryPicker.bundle/\(str ?? "IN").png"
//            self.imgCountry.image = UIImage(named: imagePath)
//            self.lblDialCountryCode.text = "+91"
//            let arr = viewModel.RScountriesModel.filter({$0.dial_code == str})
            if !arr.isEmpty {
                let country = arr[0]
                self.viewModel.strCountryDialCode = country.dialCode
                self.lblDialCountryCode.text = country.dialCode
                self.viewModel.strCountryCode = country.countryCode
                self.viewModel.strCountryName = country.countryName
                self.lblDialCountryCode.text = country.dialCode
                self.viewModel.strCountryCode = country.countryCode
                let imagePath = "CountryPicker.bundle/\( country.countryCode).png"
                self.imgCountry.image = UIImage(named: imagePath)
            }
        }
        else {
            //noting to do
        }
    }

    func funcSetProfile() {
//        self.txtFullName.text = objAppShareData.userAuth?.fullName
//        self.txtEmailAddress.text = objAppShareData.userAuth?.email
//        self.txtMobileNumber.text = objAppShareData.userAuth?.number
        self.txtFullName.text = name
        self.txtEmailAddress.text = email
        self.txtMobileNumber.text = number
    }
    func updateUserProfileData() {
        if Reachability.isConnectedToNetwork() {
            self.view.showLoading(centreToView: self.view)
            self.viewModel.updateUserProfileData(complition: { isTrue, message in
                if isTrue {
                    self.view.stopLoading()
                    self.navigationController?.popViewController(animated: true)
                } else {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.showToast(message: message)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
}
// MARK: - Actions
extension ManageEventEditProfileVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        case btnCancel:
            self.btnCancelAction()
        case btnSelectCountry:
            self.btnSelectCountryAction()
        default:
            break
        }
    }
    func btnCancelAction() {
        self.navigationController?.popViewController(animated: true)
    }

    func btnContinueAction() {
        // API call for Update user profile data
        viewModel.updateUserModel.name = self.txtFullName.text ?? ""
        updateUserProfileData()
    }
    func btnSelectCountryAction() {
        self.view.endEditing(true)
        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RSCountryPickerController")as! RSCountryPickerController
        sb.RScountryDelegate = self
        sb.strCheckCountry = self.viewModel.strCountryName
        sb.modalPresentationStyle = .fullScreen
        self.navigationController?.present(sb, animated: true, completion: nil)
    }

}
// MARK: - TextFieldDelegate
extension ManageEventEditProfileVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtFullName {
            self.txtEmailAddress.becomeFirstResponder()
        } else if textField == self.txtEmailAddress {
            self.txtMobileNumber.becomeFirstResponder()
        } else if textField == self.txtMobileNumber {
            self.txtMobileNumber.resignFirstResponder()
        }
        return false
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else { return false }
        if textField == txtFullName {
            createAccountViewModel.fullName = text.replacingCharacters(in: textRange, with: string)
        } else if textField == txtMobileNumber {
            createAccountViewModel.mobileNumber = "\(self.lblDialCountryCode.text ?? "" )\(text.replacingCharacters(in: textRange, with: string))"
        } else if textField == txtEmailAddress {
            createAccountViewModel.emailAddress = text.replacingCharacters(in: textRange, with: string)
        }
        return true
    }
}
// MARK: - NavigationBarViewDelegate
extension ManageEventEditProfileVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Country Code
extension ManageEventEditProfileVC :  RSCountrySelectedDelegate  {
    func RScountrySelected(countrySelected country: CountryInfo) {
        let imagePath = "CountryPicker.bundle/\(country.countryCode).png"
        self.imgCountry.image = UIImage(named: imagePath)
        self.viewModel.strCountryDialCode = country.dialCode
        self.lblDialCountryCode.text = country.dialCode
        self.viewModel.strCountryCode = country.countryCode
        self.viewModel.strCountryName = country.countryName
        self.txtMobileNumber.becomeFirstResponder()
    }
}
