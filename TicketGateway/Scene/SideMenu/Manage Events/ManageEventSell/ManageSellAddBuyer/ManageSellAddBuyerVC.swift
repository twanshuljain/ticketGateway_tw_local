//
//  ManageSellAddBuyerVC.swift
//  TicketGateway
//
//  Created by Apple  on 23/05/23.

import UIKit

class ManageSellAddBuyerVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var btnCancel: CustomButtonNormal!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var vwNumber: UIView!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var lblDialCountryCode: UILabel!
    @IBOutlet weak var btnSelectCountry: UIButton!
    var viewModel = ManageSellAddBuyerViewModel()
    let createAccountViewModel = CreateAccountViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
    }
}
// MARK: - Functions
extension ManageSellAddBuyerVC {
    private func setup() {
        self.viewModel.countries = self.jsonSerial()
        self.viewModel.collectCountries()
        [self.btnContinue, self.btnSelectCountry, self.btnCancel].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.txtFullName.delegate = self
        self.txtMobileNumber.delegate = self
        self.txtEmailAddress.delegate = self
        self.txtLastName.delegate = self
        self.txtFullName.text = viewModel.toupleBuyerInfoData.strNameValue
        self.txtMobileNumber.text = viewModel.toupleBuyerInfoData.strNumberValue
        self.txtEmailAddress.text = viewModel.toupleBuyerInfoData.strEmailValue
        if self.viewModel.isFromAddInfo == true {
            self.btnCancel.setTitles(text: CANCEL, font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .placeHolder))
            self.btnCancel.addLeftIcon(image: UIImage(named: X_ICON))
            self.btnContinue.setTitles(text: SAVE, font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
            self.btnContinue.addRightIcon(image: UIImage(named: ""))
        } else {
            self.btnCancel.setTitles(text: PREVIOUS, font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .placeHolder))
            self.btnCancel.addLeftIcon(image: UIImage(named: LEFT_ARROW_ICON))
            self.btnContinue.setTitles(text: NEXT, font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
            self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        }
        self.btnCancel.layer.cornerRadius = 5
        self.navigationView.lblTitle.text = BUYESR_INFO
        self.navigationView.btnBack.isHidden = false
        self.navigationView.lblSeprator.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.vwBorder.isHidden = false
        self.setIntialUiDesign()
    }
    func setIntialUiDesign() {
        //Default Country
        //UI Changes---
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
        self.imgCountry.image = nil
//        if self.imgCountry.image == nil {
//            let str = NSLocale.current.regionCode
//            let imagePath = "CountryPicker.bundle/\(str ?? "IN").png"
//            self.imgCountry.image = UIImage(named: imagePath)
//            self.lblDialCountryCode.text = "+91"
//            let arr = viewModel.RScountriesModel.filter({$0.dial_code == str})
//            if arr.count>0 {
//                let country = arr[0]
//                viewModel.strCountryDialCode = country.dial_code
//                self.lblDialCountryCode.text = country.dial_code
//                self.viewModel.strCountryCode = country.countryCode
//                self.viewModel.strCountryName = country.country_name
//                self.lblDialCountryCode.text = country.dial_code
//                self.viewModel.strCountryCode = country.countryCode
//                let imagePath = "CountryPicker.bundle/\( country.countryCode).png"
//                self.imgCountry.image = UIImage(named: imagePath)
//            }
//        } else {
//        }
        if self.imgCountry.image == nil {
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
        } else {
            // noting to do
        }
    }
}
// MARK: - Actions
extension ManageSellAddBuyerVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        case btnCancel:
            self.btnContinueAction()
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
        if viewModel.isFromAddInfo == true {
            self.navigationController?.popViewController(animated: true)
        } else {
            let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellTicketSuccessfully) as? ManageSellTicketSuccessfully
            self.navigationController?.pushViewController(view ?? UIViewController(), animated: true)
        }
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
extension ManageSellAddBuyerVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtFullName {
            self.txtLastName.becomeFirstResponder()
        } else if textField == self.txtLastName {
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
        } else if textField == txtLastName {
            createAccountViewModel.password = text.replacingCharacters(in: textRange, with: string)
        }
        return true
    }
}
// MARK: - NavigationBarViewDelegate
extension ManageSellAddBuyerVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Country Code
extension ManageSellAddBuyerVC: RSCountrySelectedDelegate {
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
