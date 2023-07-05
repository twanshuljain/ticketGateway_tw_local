//
//  CostumeViewController.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 03/05/23.
//

import UIKit
import AdvancedPageControl
import SideMenu

class CostumeViewController: UIViewController, UITextFieldDelegate {
    
    
    let carnivalCollectionData = [["img": "carnival_ip", "title": "All"], ["img": "carnival_ip", "title": "Revolution Carnival"], ["img": "carnival_ip", "title": "Trini Revellars Carnival"], ["img": "carnival_ip", "title": "Fantasy Carnival"]]
    
    let imgCollectionData = ["ic-CostumeStyle", "ic-CostumeStyle","ic-CostumeStyle" ]
    
    @IBOutlet weak var btnFilter: CustomButtonNormal!
    @IBOutlet weak var btnSortBy: CustomButtonNormal!
    @IBOutlet weak var carnivalCollectionView: UICollectionView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var imagePageController: AdvancedPageControlView!
    @IBOutlet weak var costumeTableView: CostumeListTableView!
    
    @IBOutlet weak var vwSearchBar: CustomSearchBar!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
  
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        costumeTableView.configure()
        setButtonImage()
        toSetPageControll()
        costumeTableView.tableDidSelectAtIndex = didSelectedAtIndex
        vwSearchBar.delegate = self
       
        
        
        
        
        
        [self.btnFilter, self.btnSortBy].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        
        
        
        
        //self.setDropDownTxt()
        costumeTableView.reloadData()
        self.costumeTableView.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
            self.tblViewHeight.constant = self.costumeTableView.contentSize.height

    }
   
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.tblViewHeight.constant = costumeTableView.contentSize.height
      }
    
    
//
//    func setDropDownTxt() {
//        let textlds = [txtSort,txtFilter]
//        for textld in textlds {
//            textld?.optionArray = ["S", "L", "M","XL","XXl"]
//            textld?.optionIds = [1,23,54,22]
//            textld?.didSelect{(selectedText , index ,id) in
//            textld?.text = "Selected String: \(selectedText) \n index: \(index)"
//               }
//        }
//}

    
   
    func setButtonImage() {
              btnFilter.addRightIcon(image: UIImage(named: "chevron-down_ip")) //ic-filter
                btnFilter.addLeftIcon(image: UIImage(named: "ic-Filter")) //ic-chevron
                btnFilter.titleLabel?.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
                btnFilter.titleLabel?.textColor = UIColor.setColor(colorType: .TGGrey)
                btnSortBy.titleLabel?.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
                btnSortBy.titleLabel?.textColor = UIColor.setColor(colorType: .TGGrey)
                btnSortBy.addRightIcon(image: UIImage(named: "chevron-down_ip"))
                btnSortBy.addLeftIcon(image: UIImage(named: "sort_ip"))
       

    }
    
    func setCollectionView() {
        carnivalCollectionView.delegate = self
        carnivalCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        self.imageCollectionView.register(UINib(nibName: "CostumeImageCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CostumeImageCollectionViewCell")
        //
    }
    private func didSelectedAtIndex(_ ClickAction: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CostumeDetailViewController") as! CostumeDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout
extension CostumeViewController: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == self.carnivalCollectionView) {
            return  carnivalCollectionData.count
        } else  {
            return imgCollectionData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == carnivalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarnivalCollectionViewCell", for: indexPath) as! CarnivalCollectionViewCell
            let data = carnivalCollectionData[indexPath.row]
            cell.imgCarnivalImage.image = UIImage(named: data["img"] ?? "")
            cell.imgCarnivalImage.layer.cornerRadius = 50
            cell.lblCarnival.text = data["title"]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CostumeImageCollectionViewCell", for: indexPath) as! CostumeImageCollectionViewCell
            let data = imgCollectionData[indexPath.row]
            cell.imgImage.image = UIImage(named: data)
            return cell
        }
        
        
        
    }
   
}


//MARK: - PageController
extension CostumeViewController {
    func toSetPageControll() {
        imagePageController.drawer = ExtendedDotDrawer(numberOfPages: 3,
                                                       space: 16.0,
                                                       indicatorColor: UIColor.setColor(colorType: .TiitleColourDarkBlue),
                                                       dotsColor: UIColor.setColor(colorType: .PlaceHolder),
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

//MARK: -
extension CostumeViewController: CustomSearchMethodsDelegate {
  func leftButtonPressed(_ sender: UIButton) {
      let menu = UIStoryboard.init(name: "SideMenu", bundle: Bundle.main).instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
      present(menu, animated: true, completion: nil)
  }
  func RightButtonPressed(_ sender: UIButton) {
    print("hello")
  }
}

//MARK: -
extension CostumeViewController {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnFilter:
            break
            self.btnFilterAction()
        case btnSortBy:
            break
           // self.btnSortByAction()
        default:
            break
        }
       
    }
    
    func btnFilterAction() {
      //  txtFilter.showList()
    }
    
//    func btnSortByAction() {
//        txtSort.showList()
//    }
}

