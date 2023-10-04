//
//  AmountAddedSuccessfullyVC.swift
//  TicketGateway
//
//  Created by Apple  on 18/05/23.
//

import UIKit

class AmountAddedSuccessfullyVC: UIViewController {
    
    // MARK: - IBOutlets
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
}

// MARK: - Functions
extension AmountAddedSuccessfullyVC {
    func setUp() {
        self.navigationView.btnBack.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = SUCCESSFUL_ADDED
        self.navigationView.vwBorder.isHidden = false
        
        [self.btnOkey].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        btnOkey.setTitles(text: OKAY, textColour: UIColor.setColor(colorType: .tgBlue), borderColour: UIColor.setColor(colorType: .placeHolder))
        lblThanku.font = UIFont.setFont(fontType: .medium, fontSize: .twentyFive)
        lblThanku.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        
        lblAmount.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblAmount.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblAmtMsg.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblAmtMsg.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblAmountValue.font = UIFont.setFont(fontType: .semiBold, fontSize: .fifteen)
        lblAmountValue.textColor = UIColor.setColor(colorType: .lblTextPara)
        
    }
}

// MARK: - Actions
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
        self.showToast(message: AMOUNT_ADDED_SUCCESSFULLY)
    }
    
}

// MARK: - NavigationBarViewDelegate
extension AmountAddedSuccessfullyVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        
        self.navigationController?.popViewController(animated: true)
    }
}
