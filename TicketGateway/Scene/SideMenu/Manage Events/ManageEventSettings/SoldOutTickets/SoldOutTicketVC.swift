//
//  SoldOutTicketVC.swift
//  TicketGateway
//
//  Created by Apple on 03/07/23.


import UIKit

class SoldOutTicketVC: UIViewController {
    
// MARK: - Outlets
    
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var soldOutTicketTableView: UITableView!
    @IBOutlet weak var lblSoldOutTickets: UILabel!
    
    
// MARK: - Variables
    let viewModel = SoldOutTicketsViewModel()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.setTableView()
        self.setFont()

    }
  
}

// MARK: - FUNCTIONS
extension SoldOutTicketVC {
    
    func setNavigationBar() {
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.imgBack.isHidden = false
        self.vwNavigationView.lblDiscripation.isHidden = false
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.lblTitle.text = HEADER_TITLE_SUNBURN
        self.vwNavigationView.lblDiscripation.text = HEADER_DESCRIPTION_DATE_TIME
        self.vwNavigationView.vwBorder.isHidden = false
        
        
    }
    
    func setTableView() {
        self.soldOutTicketTableView.separatorColor = UIColor.clear
        self.soldOutTicketTableView.delegate = self
        self.soldOutTicketTableView.dataSource = self
        self.soldOutTicketTableView.register(UINib(nibName: "SoldOutTicketTableViewCell", bundle: nil), forCellReuseIdentifier:  "SoldOutTicketTableViewCell")
    }
    
    func setFont() {
        self.lblSoldOutTickets.font = UIFont.setFont(fontType: .semiBold, fontSize: .eighteen)
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension SoldOutTicketVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoldOutTicketTableViewCell", for:  indexPath) as! SoldOutTicketTableViewCell
        let data = viewModel.arrData[indexPath.row]
        cell.lblGeneralAdmission.text = data["title"]
        cell.lblTotalTicket.text = data["description"]
        return cell

    }
  
}

// MARK: - NavigationBarViewDelegate
extension SoldOutTicketVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
