//
//  RSCountryPickerController.swift
//  TicketGateway
//
//  Created by Apple  on 18/04/23.


import UIKit

import UIKit

struct CountryInfo {
    let countryCode: String
    let dialCode: String
    let countryName: String
    // let flag: UIImage
}

// Make Protocol
protocol RSCountrySelectedDelegate {
    func RScountrySelected(countrySelected country: CountryInfo) -> Void
}

class RSCountryPickerController: UIViewController,UITextFieldDelegate {
    // MARK:- IBOutlets
    @IBOutlet var vwHeader: UIView!
    @IBOutlet var vwContainTfSearch: UIView!
    @IBOutlet var tfSearchBar: UITextField!
    @IBOutlet var tblCountryList: UITableView!
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet weak var navigationView: NavigationBarView!
    // Variables
    var countries = [[String: String]]()
    var RScountryDelegate: RSCountrySelectedDelegate!
    var RScountriesFiltered = [CountryInfo]()
    var RScountriesModel = [CountryInfo]()
    var strCheckCountry = ""
    //App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countries = jsonSerial()
        collectCountries()
        tblCountryList.delegate = self
        tblCountryList.dataSource = self
        tfSearchBar.delegate = self
        vwContainTfSearch.layer.shadowColor = UIColor.lightGray.cgColor
        vwContainTfSearch.layer.shadowOffset = CGSize(width: -0.5, height: 0.3)
        vwContainTfSearch.layer.shadowOpacity = 0.5
        vwContainTfSearch.layer.cornerRadius = 20
        self.RScountriesFiltered = self.RScountriesModel
        self.tfSearchBar.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)
        navigationView.lblTitle.text = "Select Country"
        navigationView.btnBack.isHidden = false
        navigationView.delegateBarAction = self
    }
    
   
}

// MARK:- Searching
extension RSCountryPickerController{
    @objc func searchWorkersAsPerText(_ textfield:UITextField) {
        self.RScountriesFiltered.removeAll()
        if !(textfield.text?.isEmpty ?? false) {
            for dicData in self.RScountriesModel {
                
                let prefix = Int(textfield.text!.count) // Hello
                let isMachingWorker: NSString = (dicData.countryName) as? NSString ?? ""
                
                let range = isMachingWorker.lowercased.prefix(prefix).range(of: textfield.text!, options: String.CompareOptions.caseInsensitive, range: nil, locale: nil)
                
                if range != nil {
                    RScountriesFiltered.append(dicData)
                }
            }
        } else {
            self.RScountriesFiltered = self.RScountriesModel
        }
        self.tblCountryList.reloadData()
    }
}

//Functions
extension RSCountryPickerController{
   
    func collectCountries() {
        for country in countries  {
            let code = country["code"] ?? ""
            let name = country["name"] ?? ""
            let dailcode = country["dial_code"] ?? ""
            RScountriesModel.append(CountryInfo(countryCode:code,
                                                dialCode:dailcode,
                                                countryName: name))
        }
    }
    
    
    
    func checkSearchBarActive() -> Bool {
        if tfSearchBar.text != "" {
            return true
        } else {
            return false
        }
    }
    
//--------------------------XXXX--------------------------
    class func getDialCode(countryCode: String) -> String? {
        let data = try? Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "countries", ofType: "json")!))
        do {
            let parsedObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            var countries = [[String: String]]()
            countries = parsedObject as! [[String: String]]
            for dic in countries {
                if dic["code"] == countryCode {
                    return dic["dial_code"]
                }
            }
            return nil
        }catch{
            print("not able to parse")
            return nil
        }
    }
    
    
    class func getCountryCode(dialCode: String) -> String {
        let data = try? Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "countries", ofType: "json")!))
        do {
            let parsedObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            var countries = [[String: String]]()
            countries = parsedObject as! [[String: String]]
            for dic in countries {
                if dic["dial_code"] == dialCode {
                    return dic["code"] ?? ""
                }
            }
            return nil ?? ""
        }catch{
            print("not able to parse")
            return nil ?? ""
        }
    }
    
    
    class func getCountryName(countryCode: String) -> String? {
        let data = try? Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "countries", ofType: "json")!))
        do {
            let parsedObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            var countries = [[String: String]]()
            countries = parsedObject as! [[String: String]]
            for dic in countries {
                if dic["code"] == countryCode {
                    return dic["name"]
                }
            }
            return nil
        }catch{
            print("not able to parse")
            return nil
        }
    }
    
    class func getCountryInfo(countryCode: String) -> CountryInfo? {
        let data = try? Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "countries", ofType: "json")!))
        do {
            let parsedObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            var countries = [[String: String]]()
            countries = parsedObject as! [[String: String]]
            for dic in countries {
                if dic["code"] == countryCode {
                    return CountryInfo(countryCode: dic["code"]!, dialCode: dic["dial_code"]!, countryName: dic["name"]!)
                }
            }
            return nil
        }catch{
            print("not able to parse")
            return nil
        }
    }
    
    class func getCountryInfo(dialCode: String) -> CountryInfo? {
        let data = try? Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "countries", ofType: "json")!))
        do {
            let parsedObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            var countries = [[String: String]]()
            countries = parsedObject as! [[String: String]]
            for dic in countries {
                if dic["code"] == dialCode {
                    return CountryInfo(countryCode: dic["code"]!, dialCode: dic["dial_code"]!, countryName: dic["name"]!)
                }
            }
            return nil
        }catch{
            print("not able to parse")
            return nil
        }
    }
    //--------------------------XXXX--------------------------
}

// MARK:- TableVies Delegate
extension RSCountryPickerController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RSCountryTableViewCell
        //03/05/2022
       // cell.imgRadioCheck.image = #imageLiteral(resourceName: "caret-down")
        if checkSearchBarActive() {
            RScountryDelegate.RScountrySelected(countrySelected: RScountriesFiltered[indexPath.row])
        
        }else {
            RScountryDelegate.RScountrySelected(countrySelected: RScountriesModel[indexPath.row])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK:- TableVies Datasource
extension RSCountryPickerController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if checkSearchBarActive() {
            return RScountriesFiltered.count
        }
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RSCountryTableViewCell")as! RSCountryTableViewCell
        // RScountryDelegate = self as? RSCountrySelectedDelegate
        
        let contry: CountryInfo
        if checkSearchBarActive() {
            contry = RScountriesFiltered[indexPath.row]
        } else {
            contry = RScountriesModel[indexPath.row]
        }
        cell.lblCountryName.text = contry.countryName
        cell.lblCountryDialCode.text = contry.dialCode
        let imagestring = contry.countryCode
        let imagePath = "CountryPicker.bundle/\(imagestring).png"
        cell.imgCountryFlag.image = UIImage(named: imagePath)
        
        if strCheckCountry == contry.countryName
        {
            //03/5/2022
          //  cell.imgRadioCheck.image = #imageLiteral(resourceName: "Radio_button_activ")
            
        } else {
          //  cell.imgRadioCheck.image = #imageLiteral(resourceName: "Radio_button_inactiv")
        }
        return cell
    }
    
    
  
}

// MARK: -  NavigationBarViewDelegate
extension RSCountryPickerController: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
