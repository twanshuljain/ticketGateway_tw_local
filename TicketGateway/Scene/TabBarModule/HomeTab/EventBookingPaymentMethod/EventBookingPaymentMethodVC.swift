//
//  EventBookingPaymentMethodVC.swift
//  TicketGateway
//
//  Created by Apple  on 16/05/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable cyclomatic_complexity
// swiftlint: disable shorthand_operator
import UIKit
import iOSDropDown

class EventBookingPaymentMethodVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var viewDatePicker: UIView!
    @IBOutlet weak var picker_monthYear: UIPickerView!
    @IBOutlet weak var vwWalletTop: UIView!
    @IBOutlet weak var vwCardTop: UIView!
    @IBOutlet weak var vwCard: UIView!
    @IBOutlet weak var vwWallet: UIView!
    @IBOutlet weak var vwBgCard: UIView!
    @IBOutlet weak var vwBgWallet: UIView!
    @IBOutlet weak var imgWallet: UIImageView!
    @IBOutlet weak var imgCard: UIImageView!
    @IBOutlet weak var btnCard: UIButton!
    @IBOutlet weak var btnWallet: UIButton!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var lblTittleBalance: UILabel!
    @IBOutlet weak var lblMoreWayToPay: UILabel!
    @IBOutlet weak var lblAddAmount: UILabel!
    @IBOutlet weak var lblPayWithDigitalWAllet: UILabel!
    @IBOutlet weak var lblPayWithCard: UILabel!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblExpiry: UILabel!
    @IBOutlet weak var lblCVC_CVV: UILabel!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtCardName: UITextField!
    @IBOutlet weak var txtZipcode: UITextField!
    @IBOutlet weak var txtCVV: UITextField!
    @IBOutlet weak var txtExpiryDate: UITextField!
    @IBOutlet weak var btnRightArrow: UIButton!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var lblTotalTicketPrice :DropDown!
    
    // MARK: - Variables
    
    var viewModel = EventBookingPaymentMethodViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setUi()
    }
  
}

