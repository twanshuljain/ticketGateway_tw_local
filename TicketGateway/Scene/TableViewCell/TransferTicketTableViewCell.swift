//
//  TransferTicketTableViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 31/05/23.
//

import UIKit

class TransferTicketTableViewCell: UITableViewCell {

 // MARK: - Outlet
    @IBOutlet weak var lblTicketId: UILabel!
    @IBOutlet weak var lblTicketIdValue: UILabel!
    @IBOutlet weak var lblNameOnTicket: UILabel!
    @IBOutlet weak var lblNameOnTicketValue: UILabel!
    @IBOutlet weak var btnContinueToTransfer: CustomButtonGradiant!
   
    @IBOutlet weak var lblTransferredTo: UILabel!
    @IBOutlet weak var lblTransferredToValue: UILabel!
    @IBOutlet weak var btnCopyEmail: UIButton!
    
    @IBOutlet weak var vwBottomLine: UIView!
    @IBOutlet weak var emailStackView: UIView!
    @IBOutlet weak var emailCopyStackView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }
    
    func setData(data:MyTicket) {
        lblTicketIdValue.text = "\(data.ticketID ?? 0)"
        lblNameOnTicketValue.text = data.nameOnTicket ?? ""
        lblTransferredToValue.text = data.transferredEmail ?? ""
        
        if data.isTransfer ?? false {
            self.emailStackView.isHidden = false
            self.emailCopyStackView.isHidden = false
            btnContinueToTransfer.setTitle("Resend", for: .normal)
        } else {
            self.emailStackView.isHidden = true
            self.emailCopyStackView.isHidden = true
            btnContinueToTransfer.setTitle("Continue to Transfer", for: .normal)
        }
    }
    
    func setFont() {
        let lbls = [lblTicketId,  lblNameOnTicket, lblTransferredTo]
        for lbl in lbls {
            lbl?.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
            lbl?.textColor = UIColor.setColor(colorType: .tgGrey)
        }
        
        
        let valueLbls = [lblTicketIdValue,  lblNameOnTicketValue, lblTransferredToValue]
        for lbl in valueLbls {
            lbl?.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
            lbl?.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
        self.btnCopyEmail.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.btnCopyEmail.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlack)
        
        self.btnContinueToTransfer.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnContinueToTransfer.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        self.btnContinueToTransfer.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
    }
    
}
