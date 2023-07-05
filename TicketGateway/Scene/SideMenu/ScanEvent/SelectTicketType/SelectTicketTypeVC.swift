//
//  SelectTicketTypeVC.swift
//  TicketGateway
//
//  Created by Apple on 16/06/23.
//

import UIKit

class SelectTicketTypeVC: UIViewController {
    
//MARK: - Outlets
    @IBOutlet weak var tblTicketTypeTablView: UITableView!
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var btnSelectAll: UIButton!
    @IBOutlet weak var btnDone: CustomButtonGradiant!
    
//MARK: - Variable
    let viewModel = SelectTicketTypeViewModel()

    let tblData = ["Early Bird", "Free", "Request", "Hidden" , "Request Ticket", "Ticket Type 1", "Ticket Type 2", "Ticket Type 3", "Ticket Type 4"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationview()
        self.setTableView()
        self.setFont()
        self.setUI()

    }
    


}

//MARK: -
extension SelectTicketTypeVC {
   
    func setNavigationview() {
        self.vwNavigationView.delegateBarAction = self
         self.vwNavigationView.btnBack.isHidden = false
         self.vwNavigationView.lblTitle.text = "Select ticket Type"
         self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
         self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.vwNavigationView.vwBorder.isHidden = false
    }
    
    func setTableView() {
        self.tblTicketTypeTablView.delegate = self
        self.tblTicketTypeTablView.dataSource = self
    }
    
    func setFont() {
        self.btnSelectAll.titleLabel?.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.btnSelectAll.titleLabel?.textColor = UIColor.setColor(colorType: .TGBlue)
        
        self.btnDone.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnDone.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension SelectTicketTypeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectTicketTypeTableviewCell", for: indexPath) as! SelectTicketTypeTableviewCell
        let data = tblData[indexPath.row]
        cell.lblTicketType.text = data
        return cell
    }
    
    
}

//MARK: -
extension SelectTicketTypeVC {
    func setUI() {
        [self.btnDone, self.btnSelectAll].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        }
        
    }
    
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnDone:
            self.btnDoneAction()
        case btnSelectAll:
            self.btnSelectAllAction()
        default:
            break
        }
        
    }
    
    func btnDoneAction() {
        let vc = createView(storyboard: .scanevent, storyboardID: .ScannerVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func btnSelectAllAction() {
        
    }
    
   
    
    
}




//MARK: -
extension SelectTicketTypeVC: NavigationBarViewDelegate {
    func navigationBackAction() {
     self.navigationController?.popViewController(animated: false)
//        let vc = createView(storyboard: .scanevent, storyboardID: .ScanEventVC)
//        self.navigationController?.pushViewController(vc, animated: false )
    }
  
}