// MARK: - Functions
extension EventBookingPaymentMethodVC {
    private func setup() {
        self.viewModel.gradientLayer.colors = [self.viewModel.colorTop, self.viewModel.colorBottom]
        self.viewModel.gradientLayer.locations = [0.0, 1.0]
        self.viewModel.gradientLayer.frame = self.view.bounds
        self.txtCardName.delegate = self
        self.txtCardNumber.delegate = self
        self.txtExpiryDate.delegate = self
        self.txtCVV.delegate = self
        self.picker_monthYear.delegate = self
        self.picker_monthYear.dataSource = self
        self.loadDefaultsParameters()
        self.navigationView.btnBack.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = SELECT_PAYMENT_METHOD
        self.navigationView.vwBorder.isHidden = false
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        btnContinue.setTitles(text: TITLE_CONTINUE, font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
        [self.btnContinue,self.btnCard,btnWallet,btnRightArrow].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.funcDefoultSet()
    }
    
    
    func setUi() {
        [self.lblCardNumber,lblFullName,self.lblExpiry,self.lblCVC_CVV].forEach {
            $0?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            $0?.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
        
        [self.lblPayWithCard,lblPayWithDigitalWAllet].forEach {
            $0?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
            $0?.textColor = UIColor.setColor(colorType: .tgBlack)
        }
        [self.lblTittleBalance,lblMoreWayToPay].forEach {
            $0?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
            $0?.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
        self.lblAddAmount.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblAddAmount.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    
    func funcDefoultSet() {
        self.vwBgCard.backgroundColor = .clear
        self.vwBgWallet.backgroundColor = .clear
        self.vwWallet.isHidden = true
        self.vwCard.isHidden = true
        self.vwBgWallet.borderColor = UIColor.setColor(colorType: .borderColor)
        self.vwBgCard.borderColor = UIColor.setColor(colorType: .borderColor)

        self.vwWalletTop.isHidden = true
        self.vwCardTop.isHidden = true
        self.imgCard.image = UIImage(named: UNACTIVE_ICON)
        self.imgWallet.image = UIImage(named: UNACTIVE_ICON)
        self.btnCard.setImage(UIImage(named: ARROW_DOWN_ICON), for: .normal)
      //  self.btnWallet.setImage(UIImage(named: ARROW_DOWN_ICON), for: .normal)
        self.setGradientBackground(viewadd: UIView())
        
        
        self.lblTotalTicketPrice.text = "\(self.viewModel.selectedCurrencyType)\(self.viewModel.totalTicketPrice)"
//        self.txtCardName.text = "Saurabh"
//        self.txtCardNumber.text = "4242424242424242"
//        self.txtExpiryDate.text = "12/2025"
//        self.txtCVV.text = "123"
//        self.viewModel.selectedMonth = "12"
//        self.viewModel.selectedYear = "2025"
    }
    
}

// MARK: - Actions
extension EventBookingPaymentMethodVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        case btnWallet:
            self.btnWalletAction()
        case btnCard:
            self.btnCardAction()
        case btnRightArrow:
            self.btnRightArrowAction()
        default:
            break
        }
    }
    func btnWalletAction() {
        
        if self.vwBgWallet.backgroundColor == .clear {
           
            self.setGradientBackground(viewadd: vwBgWallet)
            self.vwBgWallet.backgroundColor = .white
            self.vwBgCard.backgroundColor = .clear
            self.vwBgWallet.borderColor = UIColor.setColor(colorType: .tgBlue)
           // self.vwWallet.isHidden = false
            self.vwCard.isHidden = true
           // self.vwWalletTop.isHidden = false
            self.vwCardTop.isHidden = true
            self.imgWallet.image = UIImage(named: ACTIVE_ICON)
            self.imgCard.image = UIImage(named: UNACTIVE_ICON)
           // self.btnWallet.setImage(UIImage(named: ARROW_UP), for: .normal)
            self.btnCard.setImage(UIImage(named: ARROW_DOWN_ICON), for: .normal)
         } else {
            self.funcDefoultSet()
        }
    }
    
    func btnCardAction() {
        self.vwBgWallet.backgroundColor = .clear
        if self.vwBgCard.backgroundColor == .clear {
            self.setGradientBackground(viewadd: vwBgCard)
            self.vwBgCard.backgroundColor = .white
            self.vwBgWallet.backgroundColor = .clear
            self.vwBgCard.borderColor = UIColor.setColor(colorType: .tgBlue)

            self.vwWalletTop.isHidden = true
            self.vwCardTop.isHidden = false
            self.vwWallet.isHidden = true
            self.vwCard.isHidden = false
            self.imgCard.image = UIImage(named: ACTIVE_ICON)
            self.imgWallet.image = UIImage(named: UNACTIVE_ICON)
            self.btnCard.setImage(UIImage(named: ARROW_UP), for: .normal)
         //   self.btnWallet.setImage(UIImage(named: ARROW_DOWN_ICON), for: .normal)
        } else {
            self.funcDefoultSet()
        }
    }
    
   func btnContinueAction() {
       let validate = self.viewModel.checkValidations(vc: self)
       if validate {
           self.viewModel.createCustomer(vc: self)
       }
//       let view = self.createView(storyboard: .home, storyboardID: .PaymentSuccessFullVC) as? PaymentSuccessFullVC
//       self.navigationController?.pushViewController(view ?? UIViewController(), animated: true)
    }
    
    func setGradientBackground( viewadd: UIView) {
            viewadd.layer.insertSublayer(viewModel.gradientLayer, at:0)
    }
    
    @IBAction private func btnOpenDatePicker(_ sender: Any) {
        self.view.endEditing(true)
        self.viewDatePicker.isHidden = false
        self.picker_monthYear.reloadAllComponents()
        var selectedMonth = 0
        var selectdYear = 0
        viewModel.selectedMonthName = ""
        viewModel.selectedyearName = ""
        if txtExpiryDate.text == ""
        {
            
            let  strSelectedmonths = Calendar.current.component(.month, from: Date())
            let selectedMonthIndex = strSelectedmonths-1
            selectedMonth = selectedMonthIndex
            let strSelctedyears = Calendar.current.component(.year, from: Date())
            selectdYear = strSelctedyears
            self.viewModel.selectedMonthName = String(strSelectedmonths)
            
            if  self.viewModel.selectedMonthName.count <= 1
            {
                self.viewModel.selectedMonthName = "0" + viewModel.selectedMonthName
            }
            
            self.viewModel.selectedyearName = String(strSelctedyears)
            if (viewModel.selectedyearName.count ) > 2 {
                let strLastTwoDigits: String! = (viewModel.selectedyearName as? NSString)?.substring(from: (viewModel.selectedyearName.count) - 2)
                viewModel.selectedyearName = "\(self.viewModel.selectedyearName)"
                viewModel.selectedMonthName = "\(self.viewModel.selectedMonthName)"
            }
        }
        else
        {
            let arr = txtExpiryDate.text?.components(separatedBy: "/")
            let strSelectedmonths = arr?[0] ?? ""
            let strSelctedyears = arr?[1] ?? ""
            
            let selectedMonthIndex = Int(strSelectedmonths)! - 1
            selectedMonth = selectedMonthIndex
            selectdYear  = Int(strSelctedyears)!
           // selectdYear = Int("20"+(strSelctedyears))!
            self.viewModel.selectedMonthName = String(strSelectedmonths)
            self.viewModel.selectedyearName = String(strSelctedyears)
            if (viewModel.selectedyearName.count ) > 2 {
                let strLastTwoDigits: String! = (viewModel.selectedyearName as? NSString)?.substring(from: (viewModel.selectedyearName.count ) - 2)
                viewModel.selectedyearName = "\(strSelctedyears)"
                viewModel.selectedMonthName = "\(strSelectedmonths)"
            }
            
        }
        print(selectedMonth,selectdYear)
        self.picker_monthYear.selectRow((selectedMonth) , inComponent: 0, animated: false)
        var ind = 0
        var i = 0
        for obj in self.viewModel.years{
            let yer = String(selectdYear)
            if obj as! String == yer{
                ind = i
                break
            }
            i = i + 1
        }
        self.picker_monthYear.selectRow(ind, inComponent: 1, animated: false)
        self.picker_monthYear.reloadAllComponents()
    }
   
    @IBAction private func btnPickerDoneAction(_ sender: UIButton) {
        view.endEditing(true)
        self.viewDatePicker.isHidden = true
        if !viewModel.selectedMonthName.isEmpty && !viewModel.selectedyearName.isEmpty {
            let str = "\(viewModel.selectedMonthName)/\(viewModel.selectedyearName)"
            txtExpiryDate.text = str
            viewModel.strMonth = viewModel.selectedMonthName
            viewModel.strYear = viewModel.selectedyearName
            print(viewModel.strMonth)
            print(viewModel.strYear)
            print(str)
            viewModel.selectedMonthName = ""
            viewModel.selectedyearName = ""
        }
    }
    
    @IBAction private func btnPickerCancelAction(_ sender: UIButton) {
        view.endEditing(true)
        self.viewDatePicker.isHidden = true
    }
    
    func btnRightArrowAction() {
        let vc = createView(storyboard: .wallet, storyboardID: .AddAmountWalletVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
}

// MARK: - UITextFieldDelegate
extension EventBookingPaymentMethodVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtCardNumber{
            self.viewDatePicker.isHidden = true
            self.view.endEditing(true)
            self.txtCardName.resignFirstResponder()
            self.txtCardName.becomeFirstResponder()
        }
        else if textField == self.txtZipcode
        {
            self.txtZipcode.resignFirstResponder()
        }
           return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.viewDatePicker.isHidden = true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let cardNumberLimit = 16
        if string == "" {
            return true
        }
        if textField == txtCVV{
            let maxLength = 3
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length == 5{
                textField.resignFirstResponder()
            }
            return newString.length <= maxLength
        }else if textField == txtCardNumber{
            viewModel.previousTextFieldContent = textField.text;
            viewModel.previousSelection = textField.selectedTextRange;
        
            let startingLength = textField.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace =  range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            
            return newLength <= cardNumberLimit
        }else if textField == txtCardName {
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            let maxLength = 30
            
            return newString.length <= maxLength
        }
        else if textField == txtZipcode {
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            let maxLength = 30
            return newString.length <= maxLength
        }
        
        
        
        else {
            return true
        }
    }
}
// MARK: - UIPickerViewDelegate,UIPickerViewDataSource
extension EventBookingPaymentMethodVC:UIPickerViewDelegate,UIPickerViewDataSource {
    
