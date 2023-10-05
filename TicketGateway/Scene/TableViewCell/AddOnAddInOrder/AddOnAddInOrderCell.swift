//
//  AddOnAddInOrderCell.swift
//  TicketGateway
//
//  Created by Apple  on 16/05/23.
//

import UIKit

class AddOnAddInOrderCell: UITableViewCell {

    @IBOutlet weak var vwDottedLine: UIView!
    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var lblTittleValue: UILabel!

    override func awakeFromNib() {
        self.setUi()
        vwDottedLine.createDottedLine(width: 1, color: UIColor.lightGray.cgColor, dashPattern: [2,4])
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)}

    func setUi() {
        [self.lblTittle,lblTittleValue].forEach {
            $0?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            $0?.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        }
    }
    func setData(addOnData:EventTicketAddOnResponseModel?, selectedCurrencyType: String) {
        if let addOnData = addOnData{
            if let selectedTicketQuantity = addOnData.selectedTicketQuantity{
                lblTittle.text = " + " + "\(addOnData.addOnName ?? "")" + "*" + " \(selectedTicketQuantity) "
                //lblTittleValue.text = "CAD$ \(Double(addOnData.addOnTicketPrice ?? 0) * Double(selectedTicketQuantity))"

                var price = Double(addOnData.addOnTicketPrice ?? 0) * Double(selectedTicketQuantity)
                lblTittleValue.text = "\(selectedCurrencyType)\(price.convertToTwoDecimalPlaces() ?? "0.00")"
            } else {
                lblTittle.text = " + " + "\(addOnData.ticketName ?? "")"
                //lblTittleValue.text = "CAD$ \(Double(addOnData.addOnTicketPrice ?? 0))"

                var price = Double(addOnData.addOnTicketPrice ?? 0)
                lblTittleValue.text = "\(selectedCurrencyType)\(price.convertToTwoDecimalPlaces() ?? "0.00")"
            }

        }
    }
}
