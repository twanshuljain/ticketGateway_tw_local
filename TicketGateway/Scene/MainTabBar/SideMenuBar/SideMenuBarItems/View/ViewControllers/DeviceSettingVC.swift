//
//  DeviceSettingVC.swift
//  TicketGateway
//
//  Created by Apple  on 02/06/23.
//

import UIKit
import SideMenu

class DeviceSettingVC: UIViewController {
    
    // MARK: - Outlet
        @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var lblPushNotificationsOn: UILabel!
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var lblRateUs: UILabel!
    @IBOutlet weak var lblFeedBack: UILabel!
    @IBOutlet weak var lblHowToUseApp: UILabel!
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var lblEmailId: UILabel!
    @IBOutlet weak var lblfaceIdId: UILabel!
    @IBOutlet weak var lblChangeAvtarImage: UILabel!
    @IBOutlet weak var lblVersiom: UILabel!
     @IBOutlet weak var btnRateUs: UIButton!
    @IBOutlet weak var btnFeedback: UIButton!
    @IBOutlet weak var btnhowToUseApp: UIButton!
    @IBOutlet weak var btnEmailId: UIButton!
    @IBOutlet weak var btnfaceId: UIButton!
    @IBOutlet weak var btnchageAvtarImage: UIButton!
      
    // MARK: - LifeCycle
        override func viewDidLoad() {
            super.viewDidLoad()
            self.setup()
         }
        
    }
    // MARK: - Functions
    extension DeviceSettingVC {
        private func setup() {
            self.navigationView.delegateBarAction = self
            self.navigationView.lblTitle.text = "Device settings"
            self.navigationView.btnBack.isHidden = false
            self.navigationView.delegateBarAction = self
            self.navigationView.imgBack.image = UIImage(named: "Menu")
            self.navigationView.vwBorder.isHidden = false
            [self.btnfaceId,self.btnFeedback,self.btnRateUs,self.btnhowToUseApp,self.btnchageAvtarImage,self.btnEmailId].forEach {
                $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            }
            self.setUi()
        }
       
        func setUi(){
            self.lblPushNotificationsOn.font = UIFont.setFont(fontType: .regular, fontSize: .eighteen)
            self.lblPushNotificationsOn.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
            
            [self.lblAbout,self.lblVersiom,self.lblProfile].forEach{
                $0.font = UIFont.setFont(fontType: .regular, fontSize: .thirteen)
                $0.textColor = UIColor.setColor(colorType: .lblTextPara)
            }
            
            [self.lblRateUs,self.lblFeedBack,self.lblHowToUseApp,self.lblEmailId,self.lblfaceIdId,self.lblChangeAvtarImage].forEach{
                $0.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
                $0.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
            }
            
         
        }
       
    }

    // MARK: - Actions
extension DeviceSettingVC {
        @objc func buttonPressed(_ sender: UIButton) {
            switch sender {
            case btnRateUs:
                btnRateUsAction()
            case btnFeedback:
                btnFeedbackAction()
            case btnfaceId:
                btnfaceIdAction()
            case btnEmailId:
                btnEmailIdAction()
            case btnhowToUseApp:
                btnhowToUseAppAction()
            case btnchageAvtarImage:
                btnchageAvtarImageAction()
            
            default:
                break
            }
        }
       
        func btnRateUsAction(){
            
        }
    func btnFeedbackAction(){
        
    }
    func btnfaceIdAction(){
        
    }
    func btnEmailIdAction(){
        
    }
    func btnhowToUseAppAction(){
        
    }
    func btnchageAvtarImageAction(){
        
    }
    }


    // MARK: - Back
    extension DeviceSettingVC : NavigationBarViewDelegate {
        func navigationBackAction() {
            let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
            let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
            present(menu, animated: true, completion: nil)
      }
    }