    // MARK:- Picker View Delegates
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        view.endEditing(true)
        
        if component == viewModel.MONTH {
            return viewModel.months.count
        }
        else {
            return viewModel.years.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == viewModel.MONTH {
            let monthName: String = viewModel.months[row] as! String
            return monthName
        }
        else {
            let yearName: String = viewModel.years[row] as! String
            let str = "\(yearName)"
            return str
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        view.endEditing(true)
        
        if component == self.viewModel.MONTH {
            
            let strCurrentYear = String(Calendar.current.component(.year, from: Date()))
            let strCurrentMonth = String(Calendar.current.component(.month, from: Date()))
             let str = viewModel.selectedyearName
            if strCurrentYear == str
            {
                let strMonths = viewModel.months[row] as! String
                if Int(strCurrentMonth) ?? 0 > Int(strMonths) ?? 0
                {
                    
                    
                    let index = (Int(strCurrentMonth) ?? 0) - 1
                    
                    self.picker_monthYear.selectRow(index, inComponent: 0, animated: false)
                    
                    viewModel.selectedMonthName = strCurrentMonth
                    if viewModel.selectedMonthName.count <= 1
                    {
                        viewModel.selectedMonthName = "0" + viewModel.selectedMonthName
                    }
                    
                    
                    
                }
                else
                {
                    viewModel.selectedMonthName = viewModel.months[row] as! String
                    
                    if viewModel.selectedMonthName.count <= 1
                    {
                        viewModel.selectedMonthName = "0" + viewModel.selectedMonthName
                    }
                }
                
                
            }else
            {
                viewModel.selectedMonthName = viewModel.months[row] as! String
                if viewModel.selectedMonthName.count <= 1
                {
                    viewModel.selectedMonthName = "0" + viewModel.selectedMonthName
                }
            }
            
            
        }else {
            let strCurrentYear = String(Calendar.current.component(.year, from: Date()))
            let strCurrentMonth = String(Calendar.current.component(.month, from: Date()))
            
            let str = "\(viewModel.years[row])"
            
            
            if strCurrentYear == str
            {
                let index = (Int(strCurrentMonth) ?? 0) - 1
                self.picker_monthYear.selectRow(index, inComponent: 0, animated: false)
                viewModel.selectedMonthName = strCurrentMonth
                if viewModel.selectedMonthName.count <= 1
                {
                    viewModel.selectedMonthName = "0" + viewModel.selectedMonthName
                }
            //
                let str = Int(strCurrentMonth)! - 1
                if (strCurrentYear.count ) > 2 {
                    let strLastTwoDigits: String! = (strCurrentYear as? NSString)?.substring(from: (strCurrentYear.count ) - 2)
                    viewModel.selectedyearName = "\(strCurrentYear)"
                }
                
            }
            else
            {
                
                let str = "\(viewModel.years[row])"
                if (str.count ) > 2 {
                    let strLastTwoDigits: String! = (str as? NSString)?.substring(from: (str.count ) - 2)
                    viewModel.selectedyearName = "\(str)"
                    //viewModel.selectedMonthName = "\(months[row])"
                }
            }
        }
    }
    
    func loadDefaultsParameters() {
        let components: DateComponents? = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        let year: Int? = components?.year
        self.viewModel.minYear = year!
        self.viewModel.maxYear = year! + 30
        self.viewModel.rowHeight = 44
        self.viewModel.months = nameOfMonths()
        self.viewModel.years = nameOfYears()
        picker_monthYear.delegate = self
        picker_monthYear.dataSource = self
        let str = "\(Int(year!))"
        if (str.count ) > 2 {
            let strLastTwoDigits: String = ((str as? NSString)?.substring(from: (str.count ) - 2))!
            viewModel.selectedyearName = "\(str)"
        }
        viewModel.selectedMonthName = "01"
    }
    
    func nameOfMonths() -> [Any] {
        return ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    }
    
    func nameOfYears() -> [Any] {
        var years = [AnyHashable]()
        for year in viewModel.minYear...viewModel.maxYear {
            let yearStr = "\(Int(year))"
            years.append(yearStr)
        }
        return years
    }
}

// MARK: - NavigationBarViewDelegate
extension EventBookingPaymentMethodVC: NavigationBarViewDelegate {
    func navigationBackAction() {
    self.navigationController?.popViewController(animated: true)
  }
}
