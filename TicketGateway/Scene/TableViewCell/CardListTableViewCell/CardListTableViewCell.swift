//
//  CardListTableViewCell.swift
//  TicketGateway
//
//  Created by apple on 10/17/23.
//

import UIKit

class CardListTableViewCell: UITableViewCell {
    @IBOutlet var lblCardHolderName: UILabel!
    @IBOutlet var lblCardType: UILabel!
    @IBOutlet var lblCardNumber: UILabel!
    @IBOutlet var imgCardSelect: UIImageView!
    @IBOutlet var imgSelected: UIImageView!
    @IBOutlet var cardView: CustomGradientView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data:CardList?, isSelectedData:CardList?){
        self.lblCardHolderName.text = data?.name ?? ""
        self.lblCardType.text = (data?.brand ?? "") + " " + "Card"
        self.lblCardNumber.text = "************\(data?.last4 ?? 0)"
        if let isSelectedData = isSelectedData{
            if isSelectedData.cardID == data?.cardID{
                self.imgSelected.image = UIImage(named: ACTIVE_ICON)
            }else{
                self.imgSelected.image = UIImage(named: UNACTIVE_ICON)
            }
        }else{
            self.imgSelected.image = UIImage(named: UNACTIVE_ICON)
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
