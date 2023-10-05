//
//  OrganizersArtistsListVC.swift
//  TicketGateway
//
//  Created by Apple  on 04/05/23.

import UIKit
import SideMenu
import SVProgressHUD

class OrganizersArtistsListVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var lblSuggested: UILabel!
    @IBOutlet weak var btnSeeAllForSuggested: CustomButtonNormal!
    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var btnSeeAll: CustomButtonNormal!
    @IBOutlet weak var collVwTrendingArtists: UICollectionView!
    @IBOutlet weak var tblSuggestedOragArt: UITableView!
    @IBOutlet weak var navigationView: NavigationBarView!

    // MARK: - Variable
    let viewModel = LoginNmberWithEmailViewModel()
    let viewModelForOrganniser = OrganizersandArtistViewModel()
    var organiserData = [Organizers]()
    let nameFormatter = PersonNameComponentsFormatter()
    var isFrom = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        collVwTrendingArtists.delegate = self
        collVwTrendingArtists.dataSource = self
        collVwTrendingArtists.register(UINib(nibName: "SuggestedOrganizerCell", bundle: nil), forCellWithReuseIdentifier: "SuggestedOrganizerCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getOrganizersSuggestedList()
        callApiForOrganizersList(viewAll: false)
        if self.isFrom == "Organizers" {
            self.navigationView.lblTitle.text = ORGANISER
            self.lblTittle.text = TRENDING_ORGANISER
            self.lblSuggested.text = SUGGESTED_FOR_YOU
        } else {
            self.navigationView.lblTitle.text = ARTISTS
            self.lblTittle.text = TRENDING_ARTISTS
            self.lblSuggested.text = SUGGESTED_FOR_YOU
        }
    }
}

// MARK: - Functions
extension OrganizersArtistsListVC {

