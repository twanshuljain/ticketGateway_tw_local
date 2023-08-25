//
//  EventSearchHomeVC.swift
//  TicketGateway
//
//  Created by Apple  on 22/05/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count

import UIKit
import SideMenu

protocol SendLocation: AnyObject {
    func toSendLocation(location: String)
}

class EventSearchLocationVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblOnlineEventDis: UILabel!
    @IBOutlet weak var vwSearchBar: CustomSearchBar!
    @IBOutlet weak var lblOnlineEvents: UILabel!
    @IBOutlet weak var lblNearByDiscripation: UILabel!
    @IBOutlet weak var lblNearBy: UILabel!
    @IBOutlet weak var lblBrowingIn: UILabel!
    @IBOutlet weak var tblList: UITableView!
    //MARK: - Variables
    
    weak var delegate: SendLocation?
    var countriesModel = [CountryInfo]()
    var countries = [[String: String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.setUp()
        self.setUI()
        addCountries()
        self.vwSearchBar.delegate = self
        self.vwSearchBar.vwLocation.isHidden = true
        self.vwSearchBar.txtSearch.attributedPlaceholder = NSAttributedString(string: FIND_EVENT_IN, attributes: [NSAttributedString.Key.foregroundColor: UIColor.setColor(colorType: .placeHolder)])
        self.vwSearchBar.txtSearch.delegate = self
        self.vwSearchBar.btnMenu.setImage(UIImage(named: BACK_ARROW_ICON), for: .normal)
    }
    
    func addCountries() {
        self.countries = self.jsonSerial()
        for country in countries {
            let name = country["name"] ?? ""
            let countryinfo = CountryInfo(country_code: "", dial_code: "", country_name: name)
            countriesModel.append(countryinfo)
        }
         tblList.reloadData()
    }
}

// MARK: - Functions
extension EventSearchLocationVC{
    private func setUp() {
        self.tblList.dataSource = self
        self.tblList.delegate = self
        self.tblList.reloadData()
    }
    private func setUI() {
        [self.lblNearBy,self.lblOnlineEvents,self.lblBrowingIn].forEach{
            $0.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
            $0.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        }
        [self.lblNearByDiscripation,self.lblOnlineEventDis].forEach{
            $0.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            $0.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
    }
    @objc func buttonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            self.delegate?.toSendLocation(location: countriesModel[sender.tag].country_name)
        }
    }
}

// MARK: - TableView Delegate
extension EventSearchLocationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  return countries.count
        return countriesModel.count//locationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchLocationCell") as! SearchLocationCell
        let countryName = countriesModel[indexPath.row].country_name//locationData[indexPath.row]
        cell.lblTittle.text = countryName
        cell.btnCheck.tag = indexPath.row
        cell.btnCheck.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        cell.btnCheck.setImage(UIImage(named: IMAGE_ACTIVE_TERM_ICON), for: .selected)
        cell.btnCheck.setImage(UIImage(named: IMAGE_UNACTIVE_TERM_ICON), for: .normal)
        return cell
   
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchLocationCell") as! SearchLocationCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("in \(indexPath.row)")
    }
  
}

//MARK: - UITextFieldDelegate
extension EventSearchLocationVC: UITextFieldDelegate {
    
}

//MARK: - CustomSearchMethodsDelegate
extension EventSearchLocationVC: CustomSearchMethodsDelegate {
    func leftButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func rightButtonPressed(_ sender: UIButton) {
        let view = self.createView(storyboard: .home, storyboardID: .EventSearchLocationVC) as? EventSearchLocationVC
        self.navigationController?.pushViewController(view!, animated: true)
    }
}
// MARK: -
extension EventSearchLocationVC: RSCountrySelectedDelegate {
    func RScountrySelected(countrySelected country: CountryInfo) { }
   
}
