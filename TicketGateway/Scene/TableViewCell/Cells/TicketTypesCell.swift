//
//  TicketTypesCell.swift
//  TicketGateway
//
//  Created by Apple  on 11/05/23.
//

import UIKit

class TicketTypesCell: UITableViewCell {

//MARK: - Outlet
    @IBOutlet weak var vwDotted: UIView!
    @IBOutlet weak var vwStepper: CustomStepper!
    @IBOutlet weak var vwEtcDiscripation: UIView!
    @IBOutlet weak var vwForGroup: UIView!
    @IBOutlet weak var vwTittle: UIView!
    @IBOutlet weak var lblDiscripation: UILabel!
    @IBOutlet weak var lblAmountWithAdditionCharge: UILabel!
    @IBOutlet weak var lblSecAmount: UILabel!
    @IBOutlet weak var lblNoOfInGroup: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblTittle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
    }
    
    func setData(event :EventTicket?){
        if let event = event{
            self.lblTittle.text = event.ticketName ?? ""
            
          //  self.lblAmount.text = "\(event.ticketCurrencyType ?? "")"+"$"+"\(event.ticketPrice ?? 0)"
            self.lblAmount.isHidden = true
            self.vwForGroup.isHidden = true
            self.lblNoOfInGroup.text = ""
             self.lblSecAmount.text = "\(event.ticketCurrencyType ?? "")"+"$"+"\(event.ticketPrice ?? 0)"
            //self.lblAmountWithAdditionCharge.text = "Incl. CAD$10.00 Facility Fee"
            self.lblAmountWithAdditionCharge.text = "(Incl. fees)"
            
            if let endDate = event.ticketSaleEndDate {
               self.lblDiscripation.text = "Sales end \(String(describing: endDate.getDateFormattedFromTo()))"
            }
           
        }
    }
    
    func setSelectedTicketData(selectedTicket:EventTicket?){
        if let selectedTicket = selectedTicket?.selectedTicketQuantity{
            self.vwStepper.lblCount.text = String(selectedTicket)
        }
    }

    
    func setUi(){
        self.lblTittle.font = UIFont.setFont(fontType: .medium, fontSize: .eighteen)
        self.lblTittle.textColor = UIColor.setColor(colorType: .tgBlack)
        self.lblAmount.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblAmount.textColor = UIColor.setColor(colorType: .tgBlack)
        self.lblNoOfInGroup.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblNoOfInGroup.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblSecAmount.font = UIFont.setFont(fontType: .medium, fontSize: .eighteen)
        self.lblSecAmount.textColor = UIColor.setColor(colorType: .tgBlack)
        self.lblAmountWithAdditionCharge.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblAmountWithAdditionCharge.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblDiscripation.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblDiscripation.textColor = UIColor.setColor(colorType: .lblTextPara)
        vwDotted.createDottedLine(width: 1.5, color: UIColor.lightGray.cgColor, dashPattern: [1,4])
    }
    
}
