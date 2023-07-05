//
//  ReviewRefundVC.swift
//  TicketGateway
//
//  Created by Apple on 07/06/23.
//

import UIKit

class ReviewRefundVC: UIViewController {

    let arrData = ["At the door", "At the door", "At the door"]
   
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    
    @IBOutlet weak var tblReviewrefund: UITableView!
    
    @IBOutlet weak var lblTotalToRefundPrice: UILabel!
    @IBOutlet weak var lblTotalToRefund: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNamePrice: UILabel!
    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var lblOrderNoValue: UILabel!
    @IBOutlet weak var lblTotalTicket: UILabel!
    @IBOutlet weak var lblTotalTicketValue: UILabel!
    
    @IBOutlet weak var lblTickets: UILabel!
    @IBOutlet weak var lblRefundAmount: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationView()
        self.setTableView()
        self.setFont()

    }
    
    func setNavigationView(){
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = "Review Refund"
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)

    }
    
    func setTableView() {
        self.tblReviewrefund.separatorColor = UIColor.clear
        self.tblReviewrefund.delegate = self
        self.tblReviewrefund.dataSource = self
        tblReviewrefund.register(UINib(nibName: "ReviewRefundTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewRefundTableViewCell")
    }
    
    func setFont(){
        self.lblTotalToRefundPrice.font = UIFont.setFont(fontType: .semiBold, fontSize: .thirtyTwo)
        let gradient = getGradientLayer(bounds: view.bounds)
        self.lblTotalToRefundPrice.textColor = gradientColor(bounds: view.bounds, gradientLayer: gradient)
        
        self.lblTotalToRefund.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblTotalToRefund.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblName.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblName.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        self.lblNamePrice.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblNamePrice.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        self.lblOrderNo.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblOrderNo.textColor = UIColor.setColor(colorType: .TGGrey)
        self.lblOrderNoValue.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblOrderNoValue.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblTotalTicket.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblTotalTicket.textColor = UIColor.setColor(colorType: .TGGrey)
        self.lblTotalTicketValue.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblTotalTicketValue.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblTickets.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblTickets.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblRefundAmount.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblRefundAmount.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        
        
        
    }
    

}


//MARK: -  UITableViewDelegate, UITableViewDataSource
extension ReviewRefundVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewRefundTableViewCell", for: indexPath) as! ReviewRefundTableViewCell
        let data = arrData[indexPath.row]
        cell.lblAtTheDoor.text = data
        return cell
    }
    
    
}

//MARK: -
extension ReviewRefundVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
  
}
