//
//  CardListVC.swift
//  TicketGateway
//
//  Created by apple on 10/17/23.
//

import UIKit

class CardListVC: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var tblView: UITableView!
//    @IBOutlet weak var tblView: UITableView!
    
    // MARK: All Properties
    var viewModel: CardListViewModel = CardListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "CardListTableViewCell", bundle: nil),
                         forCellReuseIdentifier: "CardListTableViewCell")
    }
    
}
extension CardListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CardListTableViewCell", for: indexPath) as? CardListTableViewCell {
            
        }
        return UITableViewCell()
    }
}
