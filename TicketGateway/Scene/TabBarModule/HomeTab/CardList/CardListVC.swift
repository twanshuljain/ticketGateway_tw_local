//
//  CardListVC.swift
//  TicketGateway
//
//  Created by apple on 10/17/23.
//

import UIKit
import iOSDropDown


protocol CardListVCProtocol {
    func refreshSelection()
}

class CardListVC: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var lblTotalTicketPrice :DropDown!
    
    // MARK: All Properties
    var viewModel: CardListViewModel = CardListViewModel()
    var paymentViewModel = EventBookingPaymentMethodViewModel()
    var delegate:CardListVCProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
}

//MARK: - Functions
extension CardListVC {
    private func setup() {
        self.navigationView.btnBack.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = CARD_LIST
        self.navigationView.vwBorder.isHidden = false
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        btnContinue.setTitles(text: TITLE_CONTINUE, font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
        [self.btnContinue].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.lblTotalTicketPrice.text = "\(self.viewModel.selectedCurrencyType)\(self.viewModel.totalTicketPrice)"
        self.registerTableView()
    }
    
    func registerTableView(){
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib(nibName: "CardListTableViewCell", bundle: nil),
                         forCellReuseIdentifier: "CardListTableViewCell")
        tblView.reloadData()
    }
    
}

//MARK: - Actions
extension CardListVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        default:
            break
        }
    }
    
    func btnContinueAction() {
        let validate = self.viewModel.checkValidations(vc: self)
        if validate{
            self.viewModel.createCustomer(vc: self)
        }
        
    }
}
//MARK: - UITableViewDelegate,UITableViewDataSource
extension CardListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrCardList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CardListTableViewCell", for: indexPath) as? CardListTableViewCell {
            if self.viewModel.arrCardList?.indices.contains(indexPath.row) ?? false{
                cell.selectionStyle = .none
                let data = self.viewModel.arrCardList?[indexPath.row]
                cell.setData(data: data, isSelectedData: self.viewModel.selectedCard)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.viewModel.arrCardList?.indices.contains(indexPath.row) ?? false{
            var data = self.viewModel.arrCardList?[indexPath.row]
            self.viewModel.selectedCard = data
            self.tblView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width/2.5
    }
}
//MARK: - NavigationBarViewDelegate
extension CardListVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        self.delegate?.refreshSelection()
    self.navigationController?.popViewController(animated: true)
  }
}
