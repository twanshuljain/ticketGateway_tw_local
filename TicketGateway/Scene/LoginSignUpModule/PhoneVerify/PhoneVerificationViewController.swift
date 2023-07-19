//
//  PhoneVerificationViewController.swift
//  TicketGateway
//
//  Created by Apple on 04/07/23.
// swiftlint: disable line_length
import UIKit
import SVProgressHUD
class PhoneVerificationViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var btnSelectCountry: UIButton!
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var lblDialCountryCode: UILabel!
    @IBOutlet weak var vwNumber: UIView!
    // MARK: - Variable
    var viewModel = SignInViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setIntialUiDesign()
    }
}
// MARK: - Functions
extension PhoneVerificationViewController {
    private func setup() {
        navigationView.lblTitle.text = PHONE_VERIFICATION
        navigationView.btnBack.isHidden = false
        navigationView.delegateBarAction = self
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        btnContinue.setTitles(text: TITLE_CONTINUE, font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
        self.viewModel.countries = self.jsonSerial()
        self.imgCountry.image = nil
        self.txtNumber.delegate = self
        self.vwNumber.layer.cornerRadius = 5
        self.vwNumber.layer.borderWidth = 0.5
        self.vwNumber.layer.borderColor = UIColor.lightGray.cgColor
        self.txtNumber.text = ""
        self.viewModel.isForEmail = false
    }
}

// MARK: - Actions
extension PhoneVerificationViewController {
    @IBAction func btnSelectCountryAction(_ sender: UIButton) {
        self.view.endEditing(true)
        let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RSCountryPickerController")as? RSCountryPickerController
        storyBoard?.RScountryDelegate = self
        storyBoard?.strCheckCountry = self.viewModel.strCountryName
        storyBoard?.modalPresentationStyle = .fullScreen
        self.navigationController?.present(storyBoard ?? UIViewController(), animated: true, completion: nil)
    }
    @IBAction func btnContinueAction(_ sender: UIButton) {
        let view = self.createView(storyboard: .main, storyboardID: .OtpNumberVC) as? OtpNumberVC
        let obj =   DataHoldOnSignUpProcessModel.init(strEmail: "", strNumber: self.txtNumber.text ?? "", strStatus: "", strDialCountryCode: self.lblDialCountryCode.text!, strCountryCode: self.viewModel.strCountryCode)
        objAppShareData.dicToHoldDataOnSignUpModule = obj
        view?.isComingFromLogin = false
        view?.viewModel.number = "\(lblDialCountryCode.text ?? "") " + "-" + (self.txtNumber.text ?? "")
        self.navigationController?.pushViewController(view ?? UIViewController(), animated: true)
    }
}

// MARK: - RSCountrySelectedDelegate
extension PhoneVerificationViewController: RSCountrySelectedDelegate {
    func setIntialUiDesign() {
        self.txtNumber.addDoneButtonOnKeyboard()
        // Defoult Country
        // UI Changes---
        self.imgCountry.image = nil
        if self.imgCountry.image == nil {
            let str = NSLocale.current.regionCode
            let imagePath = "CountryPicker.bundle/\(str ?? "IN").png"
            self.imgCountry.image = UIImage(named: imagePath)
            self.lblDialCountryCode.text = "+91"
            let arr = viewModel.RScountriesModel.filter({$0.country_code == str})
            if arr.count>0 {
                let country = arr[0]
                self.viewModel.strCountryDialCode = country.dial_code
                self.lblDialCountryCode.text = country.dial_code
                self.viewModel.strCountryCode = country.country_code
                self.viewModel.strCountryName = country.country_name
                self.lblDialCountryCode.text = country.dial_code
                self.viewModel.strCountryCode = country.country_code
                let imagePath = "CountryPicker.bundle/\( country.country_code).png"
                self.imgCountry.image = UIImage(named: imagePath)
            }
        } else {
            // noting to do
        }
    }
    func collectCountries() {
        for country in viewModel.countries {
            let code = country["code"] ?? ""
            let name = country["name"] ?? ""
            let dailcode = country["dial_code"] ?? ""
            viewModel.RScountriesModel.append(CountryInfo(country_code: code, dial_code: dailcode, country_name: name))
        }
    }
    func RScountrySelected(countrySelected country: CountryInfo) {
        let imagePath = "CountryPicker.bundle/\(country.country_code).png"
        self.imgCountry.image = UIImage(named: imagePath)
        self.viewModel.strCountryDialCode = country.dial_code
        self.lblDialCountryCode.text = country.dial_code
        self.viewModel.strCountryCode = country.country_code
        self.viewModel.strCountryName = country.country_name
        self.txtNumber.becomeFirstResponder()
    }
}
// MARK: - UITextFieldDelegate
extension PhoneVerificationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if  textField == self.txtNumber {
            self.txtNumber.resignFirstResponder()
        }
        return false
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else { return false }
        if textField == txtNumber {
            viewModel.number = "\(self.lblDialCountryCode.text ?? "" )\(text.replacingCharacters(in: textRange, with: string))"
        }
        return true
    }
}
// MARK: - NavigationBarViewDelegate
extension PhoneVerificationViewController: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
