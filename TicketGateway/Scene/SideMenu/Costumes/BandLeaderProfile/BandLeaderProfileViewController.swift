//
//  BandLeaderProfileViewController.swift
//  TicketGateway
//
//  Created by Apple on 29/06/23.
//

import UIKit
import AdvancedPageControl

class BandLeaderProfileViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblMailId: UILabel!
    @IBOutlet weak var btnFollow:UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var vwNavigationBar: NavigationBarView!
    @IBOutlet weak var tbleViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imagePageController: AdvancedPageControlView!
    @IBOutlet weak var lblOtherBrandLeader: UILabel!
    @IBOutlet weak var btnSeeAll: UIButton!
    @IBOutlet weak var htCollectionView:NSLayoutConstraint!
    @IBOutlet weak var htImageController:NSLayoutConstraint!
    @IBOutlet weak var htbtnSeeAll:NSLayoutConstraint!

    // MARK: - Variables
    var viewModel  = BandLeaderProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.toSetPageControll()
        self.setNavigationBar()
        self.configureTableView()
        self.setCollectionView()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tblView.layoutIfNeeded()
        tbleViewHeight.constant = tblView.contentSize.height
    }
}

// MARK: - Functions
extension BandLeaderProfileViewController{
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "OtherBrandLeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OtherBrandLeaderCollectionViewCell")
    }

    func configureTableView() {
        self.tblView.separatorColor = UIColor.clear
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.register(UINib(nibName: "CostumeTableViewCell", bundle: nil), forCellReuseIdentifier: "CostumeTableViewCell")
        self.tblView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        self.tblView.register(UINib(nibName: "LeaderProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "LeaderProfileTableViewCell")
        self.tblView.register(UINib(nibName: "ContactDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactDetailsTableViewCell")
        self.tblView.reloadData()
        tblView.layoutIfNeeded()
        tbleViewHeight.constant = tblView.contentSize.height
    }

    func setNavigationBar() {
        self.vwNavigationBar.lblTitle.text = BAND_LEADER_PROFILE
        self.vwNavigationBar.delegateBarAction = self
        self.vwNavigationBar.btnBack.isHidden = false
        self.vwNavigationBar.vwBorder.isHidden = false

    }

    func setUpUI() {
        self.lblFullName.font = UIFont.setFont(fontType: .semiBold, fontSize: .twentyFour)
        self.lblFullName.textColor = UIColor.setColor(colorType: .tgBlack)
        self.lblMailId.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblMailId.textColor = UIColor.setColor(colorType: .lblTextPara)

        self.btnFollow.titleLabel?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.btnFollow.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlack)

        self.lblOtherBrandLeader.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblOtherBrandLeader.textColor = UIColor.setColor(colorType: .tgBlack)

        self.btnSeeAll.titleLabel?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.btnFollow.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlue)

        self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .white) ], for: .selected)
        self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .segmentColor) ], for: .normal)
    }
}
// MARK: - Actions
extension BandLeaderProfileViewController{

    @IBAction func actionSegmentControl(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            self.segmentControl.setTitleTextAttributes([.font: UIFont.setFont(fontType: .regular, fontSize:.twelve)], for: .normal)
            self.segmentControl.setTitleTextAttributes([.font: UIFont.setFont(fontType: .regular, fontSize:.twelve)], for: .selected)
            self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .segmentColor) ], for: .normal)
            self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .white) ], for: .selected)
            self.tblView.layoutIfNeeded()
            viewModel.isAboutSelected = false
            htCollectionView.constant = 262
            htImageController.constant = 20
            htbtnSeeAll.constant = 25
            btnSeeAll.isHidden = false
            //self.collectionView.reloadData()
            self.tblView.reloadData()
            tblView.layoutIfNeeded()
            tbleViewHeight.constant = tblView.contentSize.height
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()

        case 1:
            self.segmentControl.setTitleTextAttributes([.font: UIFont.setFont(fontType: .regular, fontSize:.twelve)], for: .normal)
            self.segmentControl.setTitleTextAttributes([.font: UIFont.setFont(fontType: .regular, fontSize:.twelve)], for: .selected)
            self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .segmentColor) ], for: .normal)
            self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .white) ], for: .selected)
            viewModel.isAboutSelected = true
            btnSeeAll.isHidden = true
            htCollectionView.constant = 0
            htImageController.constant = 0
            htbtnSeeAll.constant = 0
            self.tblView.reloadData()
            tblView.layoutIfNeeded()
            tbleViewHeight.constant = tblView.contentSize.height
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        default:
            break
        }
    }

}

