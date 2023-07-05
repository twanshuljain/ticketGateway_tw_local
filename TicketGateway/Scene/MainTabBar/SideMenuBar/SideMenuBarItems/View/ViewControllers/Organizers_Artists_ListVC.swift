//
//  Organizers_Artists_ListVC.swift
//  TicketGateway
//
//  Created by Apple  on 04/05/23.
//

import UIKit
import SideMenu

class Organizers_Artists_ListVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var lblSuggested: UILabel!
    @IBOutlet weak var btnSeeAllForSuggested: CustomButtonNormal!
    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var btnSeeAll: CustomButtonNormal!
    @IBOutlet weak var collVwTrending_Artists: suggestedOrganizerList!
     @IBOutlet weak var tblSuggestedOrag_Art: UITableView!
    @IBOutlet weak var navigationView: NavigationBarView!

    // MARK: - Variable
    let viewModel = LoginNmberWithEmailViewModel()
    let nameFormatter = PersonNameComponentsFormatter()
    var isFrom = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
}

// MARK: - Functions
extension Organizers_Artists_ListVC {
    private func setup() {
        [self.btnSeeAll,btnSeeAllForSuggested].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.setUi()
        self.tblSuggestedOrag_Art.dataSource = self
        self.tblSuggestedOrag_Art.delegate = self
        self.tblSuggestedOrag_Art.reloadData()
        self.collVwTrending_Artists.configure()
        self.navigationView.delegateBarAction = self
        if self.isFrom == "Organizers" {
            self.navigationView.lblTitle.text = "Organizers"
            self.lblTittle.text = "Trending organizers"
            self.lblSuggested.text = "Suggested for you"
        } else {
            self.navigationView.lblTitle.text = "Artists"
            self.lblTittle.text = "Trending Artists"
            self.lblSuggested.text = "Suggested for you"
        }
        self.navigationView.imgBack.image = UIImage(named: "Menu")
        self.navigationView.btnBack.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.vwBorder.isHidden = false
    }
    func setUi(){
        self.lblTittle.font = UIFont.setFont(fontType: .bold, fontSize: .eighteen)
        self.lblTittle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblSuggested.font = UIFont.setFont(fontType: .bold, fontSize: .eighteen)
        self.lblSuggested.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.btnSeeAll.setTitles(text: "See all", font: .systemFont(ofSize: 20), tintColour: .blue, textColour: UIColor.setColor(colorType: .TGBlue))
        self.btnSeeAllForSuggested.setTitles(text: "See all", font: .systemFont(ofSize: 20), tintColour: .blue, textColour: UIColor.setColor(colorType: .TGBlue))
      
    }
}

// MARK: - Actions
extension Organizers_Artists_ListVC {
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
        if Reachability.isConnectedToNetwork(){
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
        if Reachability.isConnectedToNetwork(){
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
}


extension Organizers_Artists_ListVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
      //  self.viewModel.arrMail.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "Organizers_Artists_ListCell", for: indexPath) as? Organizers_Artists_ListCell)!
//        let obj = self.viewModel.arrMail[indexPath.row]
//        cell.lblName.text = obj.name
//        cell.lblFollowers.text = obj.email
//
//      //  cell.lblShortName.text = funcpersonNameComponents(strValue: obj.name ?? "")
//
//        if self.viewModel.strSelectedEmail == obj.email {
//            cell.imageView?.image =  UIImage(named: "active")
//        } else {
//            cell.imageView?.image =  UIImage(named: "unActive")
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let obj = self.viewModel.arrMail[indexPath.row]
     //   self.viewModel.strSelectedEmail = obj.email ?? ""
        self.tblSuggestedOrag_Art.reloadData()
  }

   
    

}
extension Organizers_Artists_ListVC : UICollectionViewDataSource ,UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "suggestedOrganizerCell", for: indexPath)
        // Configure the cell
        return cell
    }
}

extension Organizers_Artists_ListVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
  }
}
