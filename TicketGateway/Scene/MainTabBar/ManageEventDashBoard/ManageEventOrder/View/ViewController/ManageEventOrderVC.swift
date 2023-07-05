//
//  ManageEventOrderVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 23/05/23.
//

import UIKit

class ExpandableName {
    var isExpanded : Bool
    init(isExpanded: Bool) {
        self.isExpanded = isExpanded
        
    }
}

class ManageEventOrderVC: UIViewController {
    
    @IBOutlet weak var vwNavigationBar: NavigationBarView!
    @IBOutlet weak var OrderTableView: UITableView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var BgNoOrderView: UIView!
    @IBOutlet weak var lblSorry: UILabel!
    @IBOutlet weak var lblYourSearch: UILabel!
    var isRefundRequest = false
   
    let orderTableData = ["David Taylor", "David Taylor", "David Taylor"]
    
    var arrData = [ExpandableName(isExpanded: false), ExpandableName(isExpanded: false), ExpandableName(isExpanded: false), ExpandableName(isExpanded: false), ExpandableName(isExpanded: false), ExpandableName(isExpanded: false), ExpandableName(isExpanded: false), ExpandableName(isExpanded: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.setNavigationBar()
        self.setFont()
    }
    
    func setNavigationBar() {
        self.vwNavigationBar.lblTitle.text = "Sunburn reload NYE - toronto"
        self.vwNavigationBar.lblDiscripation.isHidden = false
        self.vwNavigationBar.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.vwNavigationBar.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.vwNavigationBar.lblDiscripation.text = "Wed, Dec 7, 2023  at 05:00 PM"
        self.vwNavigationBar.lblDiscripation.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.vwNavigationBar.lblDiscripation.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.vwNavigationBar.imgBack.image = UIImage(named: "Menu")
    }
  
    func setTableView() {
        self.OrderTableView.delegate = self
        self.OrderTableView.dataSource = self
        self.OrderTableView.separatorColor = UIColor.clear
        self.OrderTableView.register(UINib(nibName: "ManageOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "ManageOrderTableViewCell")
        self.OrderTableView.register(UINib(nibName: "RefundRequestTableViewCell", bundle: nil), forCellReuseIdentifier: "RefundRequestTableViewCell")
        self.OrderTableView.register(UINib(nibName: "RequestRefundHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "RequestRefundHeaderView")
        
    }
    
    func setFont() {
        self.lblSorry.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblSorry.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblYourSearch.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblYourSearch.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    
    @objc func nextBtn(sender: UIButton){
        var obj = arrData[sender.tag]
        print(arrData[sender.tag])
        if obj.isExpanded == false
        {
            obj.isExpanded = true
        } else {
            obj.isExpanded = false
        }
        print("value",arrData)
        self.OrderTableView.reloadData()
    }
    
    @IBAction func actionSegmentControl(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            isRefundRequest = false
            self.OrderTableView.reloadData()
            
        case 1:
            isRefundRequest = true
            self.OrderTableView.reloadData()
        default:
            break
        }
    }
    
}


//MARK: - UITableViewDelegate, UITableViewDataSource
extension ManageEventOrderVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int{
        if isRefundRequest == true{
            return arrData.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isRefundRequest {
            return  orderTableData.count
        } else {
            if arrData[section].isExpanded == true{
                return 1
            } else {
                return 0
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !isRefundRequest {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ManageOrderTableViewCell", for: indexPath) as! ManageOrderTableViewCell
            let data = orderTableData[indexPath.row]
            cell.lblName.text = data
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RefundRequestTableViewCell", for: indexPath) as! RefundRequestTableViewCell
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RequestRefundHeaderView") as! RequestRefundHeaderView
        headerView.contentView.backgroundColor = UIColor.white
        headerView.btnChevron.tag = section
        headerView.btnChevron.addTarget(self, action: #selector(nextBtn(sender:)), for: .touchUpInside)
        let obj = arrData[section]
        if obj.isExpanded == true {
            headerView.btnChevron.setImage(UIImage(named: "circlechevronUp_ip"), for: .normal)
            headerView.vwLineView.isHidden = true
        }else {
            headerView.btnChevron.setImage(UIImage(named: "circleChevron-down_ip"), for: .normal)
            headerView.vwLineView.isHidden = false
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isRefundRequest ? 50 : 0
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = createView(storyboard: .manageventorder, storyboardID: .ManageEventOrderDeatilVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
