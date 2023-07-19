//
//  FeedbackViewController.swift
//  TicketGateway
//
//  Created by Apple on 30/06/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count

import UIKit

class FeedbackViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var vwNavigatioView: NavigationBarView!
    @IBOutlet weak var vwSegmentBackgroundView: UIView!
    @IBOutlet weak var lblRateYourExperience:UILabel!
    
    // MARK: - Variables
    var viewModel = FeedbackViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setNavigationBar()
        self.configureTableView()
        
    }
    
    
}
// MARK: - Functions
extension FeedbackViewController{
    func setNavigationBar() {
        self.vwNavigatioView.lblTitle.text = FEEDBACK
        self.vwNavigatioView.delegateBarAction = self
        self.vwNavigatioView.btnBack.isHidden = false
        self.vwNavigatioView.vwBorder.isHidden = false
        
    }
    
    func configureTableView() {
        self.tblView.separatorColor = UIColor.clear
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.register(UINib(nibName: "FeedBackTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedBackTableViewCell")
        self.tblView.register(UINib(nibName: "RatingCustomFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "RatingCustomFooterView")
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    
    func setUpUI() {
        self.lblRateYourExperience.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblRateYourExperience.textColor = UIColor.setColor(colorType: .btnDarkBlue)
    }
}
// MARK: - Actions
extension FeedbackViewController{
    @IBAction func actionSegment(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0 :
            self.viewModel.isAttendeeSelected = true
            self.tblView.reloadData()
        case 1:
            self.viewModel.isAttendeeSelected = false
            self.tblView.reloadData()
        default:
            break
        }
    }
}

//MARK: - NavigationBarViewDelegate
extension FeedbackViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isAttendeeSelected{
            return viewModel.arrFeedBackAttendee.count
        }else{
            return viewModel.arrFeedBackOrganizer.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedBackTableViewCell", for: indexPath) as? FeedBackTableViewCell{
            cell.selectionStyle = .none
            if viewModel.isAttendeeSelected{
                let feedback = viewModel.arrFeedBackAttendee[indexPath.row]
                cell.setData(feedback: feedback, index: indexPath.row)
            }else{
                let feedback = viewModel.arrFeedBackOrganizer[indexPath.row]
                cell.setData(feedback: feedback, index: indexPath.row)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RatingCustomFooterView") as! RatingCustomFooterView
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 230
    }
}
//MARK: - NavigationBarViewDelegate
extension FeedbackViewController: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