// MARK: - NavigationBarViewDelegate
extension BandLeaderProfileViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if !viewModel.isAboutSelected{
            return 1
        } else {
            return 3
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !viewModel.isAboutSelected{
            return viewModel.arrCostumeItems.count
        } else {
            switch section {
            case 0: return 1
            case 1: return 5
            case 2: return 1
            default:
                return 0
            }
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !viewModel.isAboutSelected{
            let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 0))
            return headerView
        } else {
            let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 20))
            let label = UILabel()
            label.frame = CGRect.init(x: 16, y: 0, width: headerView.frame.width-16, height: headerView.frame.height)
            label.font = UIFont.setFont(fontType: .medium, fontSize: .twenty)
            label.textColor = UIColor.setColor(colorType: .tgBlack)

            headerView.addSubview(label)

            switch section {
            case 0:
                label.text = DESCRIPTION
                return headerView
            case 1:
                label.text = SECTION_LEADER
                return headerView
            case 2:
                label.text = CONTACT_DETAILS
                return headerView
            default:
                label.text = ""
                return headerView
            }
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !viewModel.isAboutSelected{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CostumeTableViewCell", for: indexPath) as? CostumeTableViewCell{
                cell.selectionStyle = .none
                let data = viewModel.arrCostumeItems[indexPath.row]
                cell.setData(costumeObj: self.viewModel.costumeObj, isForDetailVC: self.viewModel.isForDetailVC)

                return cell
            }
            return UITableViewCell()
        } else {
            switch indexPath.section {
            case 0:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as? DescriptionTableViewCell{
                    cell.selectionStyle = .none
//                    let data = viewModel.arrCostumeItems[indexPath.row]
//                    cell.setData(costumeObj: self.costumeObj, isForDetailVC: isForDetailVC)

                    return cell
                }
            case 1:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderProfileTableViewCell", for: indexPath) as? LeaderProfileTableViewCell{
                    cell.selectionStyle = .none
                    cell.setData(indexPath: indexPath)
//                    let data = viewModel.arrCostumeItems[indexPath.row]
//                    cell.setData(costumeObj: self.costumeObj, isForDetailVC: isForDetailVC)

                    return cell
                }
            case 2:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "ContactDetailsTableViewCell", for: indexPath) as? ContactDetailsTableViewCell{
                    cell.selectionStyle = .none
//                    let data = viewModel.arrCostumeItems[indexPath.row]
//                    cell.setData(costumeObj: self.costumeObj, isForDetailVC: isForDetailVC)

                    return cell
                }
            default:
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if !viewModel.isAboutSelected{
            return 0
        } else {
            return 20
        }
    }
}

// MARK: - NavigationBarViewDelegate
extension BandLeaderProfileViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.arrBrandLeader.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherBrandLeaderCollectionViewCell", for: indexPath) as? OtherBrandLeaderCollectionViewCell{
            let data = viewModel.arrBrandLeader[indexPath.row]
            cell.setData(imgName: data)
            return cell
        }
        return UICollectionViewCell()

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.bounds.width - 25, height: collectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

}

// MARK: - PageController
extension BandLeaderProfileViewController {
    func toSetPageControll() {
        imagePageController.drawer = ExtendedDotDrawer(numberOfPages: self.viewModel.arrBrandLeader.count,
                                                       space: 16.0,
                                                       indicatorColor: UIColor.setColor(colorType: .titleColourDarkBlue),
                                                       dotsColor: UIColor.setColor(colorType: .placeHolder),
                                                       isBordered: false,
                                                       borderWidth: 0.0,
                                                       indicatorBorderColor: .clear,
                                                       indicatorBorderWidth: 0.0)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        imagePageController.setPageOffset(offSet / width)

    }
}

// MARK: - NavigationBarViewDelegate
extension BandLeaderProfileViewController: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }  
}
