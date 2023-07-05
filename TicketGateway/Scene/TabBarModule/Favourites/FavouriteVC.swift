//
//  FavouriteVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 29/05/23.
//

import UIKit
import SideMenu

class FavouriteVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var favouriteTableView: FavouriteListTableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var findEventCollectionView: UICollectionView!
    @IBOutlet weak var vwNoLikedEventView: UIView!
    @IBOutlet weak var lblNoLikedEvent: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblFindEventNearYou: UILabel!
    @IBOutlet weak var vwVenueView: UIView!
    @IBOutlet weak var lblVenuNoLikeEvent: UILabel!
    @IBOutlet weak var lblVenuDescription: UILabel!
    @IBOutlet weak var lblVenuSuggestionForYou: UILabel!
    
    //MARK: - Variables
    let collectionData = ["Today", "Tomorrow", "This Week", "This Weekend"]
    var isForVenue: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.favouriteTableView.configure()
        self.setCollectionView()
        self.setFont()
    }
}

//MARK: - Functions
extension FavouriteVC{
    func setFont(){
        
        let labels = [lblNoLikedEvent, lblFindEventNearYou, lblVenuNoLikeEvent]
        for label in labels {
            label?.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
            label?.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
            
        }
        
        let lbls = [lblDescription, lblVenuDescription]
        for lbl in lbls {
            lbl?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            lbl?.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
        
        lblVenuSuggestionForYou.font = UIFont.setFont(fontType: .bold, fontSize: .eighteen)
        lblVenuSuggestionForYou.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
    }
    
    func setNavigationBar() {
        self.vwNavigationView.lblTitle.text = "Favourites"
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.vwNavigationView.imgBack.image = UIImage(named: "Menu")
        self.vwNavigationView.btnBack.isHidden =  false
        self.vwNavigationView.delegateBarAction = self
    }
    
    func setCollectionView() {
        findEventCollectionView.delegate = self
        findEventCollectionView.dataSource = self
    }
}

//MARK: - Actions
extension FavouriteVC{
      @IBAction func actionSegmentController(_ sender: UISegmentedControl) {
          switch segmentControl.selectedSegmentIndex {
          case 0:
              isForVenue == false
             // self.vwNoLikedEventView.isHidden = true
             self.vwVenueView.isHidden = true
              self.favouriteTableView.reloadData()
          case 1:
           isForVenue == true
            //  self.vwNoLikedEventView.isHidden = false
                  self.vwVenueView.isHidden = false
                  self.favouriteTableView.reloadData()
              self.favouriteTableView.isFromVenue = "Venue"
          
              
          default:
              break
          }
      }
}

//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension FavouriteVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FindEventCollectionViewCell", for: indexPath) as! FindEventCollectionViewCell
        let data = collectionData[indexPath.row]
        cell.lblTitle.text = data
       
        return cell
    }
}

//MARK: - NavigationBarViewDelegate
extension FavouriteVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
  }
}
