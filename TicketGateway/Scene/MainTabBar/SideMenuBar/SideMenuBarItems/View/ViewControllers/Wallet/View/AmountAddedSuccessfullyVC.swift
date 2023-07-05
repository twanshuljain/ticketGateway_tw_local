//
//  AmountAddedSuccessfullyVC.swift
//  TicketGateway
//
//  Created by Apple  on 18/05/23.
//

import UIKit

class AmountAddedSuccessfullyVC: UIViewController {

    @IBOutlet weak var lblThanku: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblAmountValue: UILabel!
    @IBOutlet weak var lblAmtMsg: UILabel!
    @IBOutlet weak var btnOkey: CustomButtonNormalWithBorder!
    @IBOutlet weak var navigationView: NavigationBarView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()

        // Do any additional setup after loading the view.
    }
    
    func setUp(){
        self.navigationView.btnBack.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = "Successful Added"
        self.navigationView.vwBorder.isHidden = false
  
        [self.btnOkey].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        btnOkey.setTitles(text: "Okay", textColour: UIColor.setColor(colorType: .TGBlue), borderColour: UIColor.setColor(colorType: .PlaceHolder))
        lblThanku.font = UIFont.setFont(fontType: .medium, fontSize: .twentyFive)
        lblThanku.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        lblAmount.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblAmount.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblAmtMsg.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblAmtMsg.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblAmountValue.font = UIFont.setFont(fontType: .semiBold, fontSize: .fifteen)
        lblAmountValue.textColor = UIColor.setColor(colorType: .lblTextPara)
        
    }

}

extension AmountAddedSuccessfullyVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnOkey:
            self.btnOkeyAction()
        default:
            break
        }
    }
    func btnOkeyAction() {
        self.showToast(message: "Amount added Successfully")
    }
    
   }


extension AmountAddedSuccessfullyVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        
    self.navigationController?.popViewController(animated: true)
  }
}
