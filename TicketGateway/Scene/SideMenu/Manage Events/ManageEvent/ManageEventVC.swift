//
//  ManageEventVC.swift
//  TicketGateway
//
//  Created by Apple  on 10/05/23.
//

import UIKit
import iOSDropDown
import SideMenu

class ManageEventVC: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var vwSearchBar: CustomSearchBar!
    @IBOutlet weak var txtAllorganiser: DropDown!
    @IBOutlet weak var TblManageEvent: ManageMyEventListTableView!
    @IBOutlet weak var collVwCategory: ManageMyEventCateoryList!
    @IBOutlet weak var btnAllorganiser: UIButton!
    @IBOutlet weak var btnCreateEvent: CustomButtonGradiant!
    
    // MARK: - Variables
    var isShow = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
    }
    

}

// MARK: - Functions
extension ManageEventVC {
    private func setup() {
        vwSearchBar.delegate = self
        self.txtAllorganiser.delegate = self
        [self.btnAllorganiser].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.setUi()
        self.TblManageEvent.configure()
        self.collVwCategory.configure()
        self.txtAllorganiser.optionArray = ["Rebecca young", "Feb", "Rebecca young","Rebecca young","Rebecca young"]
        self.txtAllorganiser.optionIds = [1,23,54,22]
        self.txtAllorganiser.didSelect{(selectedText , index ,id) in
            self.txtAllorganiser.text = "Selected String: \(selectedText) \n index: \(index)"
        }
        
        self.TblManageEvent.tableDidSelectAtIndex = { _ in
            objSceneDelegate.showMangeEventTabBar()
        }
        
    }
    func setUi(){
        self.txtAllorganiser.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.txtAllorganiser.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        btnCreateEvent.setTitles(text: CREATE_EVENT, font: UIFont.boldSystemFont(ofSize: 20), tintColour: UIColor.setColor(colorType: .TGBlack))
        self.btnCreateEvent.addLeftIcon(image: UIImage(named: PLUS_ICON))
    }
}
// MARK: - Actions
extension ManageEventVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnAllorganiser:
            btnAllorganiserAction()
        default:
            break
        }
    }
   
    func btnAllorganiserAction(){
        txtAllorganiser.showList()
//        if self.isShow == false{
//            self.isShow = true
//            txtAllorganiser.showList()
//        } else {
//
//            self.isShow = false
//            txtAllorganiser.hideList()
//        }
        
    }
}

// MARK: - CustomSearchMethodsDelegate
extension ManageEventVC: CustomSearchMethodsDelegate {
    func leftButtonPressed(_ sender: UIButton) {
        
        let menu = UIStoryboard.init(name: "SideMenu", bundle: Bundle.main).instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    
    func RightButtonPressed(_ sender: UIButton) {
        print("hello")
    }
    

    
}
