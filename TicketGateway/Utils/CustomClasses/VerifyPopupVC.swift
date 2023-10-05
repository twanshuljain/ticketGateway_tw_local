//
//  VerifyPopupVC.swift
//  TicketGateway
//
//  Created by Apple  on 18/04/23.
//

import UIKit

class VerifyPopupVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var lblVerifyMsg: UILabel!
    @IBOutlet weak var btnGreat: UIButton!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgSuccess: UIImageView!
    @IBOutlet weak var lblTitleVerified: UILabel!

    // MARK: - Variables
    var closerForBack : ((_ isTrue: Bool) -> Void)?
    var strMessage = ""
    var img = ""
    var strMsgForlbl = ""
    var strMsgBtn = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFont()
        self.lblVerifyMsg.text = strMessage
        self.imgBackground.applyBlurEffect()
        self.imgSuccess.image = UIImage(named: img)
        self.lblTitleVerified.text = strMsgForlbl
        self.btnGreat.setTitle(strMsgBtn, for: .normal)
    }

    // MARK: - Functions
    func setFont() {
        btnGreat.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnGreat.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlack)
    }

    // MARK: - Actions
     @IBAction private func btnGreat(_ sender: Any) {
         DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
             print("the value here work:----")
             self.closerForBack!(true)
         }
         DispatchQueue.main.async {
             print("the value here ")
             self.dismiss(animated: true, completion: nil)
         }
     }

}
