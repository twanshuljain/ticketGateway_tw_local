//
//  FilterViewController.swift
//  TicketGateway
//
//  Created by Apple on 27/06/23.
//

import UIKit


class FilterViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tblFilterSection:UITableView!
    @IBOutlet weak var tblFilterSelectedSection:UITableView!
    @IBOutlet weak var btnCancel:UIButton!
    @IBOutlet weak var btnApply:CustomButtonGradiant!
    
    //MARK: - Variables
    var viewModel = FilterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpUI()
    }
}

//MARK: - Functions
extension FilterViewController{
    func setUpUI() {
        self.tblFilterSection.delegate = self
        self.tblFilterSection.dataSource = self
        self.tblFilterSelectedSection.delegate = self
        self.tblFilterSelectedSection.dataSource = self
        self.tblFilterSection.register(UINib(nibName: "FilterSectionTableViewCell", bundle: .main), forCellReuseIdentifier: "FilterSectionTableViewCell")
        self.tblFilterSelectedSection.register(UINib(nibName: "FilterSelectedTableViewCell", bundle: .main), forCellReuseIdentifier: "FilterSelectedTableViewCell")
        self.tblFilterSection.reloadData()
        self.tblFilterSelectedSection.reloadData()
        //lblImageCollectionHeader.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        //lblImageCollectionHeader.textColor = UIColor.setColor(colorType: .tgBlack)
        self.updateUI()
    }
    
    func updateUI() {
        if self.viewModel.selectedFilterIndex != nil{
            self.btnApply.setBackGround()
            self.btnApply.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
            self.btnApply.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
            
            self.btnCancel.backgroundColor = UIColor.setColor(colorType: .white)
            self.btnCancel.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
            self.btnCancel.titleLabel?.textColor = UIColor.setColor(colorType: .borderColor)
        } else {
            self.btnApply.gradientLayer.removeFromSuperlayer()
            self.btnApply.backgroundColor = UIColor.setColor(colorType: .bgPurpleColor)
            self.btnApply.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
            self.btnApply.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
            
            self.btnCancel.backgroundColor = UIColor.setColor(colorType: .white)
            self.btnCancel.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
            self.btnCancel.titleLabel?.textColor = UIColor.setColor(colorType: .borderColor)
        }
    }
}

//MARK: - Functions
extension FilterViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tblFilterSection{
            return viewModel.arrFilterSection.count
        } else {
            return viewModel.arrFilter.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tblFilterSection{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FilterSectionTableViewCell", for: indexPath) as? FilterSectionTableViewCell{
                let data = self.viewModel.arrFilterSection[indexPath.row]
                cell.setData(str: data, selectedIndex: self.viewModel.selectedFilterSectionIndex, index: indexPath.row)
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FilterSelectedTableViewCell", for: indexPath) as? FilterSelectedTableViewCell{
                let data = self.viewModel.arrFilter[indexPath.row]
                cell.setData(str: data, selectedIndex: self.viewModel.selectedFilterIndex ?? 10, index: indexPath.row)
                self.updateUI()
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tblFilterSection{
            return UITableView.automaticDimension
        } else {
            if (indexPath.row == 2) && (self.viewModel.selectedFilterIndex == 2) {
                return 350
            } else {
                return 60
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tblFilterSection{
            self.viewModel.selectedFilterSectionIndex = indexPath.row
            tableView.reloadData()
        } else {
            self.viewModel.selectedFilterIndex = indexPath.row
            tableView.reloadData()
        }
    }
    
}
//MARK: - Actions
extension FilterViewController{
    @IBAction func btnCancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnApplyPressed(_ sender: UIButton) {
        
    }
}
