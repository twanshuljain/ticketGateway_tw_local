//
//  RatingCustomFooterView.swift
//  TicketGateway
//
//  Created by Apple on 30/06/23.
//

import UIKit

class RatingCustomFooterView: UITableViewHeaderFooterView {

    @IBOutlet weak var lblTitleSuggestion: UILabel!
    @IBOutlet weak var lblFeedbackTextView: PlaceholderTextView!
    @IBOutlet weak var btnFeedback: CustomButtonGradiant!
    @IBOutlet weak var txtView:UITextView!
    
    
    
    @IBAction private func btnFeedbackPressed(_ sender: UIButton) {
        
    }
    
}
