//
// SearchVC.swift
// TicketGateway
//
// Created by Apple on 21/06/23.
//
import UIKit
class SearchVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tblSearchTableView: UITableView!
    @IBOutlet weak var lblScan: UILabel!
    @IBOutlet weak var imgScan: UIImageView!
    @IBOutlet weak var btnScan: UIButton!
    @IBOutlet weak var lblFindRfid: UILabel!
    @IBOutlet weak var imgFindRfid: UIImageView!
    @IBOutlet weak var btnFindRfid: UIButton!
    @IBOutlet weak var lblSearch: UILabel!
    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblSearchText: UILabel!
    
    //MARK: - Variables
    let viewModel = SearchViewModel()
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setFont()
        self.setTableView()
        self.setTextField()
    }
    func setTextField() {
        self.view.addSubview(textField)
        textField.frame = CGRect(origin: .zero, size: .zero)
        var txtSearch = CustomSearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        txtSearch.locationView.isHidden = true
        txtSearch.btnMenu.isHidden = true
        txtSearch.btnFilter.isHidden = true
        txtSearch.txtSearch.addTarget(self, action: #selector(actionTextField(_ :)), for: .allEditingEvents)
        textField.inputAccessoryView = txtSearch
        textField.becomeFirstResponder()
        txtSearch.txtSearch.becomeFirstResponder()
    }
    @objc func actionTextField(_ sender: UITextField) {
        lblSearchText.text = sender.text
    }
}
//MARK: -
extension SearchVC {
    func setTableView() {
        self.tblSearchTableView.separatorColor = UIColor.clear
        self.tblSearchTableView.delegate = self
        self.tblSearchTableView.dataSource = self
        self.tblSearchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
    }
    func setFont() {
        self.lblScan.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblScan.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.imgScan.image = UIImage(named: SCAN_UNSELECTED_ICON)
        self.lblFindRfid.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblFindRfid.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.imgFindRfid.image = UIImage(named: FIND_UNSELECT_ICON)
        self.lblSearch.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        let gradient = getGradientLayer(bounds: view.bounds)
        self.lblSearch.textColor = gradientColor(bounds: view.bounds, gradientLayer: gradient)
        self.imgSearch.image = UIImage(named: SEARCH_SELECTED_ICON)
        self.lblSearchText.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblSearchText.textColor = UIColor.setColor(colorType: .TGBlack)
    }
}
//MARK: - UITableViewDataSource, UITableViewDelegate
extension SearchVC: UITableViewDataSource, UITableViewDelegate {
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.textField.resignFirstResponder()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}
//MARK: - Instance Method
extension SearchVC {
    func setUI() {
        [self.btnSearch, self.btnScan, self.btnFindRfid, self.btnBack].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        }
    }
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnScan:
            self.btnScanAction()
        case btnFindRfid:
            self.btnFindRfidAction()
        case btnSearch:
            self.btnSearchAction()
        case btnBack:
            self.btnBackAction()
        default:
            break
        }
    }
    func btnScanAction() {
        let vc = createView(storyboard: .scanevent, storyboardID: .ScannerVC)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    func btnFindRfidAction() {
        let vc = createView(storyboard: .scanevent, storyboardID: .FindRFIDVC)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    func btnSearchAction() {
        
    }
    func btnBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
