//
//  RequestRefundVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 05/06/23.
//

import UIKit

class ExpandableRefundRequest {
    var isExpanded : Bool
     var isSelected: Bool = false
    init(isExpanded: Bool, isSlected: Bool) {
        self.isExpanded = isExpanded
        self.isSelected = isSlected
        
    }
}


class RequestRefundVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tblRefundTableView: UITableView!
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    
    @IBOutlet weak var btnRefundAll: UIButton!
    @IBOutlet weak var lblRefundAll: UILabel!
    
    @IBOutlet weak var btnRefundIndividual: UIButton!
    @IBOutlet weak var lblRefundIndividual: UILabel!
    
    @IBOutlet weak var lblNeedRefundAmount: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var btnProcssRefund: CustomButtonGradiant!
    @IBOutlet weak var btnCancel: UIButton!
    
    //MARK: - Variables
    var isRefundAll: Bool = false
    var arrData = [ExpandableRefundRequest(isExpanded: false, isSlected: true), ExpandableRefundRequest(isExpanded: false, isSlected: false), ExpandableRefundRequest(isExpanded: false, isSlected: false), ExpandableRefundRequest(isExpanded: false, isSlected: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.setNavigationView()
        self.setFont()
        self.setUI()
        self.isRefundAll = true
        self.setRefundRequestButton()
      
    }
}
//MARK: - Functions
extension RequestRefundVC {
    func setFont() {
        self.btnProcssRefund.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnProcssRefund.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        self.btnProcssRefund.addRightIcon(image: UIImage(named: "LeftArrow_ip"))
        self.btnCancel.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnCancel.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        self.lblNeedRefundAmount.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblNeedRefundAmount.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .white) ], for: .selected)
        self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .lblTextPara) ], for: .normal)

       
    }
    
    func setRefundRequestButton() {
        if isRefundAll == true {
         
            self.btnRefundAll.setImage(UIImage(named: "active"), for: .normal)
            self.btnRefundIndividual.setImage(UIImage(named: "Unselected_ip"), for: .normal)
          self.lblRefundAll.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
            self.lblRefundAll.textColor = UIColor.setColor(colorType: .lblTextPara);        self.lblRefundIndividual.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
           self.lblRefundIndividual.textColor = UIColor.setColor(colorType: .lblTextPara)
            
        } else {
            self.btnRefundAll.setImage(UIImage(named: "Unselected_ip"), for: .normal)
            self.btnRefundIndividual.setImage(UIImage(named: "active"), for: .normal)
           self.lblRefundAll.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            self.lblRefundAll.textColor = UIColor.setColor(colorType: .lblTextPara)
            self.lblRefundIndividual.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
            self.lblRefundIndividual.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
    }
    func setNavigationView() {
       self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = "Request Refund"
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.vwNavigationView.lblDiscripation.isHidden = false
        self.vwNavigationView.lblDiscripation.text = "Sale #32926471 Mangesh Yahoo"
        self.vwNavigationView.lblDiscripation.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.vwNavigationView.lblDiscripation.textColor = UIColor.setColor(colorType: .lblTextPara)

    }
    
    func setTableView() {
        self.tblRefundTableView.separatorColor = UIColor.clear
        self.tblRefundTableView.delegate = self
        self.tblRefundTableView.dataSource = self
        self.tblRefundTableView.register(UINib(nibName: "RequestRefundTableViewCell", bundle: nil), forCellReuseIdentifier: "RequestRefundTableViewCell")
        self.tblRefundTableView.register(UINib(nibName: "ReqRefundHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ReqRefundHeaderView")
    }
    func setUI () {
        [btnRefundAll,btnRefundIndividual,btnProcssRefund].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
        }
    }

    func refundAllAction() {
        self.isRefundAll = true
        self.setRefundRequestButton()
        self.tblRefundTableView.reloadData()

    }

    func refundIndividualAction() {
        self.isRefundAll = false
        self.setRefundRequestButton()
        self.tblRefundTableView.reloadData()

    }
    func btnProcssRefundAction(){
        let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellTicketSuccessfully) as? ManageSellTicketSuccessfully
        view?.strTittle = "Refund Successfull"
        view?.strComplimentry = "1 Ticket(S) with amount $300.00"
        view?.strSummary = "Ticket for Order Id #32916222 has been successfully refunded in your TG Wallet"
        view?.btnStr = "Okay"
    self.navigationController?.pushViewController(view!, animated: true)
    }

}
//MARK: - Actions
extension RequestRefundVC{
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnRefundAll:
            self.refundAllAction()
        case btnRefundIndividual:
            self.refundIndividualAction()
        case  btnProcssRefund :
            self.btnProcssRefundAction()

        default:
            break
        }
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
        self.tblRefundTableView.reloadData()
    }
    
    
    
    @objc func actionBtnCheck(_ sender: UIButton) {
        arrData.forEach({ value in
            value.isSelected = false
            
        })
        arrData[sender.tag].isSelected = true
        self.tblRefundTableView.reloadData()
    }
    
    
    
    @IBAction func actionSegmentControl(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            self.segmentControl.setTitleTextAttributes([.font: UIFont.setFont(fontType: .regular, fontSize:.twelve)], for: .normal)
            self.segmentControl.setTitleTextAttributes([.font: UIFont.setFont(fontType: .regular, fontSize:.twelve)], for: .selected)
            self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .lblTextPara) ], for: .normal)
            self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .white) ], for: .selected)
            
        case 1:
            self.segmentControl.setTitleTextAttributes([.font: UIFont.setFont(fontType: .regular, fontSize:.twelve)], for: .normal)
            self.segmentControl.setTitleTextAttributes([.font: UIFont.setFont(fontType: .regular, fontSize:.twelve)], for: .selected)
            self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .lblTextPara) ], for: .normal)
            self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .white) ], for: .selected)

        default:
            break
            
        }
    
    }
    
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension RequestRefundVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int{
            return arrData.count
   
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrData[section].isExpanded == true{
            return 1
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestRefundTableViewCell", for: indexPath)
        as! RequestRefundTableViewCell
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ReqRefundHeaderView") as! ReqRefundHeaderView
        headerView.contentView.backgroundColor = UIColor.white
        headerView.btnUp.tag = section
        headerView.btnCheck.tag = section
        headerView.btnCheck.addTarget(self, action: #selector(actionBtnCheck(_ :)), for: .touchUpInside)
        headerView.btnUp.addTarget(self, action: #selector(nextBtn(sender:)), for: .touchUpInside)
        let obj = arrData[section]
        if isRefundAll == true {
            headerView.btnCheck.setImage(UIImage(named: "active_ip"), for: .normal)
        } else {
            let img = obj.isSelected ? "active_ip" : "uncheck_ip"
            headerView.btnCheck.setImage(UIImage(named: img), for: .normal)
        }
      
        if obj.isExpanded == true {
            headerView.btnUp.setImage(UIImage(named: "circlechevronUp_ip"), for: .normal)
            headerView.headerBottomLine.isHidden = true
        }else {
            headerView.btnUp.setImage(UIImage(named: "circleChevron-down_ip"), for: .normal)
            headerView.headerBottomLine.isHidden = false
        }
        
        return headerView

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        arrData.forEach({ value in
            value.isSelected = false
            
        })
        arrData[indexPath.row].isSelected = true
        self.tblRefundTableView.reloadData()
    }
    
    
    
}
//MARK: - NavigationBarViewDelegate
extension RequestRefundVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
  
}
