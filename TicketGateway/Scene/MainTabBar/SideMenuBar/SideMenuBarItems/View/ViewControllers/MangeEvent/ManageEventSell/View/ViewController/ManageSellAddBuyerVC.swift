//
//  ManageSellAddBuyerVC.swift
//  TicketGateway
//
//  Created by Apple  on 23/05/23.
//

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
    
    
    // MARK: - Variable
    let viewModel = CreateAccountViewModel()
    var isFromWelcomeScreen = false
    var strCountryDialCode: String = "+91"
    var strCountryCode: String = "IN"
    var strCountryName: String = "India"
    var countries = [[String: String]]()
    var RScountriesModel = [CountryInfo]()
    var isFromAddInfo = false
    
    var ToupleBuyerInfoData = (strNameValue:"",strEmailValue:"",strNumberValue:"",strCountryCodeValue:"",strDialCodeValue:"")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
    }
}
// MARK: - Functions
extension ManageSellAddBuyerVC {
    private func setup() {
        self.jsonSerial()
        self.collectCountries()
        [self.btnContinue, self.btnSelectCountry,self.btnCancel].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.txtFullName.delegate = self
        self.txtMobileNumber.delegate = self
        self.txtEmailAddress.delegate = self
        self.txtLastName.delegate = self
        self.txtFullName.text = ToupleBuyerInfoData.strNameValue
        self.txtMobileNumber.text = ToupleBuyerInfoData.strNumberValue
        self.txtEmailAddress.text = ToupleBuyerInfoData.strEmailValue
        if self.isFromAddInfo == true{
            self.btnCancel.setTitles(text: "Cancel", font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .PlaceHolder))
            self.btnCancel.addLeftIcon(image: UIImage(named: "x"))
            self.btnContinue.setTitles(text: "Save", font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
            self.btnContinue.addRightIcon(image: UIImage(named: ""))
        } else {
            self.btnCancel.setTitles(text: "Previeous", font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .PlaceHolder))
            self.btnCancel.addLeftIcon(image: UIImage(named: "arrow left"))
            self.btnContinue.setTitles(text: "Next", font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
            self.btnContinue.addRightIcon(image: UIImage(named: "arrow right"))
        }
        
        
        self.btnCancel.layer.cornerRadius = 5
        self.navigationView.lblTitle.text = "Buyers info"
        self.navigationView.btnBack.isHidden = false
        self.navigationView.lblSeprator.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.vwBorder.isHidden = false
        self.setIntialUiDesign()
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
        if isFromAddInfo == true
        {
            self.navigationController?.popViewController(animated: true)
        } else {
            let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellTicketSuccessfully) as? ManageSellTicketSuccessfully
        self.navigationController?.pushViewController(view!, animated: true)
        }
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
            viewModel.fullName = text.replacingCharacters(in: textRange, with: string)
        } else if textField == txtMobileNumber {
            viewModel.mobileNumber = "\(self.lblDialCountryCode.text ?? "" )\(text.replacingCharacters(in: textRange, with: string))"
        }else if textField == txtEmailAddress {
            viewModel.emailAddress = text.replacingCharacters(in: textRange, with: string)
        } else if textField == txtLastName{
            viewModel.password = text.replacingCharacters(in: textRange, with: string)
        }
        return true
    }
}
// MARK: - NavigationBarViewDelegate
extension ManageSellAddBuyerVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

/// /MARK: - Country Code
extension ManageSellAddBuyerVC :  RSCountrySelectedDelegate  {
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


















