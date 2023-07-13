//
//  MyTicketVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 31/05/23.
//

import UIKit

class MyTicketVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var btnSeeFullTicket: CustomButtonNormal!
    @IBOutlet weak var btnSaveTicketAsImage: CustomButtonNormal!
    @IBOutlet weak var vwDashedLine: UIView!
    @IBOutlet weak var btnAddAppToWallet: CustomButtonNormal!
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFont()
        self.setNavigationBar()
        self.setUI()
    }
    
   
    @objc func addActionSheet() {
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "Transfer this ticket", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            let vc = self.createView(storyboard: .order, storyboardID: .TransferTicketVC)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Exchange ticket", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            let vc = self.createView(storyboard: .order, storyboardID: .ExchangeTicketVC)
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Change name on ticket", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            let vc = self.createView(storyboard: .order, storyboardID: .ChangeNameVC)
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Share this event", style: UIAlertAction.Style.default, handler: { (action) -> Void in
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Contact organiser", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            let vc = self.createView(storyboard: .order, storyboardID: .ContactOrganiserVC)
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) -> Void in
            
        }))
        self.present(actionsheet, animated: true, completion: nil)
        
    }
    
    
}

//MARK: - Functions
extension MyTicketVC{
    func setNavigationBar() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = MY_TICKETS
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.vwNavigationView.btnRight.isHidden = false
        self.vwNavigationView.btnRight.setImage(UIImage(named: MENU_DOT_ICON), for: .normal)
        self.vwNavigationView.btnRight.addTarget(self, action: #selector(addActionSheet), for: .touchUpInside)
    }
    
    func setFont() {
        
        self.vwDashedLine.createDottedLine(width: 2, color: UIColor.setColor(colorType: .BorderLineColour).cgColor, dashPattern: [6,6])
        self.btnSeeFullTicket.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSeeFullTicket.titleLabel?.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnSeeFullTicket.addRightIcon(image: UIImage(named: CHEVRON_DOWN))
        
        self.btnSaveTicketAsImage.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSaveTicketAsImage.titleLabel?.textColor = UIColor.setColor(colorType: .TGBlue)
        self.btnSaveTicketAsImage.addLeftIcon(image: UIImage(named: DOWNLOAD_ICON_ORDER))
        
        self.btnAddAppToWallet.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnAddAppToWallet.titleLabel?.textColor = UIColor.setColor(colorType: .white)
        self.btnAddAppToWallet.addLeftIcon(image: UIImage(named: APPLE_WALLET_ICON))
        
    }
    
    func setUI() {
        self.btnSeeFullTicket.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
    }
    
}

//MARK: - Actions
extension MyTicketVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnSeeFullTicket:
            self.SeeFullTicketAction()
        case btnSaveTicketAsImage:
            break
        case btnAddAppToWallet:
            break
        default:
            break
        }
    }
    
    func SeeFullTicketAction() {
        let vc = self.createView(storyboard: .order, storyboardID: .SeeFullTicketVC)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func saveTicketAsImage() {
        
    }
    
    func addAppToWalletAction() {
        
    }
}

//MARK: - NavigationBarViewDelegate
extension MyTicketVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
