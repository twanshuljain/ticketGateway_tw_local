//
//  SegmentCostumeVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 22/05/23.

import UIKit
import SideMenu

class SegmentCostumeVC: ViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var vwNavigationBar: NavigationBarView!
    @IBOutlet weak var segmentBgView: UIView!
    @IBOutlet weak var vwSearchBar: UIView!
    @IBOutlet weak var btnFilter: CustomButtonNormal!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var segmentcontrol: UISegmentedControl!
    @IBOutlet weak var tblCostume: UITableView!
    @IBOutlet weak var vwPopUp: CustomSocialLoginView!
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var lblPopYear: UILabel!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    // MARK: - Variables
    let tableData = ["costumeOrder_ip", "costumeOrder_ip", "costumeOrder_ip" ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFont()
        self.setTableView()
        self.setNavigationView()
    }
}
// MARK: - Functions
extension SegmentCostumeVC {
    func setNavigationView() {
        self.vwNavigationBar.lblTitle.text = MY_ORDERS
        self.vwNavigationBar.imgBack.image = UIImage(named: MENU_ICON)
        self.vwNavigationBar.btnBack.isHidden = false
        self.vwNavigationBar.delegateBarAction = self
    }
    func setTableView() {
        tblCostume.separatorColor = UIColor.clear
        tblCostume.delegate = self
        tblCostume.dataSource = self
        tblCostume.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderTableViewCell")
    }
    func setFont() {
        self.segmentcontrol.selectedSegmentIndex = 1
        self.vwPopUp.isHidden = true
        self.segmentBgView.addBottomShadow()
        self.btnFilter.addLeftIcon(image: UIImage(named: FILTER))
        self.lblYear.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblYear.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnFilter.titleLabel?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.btnFilter.titleLabel?.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblMonth.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblMonth.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblPopYear.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblPopYear.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblDate.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblDate.textColor = UIColor.setColor(colorType: .lblTextPara)
        [btnFilter].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
        }
    }
}
// MARK: - Actions
extension SegmentCostumeVC {
    @IBAction private func actionSegment(_ sender: UISegmentedControl) {
        switch segmentcontrol.selectedSegmentIndex {
        case 0:
            self.navigationController?.popViewController(animated: false)
        case 1:
            break
        default:
            break
        }
    }
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnFilter:
            self.filterAction()
        default:
            break
        }
    }
    func filterAction() {
        vwPopUp.isHidden = !vwPopUp.isHidden
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension SegmentCostumeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
        let data = tableData[indexPath.row]
        cell.imgImage.image = UIImage(named: data)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = self.createView(storyboard: .order, storyboardID: .MyTicketVC)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
// MARK: - NavigationBarViewDelegate
extension SegmentCostumeVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        let view = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = view.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
}