    func callApiForOrganizersList(viewAll: Bool) {
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            self.view.showLoading(centreToView: self.view)
            viewModelForOrganniser.getOrganizersList { isTrue, messageShowToast in
                if isTrue == true {
                    DispatchQueue.main.async { [self] in
                        self.view.stopLoading()
                        self.collVwTrendingArtists.reloadData()

                    }
                } else {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.showToast(message: messageShowToast)
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
    func getOrganizersSuggestedList() {
        if Reachability.isConnectedToNetwork() { //check internet connectivity
            self.view.showLoading(centreToView: self.view)
            viewModelForOrganniser.getOrganizersSuggestedList { isTrue, messageShowToast in
                if isTrue == true {
                    DispatchQueue.main.async { [self] in
                        self.view.stopLoading()
                        self.tblSuggestedOragArt.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.showToast(message: messageShowToast)
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
    private func setup() {
        [self.btnSeeAll,btnSeeAllForSuggested].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.setUi()
        self.tblSuggestedOragArt.dataSource = self
        self.tblSuggestedOragArt.delegate = self
        self.tblSuggestedOragArt.reloadData()
       // self.collVwTrendingArtists.configure()
        self.navigationView.delegateBarAction = self
      //  self.navigationView.imgBack.image = UIImage(named: MENU_ICON)
        self.navigationView.btnBack.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.vwBorder.isHidden = false
    }

    func setUi() {
        self.lblTittle.font = UIFont.setFont(fontType: .bold, fontSize: .eighteen)
        self.lblTittle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblSuggested.font = UIFont.setFont(fontType: .bold, fontSize: .eighteen)
        self.lblSuggested.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.btnSeeAll.setTitles(text: SEE_ALL , font: .systemFont(ofSize: 20), tintColour: .blue, textColour: UIColor.setColor(colorType: .tgBlue))
        self.btnSeeAllForSuggested.setTitles(text: SEE_ALL , font: .systemFont(ofSize: 20), tintColour: .blue, textColour: UIColor.setColor(colorType: .tgBlue))

    }
}

// MARK: - Actions
extension OrganizersArtistsListVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnSeeAll:
            self.btnSeeAllAction()
        case btnSeeAllForSuggested:
            self.btnSeeAllSuggestedAction()
        default:
            break
        }
    }

    func btnSeeAllAction() {
        if Reachability.isConnectedToNetwork() {
           // SVProgressHUD.show()
            viewModel.signInAPI { isTrue , messageShowToast in
                if isTrue == true {
                    DispatchQueue.main.async {
                   //     SVProgressHUD.dismiss()
                        objSceneDelegate.showTabBar()
                    }
                }
                else {
                    DispatchQueue.main.async {
                     //   SVProgressHUD.dismiss()
                        self.showToast(message: messageShowToast)
                    }
                }
            }
        } else {
            self.showToast(message: ValidationConstantStrings.networkLost)
        }
        }

    func btnSeeAllSuggestedAction() {
//        let vc = createView(storyboard: .sidemenu, storyboardID: .MyFollowersVC)
//        self.navigationController?.pushViewController(vc, animated:     true)
//

        if Reachability.isConnectedToNetwork() {
        //    SVProgressHUD.show()
            viewModel.signInAPI { isTrue , messageShowToast in
                if isTrue == true {
                    DispatchQueue.main.async {
                      //  SVProgressHUD.dismiss()
                        objSceneDelegate.showTabBar()
                    }
                }
                else {
                    DispatchQueue.main.async {
                      //  SVProgressHUD.dismiss()
                        self.showToast(message: messageShowToast)
                    }
                }
            }
        } else {
            self.showToast(message: ValidationConstantStrings.networkLost)
        }
        }
    func suggestedFollowButtonAction(organizerId: Int, isSuccess: (@escaping (String) -> Void)) {
        // Condition for -> If user with guest login then like/unlike feature should not work.
        if UserDefaultManager.share.getUserBoolValue(key: .isGuestLogin) {
            self.showToast(message: Unable_To_Follow)
            return
        }
        if Reachability.isConnectedToNetwork() { //check internet connectivity
            self.view.showLoading(centreToView: self.view)
            AppShareData().commanFollowUnfollowApi(
                organizerId: organizerId,
                complition: { isTrue, messageShowToast in
                    if isTrue {
                        DispatchQueue.main.async {
                            self.view.stopLoading()
                            isSuccess(messageShowToast)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.view.stopLoading()
                            self.showToast(message: messageShowToast)
                            isSuccess(messageShowToast)
                        }
                    }
                }
            )
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension OrganizersArtistsListVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelForOrganniser.arrSuggestedOrganizers.count
      //  self.viewModel.arrMail.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "OrganizersArtistsListCell", for: indexPath) as! OrganizersArtistsListCell)
        cell.suggestedOrganizerData = viewModelForOrganniser.arrSuggestedOrganizers[indexPath.row]
        cell.followButtonDidTap = { sender in
            var organizerId = self.viewModelForOrganniser.arrSuggestedOrganizers[indexPath.row].id ?? 0
            self.suggestedFollowButtonAction(organizerId: organizerId, isSuccess: { message in
                print("message from api:-", message)
                let record = self.viewModelForOrganniser.arrSuggestedOrganizers[indexPath.row]
                let id = record.id ?? 0
                if record.isFollow ?? false {
                    if message == "Successfully unfollowed" {
                        sender.setTitle("Follow", for: .normal)
                    }
                    if self.viewModelForOrganniser.arrSuggestedIssFollow.contains(id) {
                        let index = self.viewModelForOrganniser.arrSuggestedIssFollow.firstIndex(of: id)
                        self.viewModelForOrganniser.arrSuggestedIssFollow.remove(at: index ?? 0)
                    }
                    self.viewModelForOrganniser.arrSuggestedOrganizers[indexPath.row].changeIsFollow(isFollow: false)
                } else {
                    if message == "Successfully followed" {
                        sender.setTitle("Following", for: .normal)
                    }
                    self.viewModelForOrganniser.arrSuggestedIssFollow.append(id)
                    self.viewModelForOrganniser.arrSuggestedOrganizers[indexPath.row].changeIsFollow(isFollow: true)
                }
            })
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let obj = self.viewModel.arrMail[indexPath.row]
     //   self.viewModel.strSelectedEmail = obj.email ?? ""
        self.tblSuggestedOragArt.reloadData()
  }
}

// MARK: - UICollectionViewDataSource,UICollectionViewDelegate
extension OrganizersArtistsListVC: UICollectionViewDataSource ,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return viewModelForOrganniser.arrOrganizersListSideMenu?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedOrganizerCell", for: indexPath) as! SuggestedOrganizerCell
        cell.isFromOrganizationSection = true
        if let data = viewModelForOrganniser.arrOrganizersListSideMenu?[indexPath.row]{
            cell.setData(organizerDetail: data)
        }
        cell.followButtonDidTap = { sender in
            var organizerId = self.viewModelForOrganniser.arrOrganizersListSideMenu?[indexPath.row].userID ?? 0
            self.suggestedFollowButtonAction(organizerId: organizerId, isSuccess: { message in
                print("message from api:-", message)
                let record = self.viewModelForOrganniser.arrOrganizersListSideMenu?[indexPath.row]
                let id = record?.userID ?? 0
                if record?.isFollow ?? false {
                    if message == "Successfully unfollowed" {
                        sender.setTitle("Follow", for: .normal)
                    }
                    if self.viewModelForOrganniser.arrIssFollow.contains(id) {
                        let index = self.viewModelForOrganniser.arrIssFollow.firstIndex(of: id)
                        self.viewModelForOrganniser.arrIssFollow.remove(at: index ?? 0)
                    }
                    self.viewModelForOrganniser.arrOrganizersListSideMenu?[indexPath.row].changeIsFollow(isFollow: false)
                } else {
                    if message == "Successfully followed" {
                        sender.setTitle("Following", for: .normal)
                    }
                    self.viewModelForOrganniser.arrIssFollow.append(id)
                    self.viewModelForOrganniser.arrOrganizersListSideMenu?[indexPath.row].changeIsFollow(isFollow: true)
                }
            })
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.bounds.width/1.3, height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let data = viewModelForOrganniser.arrOrganizersListSideMenu?[indexPath.row]
        let view = createView(storyboard: .profile, storyboardID: .ManageEventProfileVC) as! ManageEventProfileVC
        view.isComingFromOranizer = true
        if let name = data?.name {
            view.name = name
        }
        let url = (data?.profileImage ?? "")
        view.imageUrl = url
        self.navigationController?.pushViewController(view, animated: true)
    }

}

// MARK: - NavigationBarViewDelegate
extension OrganizersArtistsListVC: NavigationBarViewDelegate {
    func navigationBackAction() {
//        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
//        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
//        present(menu, animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
  }
}
