//
//  AddCardVC.swift
//  TicketGateway
//
//  Created by Apple  on 24/05/23.
//

import UIKit

class AddCardVC: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var viewDatePicker: UIView!
    @IBOutlet weak var picker_monthYear: UIPickerView!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblExpiry: UILabel!
    @IBOutlet weak var lblCVC_CVV: UILabel!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtCardName: UITextField!
    @IBOutlet weak var txtCVV: UITextField!
    @IBOutlet weak var txtExpiryDate: UITextField!
    private var previousTextFieldContent: String?
    private var previousSelection: UITextRange?
   
//MARK: - VARIABLES
    var viewModel = AddCardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setUi()
    }
}

// MARK: - Functions
extension AddCardVC {
    private func setup() {
        self.viewModel.gradientLayer.colors = [viewModel.colorTop, viewModel.colorBottom]
        self.viewModel.gradientLayer.locations = [0.0, 1.0]
        self.viewModel.gradientLayer.frame = self.view.bounds
        self.txtCardName.delegate = self
        self.txtCardNumber.delegate = self
        self.txtExpiryDate.delegate = self
        self.txtCVV.delegate = self
        self.picker_monthYear.delegate = self
        self.picker_monthYear.dataSource = self
        self.viewModel.loadDefaultsParameters()
        self.navigationView.btnBack.isHidden = false
        self.navigationView.lblDiscripation.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = HEADER_TITLE_SUNBURN
        self.navigationView.lblDiscripation.text = HEADER_DESCRIPTION_DATE_TIME
        self.navigationView.vwBorder.isHidden = false
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_BUTTON_ICON))
        self.btnContinue.setTitles(text: PLACE_ORDER, font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
        [self.btnContinue].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
     }
    
    
    func setUi(){
        [self.lblCardNumber,lblFullName,self.lblExpiry,self.lblCVC_CVV].forEach {
            $0?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            $0?.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
    }
}

// MARK: - Actions
extension AddCardVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        default:
            break
        }
    }
   
    
   func btnContinueAction() {
       let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellTicketSuccessfully) as? ManageSellTicketSuccessfully
   self.navigationController?.pushViewController(view!, animated: true)
    }
    
    
    @IBAction func btnOpenDatePicker(_ sender: Any) {
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
   
    @IBAction func btnPickerDoneAction(_ sender: UIButton) {
        view.endEditing(true)
        self.viewDatePicker.isHidden = true
        if viewModel.selectedMonthName.count > 0 && viewModel.selectedyearName.count > 0{
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
    
    @IBAction func btnPickerCancelAction(_ sender: UIButton) {
        view.endEditing(true)
        self.viewDatePicker.isHidden = true
    }
   
}
// MARK: - UITextFieldDelegate
extension AddCardVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtCardNumber{
            self.viewDatePicker.isHidden = true
            self.view.endEditing(true)
            self.txtCardName.resignFirstResponder()
            self.txtCardName.becomeFirstResponder()
        }
        
           return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.viewDatePicker.isHidden = true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "" {
            return true
        }
        if textField == txtCVV{
            let maxLength = 4
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length == 5{
                textField.resignFirstResponder()
            }
            return newString.length <= maxLength
        }else if textField == txtCardNumber{
            previousTextFieldContent = textField.text;
            previousSelection = textField.selectedTextRange;
            
            
            return true
        }else if textField == txtCardName{
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            let maxLength = 30
            
            return newString.length <= maxLength
        }
        else{
            return true
        }
    }
}
// MARK: - UIPickerViewDelegate,UIPickerViewDataSource
extension AddCardVC:UIPickerViewDelegate,UIPickerViewDataSource{
    
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
                //25/03/2022
                if viewModel.selectedMonthName.count <= 1
                {
                    viewModel.selectedMonthName = "0" + viewModel.selectedMonthName
                }
                //
                let str = Int(strCurrentMonth)! - 1
                if (strCurrentYear.count ) > 2 {
                    let strLastTwoDigits: String! = (strCurrentYear as? NSString)?.substring(from: (strCurrentYear.count ) - 2)
                    viewModel.selectedyearName = "\(str)"
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
}

// MARK: - NavigationBarViewDelegate
extension AddCardVC : NavigationBarViewDelegate {
    func navigationBackAction() {
    self.navigationController?.popViewController(animated: true)
  }
}
