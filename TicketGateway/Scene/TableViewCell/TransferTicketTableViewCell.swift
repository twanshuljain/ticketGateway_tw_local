//
//  TransferTicketTableViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 31/05/23.
//

import UIKit

class TransferTicketTableViewCell: UITableViewCell {

   
    @IBOutlet weak var lblTicketId: UILabel!
    @IBOutlet weak var lblTicketIdValue: UILabel!
    @IBOutlet weak var lblNameOnTicket: UILabel!
    @IBOutlet weak var lblNameOnTicketValue: UILabel!
    @IBOutlet weak var btnContinueToTransfer: CustomButtonGradiant!
   
    @IBOutlet weak var lblTransferredTo: UILabel!
    @IBOutlet weak var lblTransferredToValue: UILabel!
    @IBOutlet weak var btnCopyEmail: UIButton!
    
    @IBOutlet weak var vwBottomLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }
    
    func setFont() {
        let lbls = [lblTicketId,  lblNameOnTicket, lblTransferredTo]
        for lbl in lbls {
            lbl?.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
            lbl?.textColor = UIColor.setColor(colorType: .TGGrey)
        }
        
        
        let valueLbls = [lblTicketIdValue,  lblNameOnTicketValue, lblTransferredToValue]
        for lbl in valueLbls {
            lbl?.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
            lbl?.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
        self.btnCopyEmail.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.btnCopyEmail.titleLabel?.textColor = UIColor.setColor(colorType: .TGBlack)
        
        self.btnContinueToTransfer.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnContinueToTransfer.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        self.btnContinueToTransfer.addRightIcon(image: UIImage(named: "LeftArrow_ip"))
    }
    
}
