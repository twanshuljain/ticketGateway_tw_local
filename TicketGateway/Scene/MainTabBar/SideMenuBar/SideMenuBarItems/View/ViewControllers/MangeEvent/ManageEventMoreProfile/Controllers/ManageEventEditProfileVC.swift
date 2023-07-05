//
//  ManageEventEditProfileVC.swift
//  TicketGateway
//
//  Created by Apple  on 24/05/23.
//

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
    let viewModel = CreateAccountViewModel()
    var isFromWelcomeScreen = false
    var strCountryDialCode: String = "+91"
    var strCountryCode: String = "IN"
    var strCountryName: String = "India"
    var countries = [[String: String]]()
    var RScountriesModel = [CountryInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
    }
}
// MARK: - Functions
extension ManageEventEditProfileVC {
    private func setup() {
        self.jsonSerial()
        self.collectCountries()
        [self.btnContinue, self.btnSelectCountry,self.btnCancel].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.txtFullName.delegate = self
        self.txtMobileNumber.delegate = self
        self.txtEmailAddress.delegate = self
        self.btnCancel.setTitles(text: "Cancel", font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .TiitleColourDarkBlue))
        self.btnContinue.setTitles(text: "Save changes", font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
        btnContinue.addRightIcon(image: UIImage(named: "Save"))
        navigationView.lblTitle.text = "Edit Profile"
        navigationView.btnBack.isHidden = false
        navigationView.lblSeprator.isHidden = false
        navigationView.delegateBarAction = self
        self.navigationView.vwBorder.isHidden = false
        
        self.setIntialUiDesign()
        self.funcSetProfile()
    }
    
    func funcSetProfile(){
        self.txtFullName.text = objAppShareData.userAuth?.fullName
        self.txtEmailAddress.text = objAppShareData.userAuth?.email
        self.txtMobileNumber.text = objAppShareData.userAuth?.number
    }
}
// MARK: - Actions
extension ManageEventEditProfileVC {
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
        self.navigationController?.popViewController(animated: true)
    }
    func btnSelectCountryAction(){
        self.view.endEditing(true)
        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RSCountryPickerController")as! RSCountryPickerController
        sb.RScountryDelegate = self
        sb.strCheckCountry = self.strCountryName
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
            viewModel.fullName = text.replacingCharacters(in: textRange, with: string)
        } else if textField == txtMobileNumber {
            viewModel.mobileNumber = "\(self.lblDialCountryCode.text ?? "" )\(text.replacingCharacters(in: textRange, with: string))"
        }else if textField == txtEmailAddress {
            viewModel.emailAddress = text.replacingCharacters(in: textRange, with: string)
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

/// /MARK: - Country Code
extension ManageEventEditProfileVC :  RSCountrySelectedDelegate  {
    func setIntialUiDesign()
    {
        //Defoult Country
        //UI Changes---
        self.imgCountry.image = nil
        if self.imgCountry.image == nil
        {
            let str = NSLocale.current.regionCode
            let imagePath = "CountryPicker.bundle/\(str ?? "IN").png"
            self.imgCountry.image = UIImage(named: imagePath)
            self.lblDialCountryCode.text = "+91"
            let arr = RScountriesModel.filter({$0.dial_code == str})
            
            if arr.count>0{
                let country = arr[0]
                strCountryDialCode = country.dial_code
                self.lblDialCountryCode.text = country.dial_code
                self.strCountryCode = country.country_code
                self.strCountryName = country.country_name
                self.lblDialCountryCode.text = country.dial_code
                self.strCountryCode = country.country_code
                let imagePath = "CountryPicker.bundle/\( country.country_code).png"
                self.imgCountry.image = UIImage(named: imagePath)
            }
        }
        else{
            //noting to do
        }
    }
    func jsonSerial() {
        let data = try? Data(contentsOf: URL(fileURLWithPath: (Bundle.main.path(forResource: "countries", ofType: "json"))!))
        do {
            let parsedObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            countries = parsedObject as! [[String : String]]
            
        }catch{
            
        }
    }
    
    func collectCountries() {
        for country in countries  {
            let code = country["code"] ?? ""
            let name = country["name"] ?? ""
            let dailcode = country["dial_code"] ?? ""
            RScountriesModel.append(CountryInfo(country_code:code,dial_code:dailcode, country_name:name))
        }
    }
    
    func RScountrySelected(countrySelected country: CountryInfo) {
        let imagePath = "CountryPicker.bundle/\(country.country_code).png"
        self.imgCountry.image = UIImage(named: imagePath)
        self.strCountryDialCode = country.dial_code
        self.lblDialCountryCode.text = country.dial_code
        self.strCountryCode = country.country_code
        self.strCountryName = country.country_name
        self.txtMobileNumber.becomeFirstResponder()
    }
}


















