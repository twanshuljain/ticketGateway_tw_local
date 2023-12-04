//
//  EmailSentVC.swift
//  TicketGateway
//
//  Created by Apple on 21/07/23.
//

// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name

import UIKit

class EmailSentVC: UIViewController {
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    var strForEmail: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setFont()
        
     
       
    }
    // Setting fonts for labels and buttons
    func setFont() {
        lblEmail.font = UIFont.setFont(fontType: .semiBold, fontSize: .twentyFour)
        lblEmail.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
    //   lblDescription.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
      lblDescription.textColor = UIColor.setColor(colorType: .lblTextPara)
        let attributedlabel = getAttributedTextAction(attributedText: strForEmail, firstString: "We have sent an email ", lastString: " with a link to reset your password", attributedFont: UIFont.setFont(fontType: .semiBold, fontSize: .fourteen), attributedColor: UIColor.setColor(colorType: .lblTextPara), isToUnderLineAttributeText: false)
        lblDescription.attributedText = attributedlabel
    }
    

  
}
