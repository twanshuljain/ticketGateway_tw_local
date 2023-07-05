//
//  AddCardVC.swift
//  TicketGateway
//
//  Created by Apple  on 24/05/23.
//

import UIKit

class AddCardVC: UIViewController {
    
    
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
       
    var MONTH = 0
    var YEAR = 1
    var selectedMonthName = ""
    var selectedyearName = ""
    var months = [Any]()
    var years = [Any]()
    var minYear: Int = 0
    var maxYear: Int = 0
    var rowHeight: Int = 0
    var strMonth = ""
    var strYear = ""
   
    
    let colorTop =  UIColor(red: 146.0/255.0, green: 254.0/255.0, blue: 157.0/255.0, alpha: 0.2).cgColor
    let colorBottom = UIColor(red: 0/255.0, green: 201.0/255.0, blue: 255.0/255.0, alpha: 0.2).cgColor
    let gradientLayer = CAGradientLayer()
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setUi()
    }
}


extension AddCardVC {
    private func setup() {
        self.gradientLayer.colors = [colorTop, colorBottom]
        self.gradientLayer.locations = [0.0, 1.0]
        self.gradientLayer.frame = self.view.bounds
        self.txtCardName.delegate = self
        self.txtCardNumber.delegate = self
        self.txtExpiryDate.delegate = self
        self.txtCVV.delegate = self
        self.picker_monthYear.delegate = self
        self.picker_monthYear.dataSource = self
        self.loadDefaultsParameters()
        self.navigationView.btnBack.isHidden = false
        self.navigationView.lblDiscripation.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = "Sunburn reload NYE - toronto"
        self.navigationView.lblDiscripation.text = "Wed, Dec 7, 2023  at 05:00 PM"
        self.navigationView.vwBorder.isHidden = false
        self.btnContinue.addRightIcon(image: UIImage(named: "rightOnButton"))
        self.btnContinue.setTitles(text: "Place Order", font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
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
        selectedMonthName = ""
        selectedyearName = ""
        if txtExpiryDate.text == ""
        {
            
            let  strSelectedmonths = Calendar.current.component(.month, from: Date())
            let selectedMonthIndex = strSelectedmonths-1
            selectedMonth = selectedMonthIndex
            let strSelctedyears = Calendar.current.component(.year, from: Date())
            selectdYear = strSelctedyears
            self.selectedMonthName = String(strSelectedmonths)
            
            if  self.selectedMonthName.count <= 1
            {
                self.selectedMonthName = "0" + selectedMonthName
            }
            
            self.selectedyearName = String(strSelctedyears)
            if (selectedyearName.count ) > 2 {
                let strLastTwoDigits: String! = (selectedyearName as? NSString)?.substring(from: (selectedyearName.count) - 2)
                selectedyearName = "\(self.selectedyearName)"
                selectedMonthName = "\(self.selectedMonthName)"
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
            self.selectedMonthName = String(strSelectedmonths)
            self.selectedyearName = String(strSelctedyears)
            if (selectedyearName.count ) > 2 {
                let strLastTwoDigits: String! = (selectedyearName as? NSString)?.substring(from: (selectedyearName.count ) - 2)
                selectedyearName = "\(strSelctedyears)"
                selectedMonthName = "\(strSelectedmonths)"
            }
            
        }
        print(selectedMonth,selectdYear)
        self.picker_monthYear.selectRow((selectedMonth) , inComponent: 0, animated: false)
        var ind = 0
        var i = 0
        for obj in self.years{
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
        if selectedMonthName.count > 0 && selectedyearName.count > 0{
            let str = "\(selectedMonthName)/\(selectedyearName)"
            txtExpiryDate.text = str
            strMonth = selectedMonthName
            strYear = selectedyearName
            print(strMonth)
            print(strYear)
            print(str)
            selectedMonthName = ""
            selectedyearName = ""
        }
    }
    
    @IBAction func btnPickerCancelAction(_ sender: UIButton) {
        view.endEditing(true)
        self.viewDatePicker.isHidden = true
    }
   
}

extension AddCardVC : UITextFieldDelegate{
    //MARK: TextField Delegate -
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
//MARK:- pickerview delegate
extension AddCardVC:UIPickerViewDelegate,UIPickerViewDataSource{
    
    // MARK:- Picker View Delegates
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        view.endEditing(true)
        
        if component == MONTH {
            return months.count
        }
        else {
            return years.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == MONTH {
            let monthName: String = months[row] as! String
            return monthName
        }
        else {
            let yearName: String = years[row] as! String
            let str = "\(yearName)"
            return str
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        view.endEditing(true)
        
         if component == self.MONTH {
            
            let strCurrentYear = String(Calendar.current.component(.year, from: Date()))
            let strCurrentMonth = String(Calendar.current.component(.month, from: Date()))
             let str = selectedyearName
            if strCurrentYear == str
            {
                let strMonths = months[row] as! String
                if Int(strCurrentMonth) ?? 0 > Int(strMonths) ?? 0
                {
                    
                    
                    let index = (Int(strCurrentMonth) ?? 0) - 1
                    
                    self.picker_monthYear.selectRow(index, inComponent: 0, animated: false)
                    
                    selectedMonthName = strCurrentMonth
                    if selectedMonthName.count <= 1
                    {
                        selectedMonthName = "0" + selectedMonthName
                    }
                    
                    
                    
                }
                else
                {
                    selectedMonthName = months[row] as! String
                    
                    if selectedMonthName.count <= 1
                    {
                        selectedMonthName = "0" + selectedMonthName
                    }
                }
                
                
            }else
            {
                selectedMonthName = months[row] as! String
                if selectedMonthName.count <= 1
                {
                    selectedMonthName = "0" + selectedMonthName
                }
            }
            
            
        }else {
            let strCurrentYear = String(Calendar.current.component(.year, from: Date()))
            let strCurrentMonth = String(Calendar.current.component(.month, from: Date()))
            
            let str = "\(years[row])"
            
            
            if strCurrentYear == str
            {
                let index = (Int(strCurrentMonth) ?? 0) - 1
                self.picker_monthYear.selectRow(index, inComponent: 0, animated: false)
                selectedMonthName = strCurrentMonth
                //25/03/2022
                if selectedMonthName.count <= 1
                {
                    selectedMonthName = "0" + selectedMonthName
                }
                //
                let str = Int(strCurrentMonth)! - 1
                if (strCurrentYear.count ) > 2 {
                    let strLastTwoDigits: String! = (strCurrentYear as? NSString)?.substring(from: (strCurrentYear.count ) - 2)
                    selectedyearName = "\(str)"
                }
                
            }
            else
            {
                
                let str = "\(years[row])"
                if (str.count ) > 2 {
                    let strLastTwoDigits: String! = (str as? NSString)?.substring(from: (str.count ) - 2)
                    selectedyearName = "\(str)"
                    //selectedMonthName = "\(months[row])"
                }
            }
        }
    }
    
    func loadDefaultsParameters() {
        let components: DateComponents? = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        let year: Int? = components?.year
        minYear = year!
        maxYear = year! + 30
        rowHeight = 44
        months = nameOfMonths()
        years = nameOfYears()
        picker_monthYear.delegate = self
        picker_monthYear.dataSource = self
        let str = "\(Int(year!))"
        if (str.count ) > 2 {
            let strLastTwoDigits: String = ((str as? NSString)?.substring(from: (str.count ) - 2))!
            selectedyearName = "\(str)"
        }
        selectedMonthName = "01"
    }
    
    func nameOfMonths() -> [Any] {
        return ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    }
    
    func nameOfYears() -> [Any] {
        var years = [AnyHashable]()
        for year in minYear...maxYear {
            let yearStr = "\(Int(year))"
            years.append(yearStr)
        }
        return years
    }
}


extension AddCardVC : NavigationBarViewDelegate {
    func navigationBackAction() {
    self.navigationController?.popViewController(animated: true)
  }
}
