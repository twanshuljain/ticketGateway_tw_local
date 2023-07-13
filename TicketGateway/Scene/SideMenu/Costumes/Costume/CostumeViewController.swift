//
//  CostumeViewController.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 03/05/23.
//

import UIKit
import AdvancedPageControl
import SideMenu
import iOSDropDown

class CostumeViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var btnFilter: CustomButtonNormal!
    @IBOutlet weak var btnSortBy: CustomButtonNormal!
    @IBOutlet weak var carnivalCollectionView: UICollectionView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var imagePageController: AdvancedPageControlView!
    @IBOutlet weak var costumeTableView: CostumeListTableView!
    
    @IBOutlet weak var vwSearchBar: CustomSearchBar!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var txtFilter: DropDown!
    @IBOutlet weak var lblImageCollectionHeader:UILabel!
    @IBOutlet weak var txtSort: DropDown!
    @IBOutlet weak var vwNavigationBar: NavigationBarView!
    
    //MARK: - Variables
    let carnivalCollectionData = [["img": "carnival_ip", "title": "All"], ["img": "carnival_ip", "title": "Revolution Carnival"], ["img": "carnival_ip", "title": "Trini Revellars Carnival"], ["img": "carnival_ip", "title": "Fantasy Carnival"]]
    let imgCollectionData = ["ic-CostumeStyle", "ic-CostumeStyle","ic-CostumeStyle" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setFont()
        self.setCollectionView()
        self.costumeTableView.configure(vc: self)
        self.setButtonImage()
        self.toSetPageControll()
        self.setNavigaionBar()
        self.costumeTableView.tableDidSelectAtIndex = didSelectedAtIndex
        self.vwSearchBar.delegate = self
        
        self.setDropDownTxt()
        costumeTableView.reloadData()
        self.costumeTableView.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.tblViewHeight.constant = self.costumeTableView.contentSize.height
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.tblViewHeight.constant = costumeTableView.contentSize.height
    }
}

//MARK: - Functions
extension CostumeViewController{
    func setNavigaionBar() {
        vwNavigationBar.lblTitle.text = COSTUME
        vwNavigationBar.delegateBarAction = self
        vwNavigationBar.btnBack.isHidden = false
        vwNavigationBar.vwBorder.isHidden = false
    }
    
    func setFont() {
        self.lblImageCollectionHeader.text = TRENDING_BAND_LEADERS
        self.lblImageCollectionHeader.font =  UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblImageCollectionHeader.textColor = UIColor.setColor(colorType: .TGBlack)
    }
    
    func setDropDownTxt() {
        let textlds = [txtSort,txtFilter]
        for textld in textlds {
            textld?.optionArray = ["S", "L", "M","XL","XXl"]
            textld?.optionIds = [1,23,54,22]
            textld?.didSelect{(selectedText , index ,id) in
                textld?.text = "\(selectedText)\(index)"
            }
        }
    }
    
    
    
    func setButtonImage() {
        btnFilter.addRightIcon(image: UIImage(named: CHEVRON_DOWN)) //ic-filter
        btnFilter.addLeftIcon(image: UIImage(named: FILTER)) //ic-chevron
        btnFilter.titleLabel?.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        btnFilter.titleLabel?.textColor = UIColor.setColor(colorType: .TGGrey)
        btnSortBy.titleLabel?.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        btnSortBy.titleLabel?.textColor = UIColor.setColor(colorType: .TGGrey)
        btnSortBy.addRightIcon(image: UIImage(named:  CHEVRON_DOWN))
        btnSortBy.addLeftIcon(image: UIImage(named: SORT_ICON))
        
        
    }
    
    func setCollectionView() {
        carnivalCollectionView.delegate = self
        carnivalCollectionView.dataSource = self
        carnivalCollectionView.backgroundColor = UIColor.setColor(colorType: .BgPurpleColor)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        self.imageCollectionView.register(UINib(nibName: "CostumeImageCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CostumeImageCollectionViewCell")
        //
    }
    private func didSelectedAtIndex(_ ClickAction: Int) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CostumeDetailViewController") as! CostumeDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Actions
extension CostumeViewController {
    
    func setUI() {
        self.vwSearchBar.customSearchBarEnum = .costume
        self.vwSearchBar.setUpView()
        [self.btnFilter, self.btnSortBy].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
    }
   
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnFilter:
            self.btnFilterAction()
        case btnSortBy:
            
            self.btnSortByAction()
        default:
            break
        }
        
    }
    
    func btnFilterAction() {
        txtFilter.showList()
    }
    
    func btnSortByAction() {
        txtSort.showList()
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

//MARK: - CostumeTableViewCellProtocol
extension CostumeViewController:CostumeTableViewCellProtocol{
    func didTapOnFrontLine(sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BandLeaderProfileViewController") as! BandLeaderProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSelect(index: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CostumeDetailViewController") as! CostumeDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - CustomSearchMethodsDelegate
extension CostumeViewController: CustomSearchMethodsDelegate {
    
    func filterButtonPressed(_ sender: UIButton) {
        let menu = UIStoryboard.init(name: "Costume", bundle: Bundle.main).instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        self.present(menu, animated: true, completion: nil)
    }
    
    func leftButtonPressed(_ sender: UIButton) {
        let menu = UIStoryboard.init(name: "SideMenu", bundle: Bundle.main).instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    func RightButtonPressed(_ sender: UIButton) {
        print("hello")
    }
}

//MARK: - NavigationBarViewDelegate
extension CostumeViewController: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


