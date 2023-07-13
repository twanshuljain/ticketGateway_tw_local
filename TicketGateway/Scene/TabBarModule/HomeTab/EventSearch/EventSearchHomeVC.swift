//
//  EventSearchVC.swift
//  TicketGateway
//
//  Created by Apple  on 22/05/23.
//

import UIKit
import iOSDropDown
import SideMenu
import SVProgressHUD

class EventSearchHomeVC: UIViewController, UITextFieldDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var collVwEventSubCategory: EventSearchCategoryCollectionList!
    @IBOutlet weak var btnReset: CustomButtonNormal!
    @IBOutlet weak var btnShowResult: CustomButtonGradiant!
    @IBOutlet weak var vwBlack: UIView!
    @IBOutlet weak var tblEvents: EventsOrganizesListTableView!
    @IBOutlet weak var vwSearchBar: CustomSearchBar!
    @IBOutlet weak var lblTotalEvents: UILabel!
    @IBOutlet weak var btnFIlter: UIButton!
    @IBOutlet weak var collVwEvent: EventSearchCategoryCollectionList!
    @IBOutlet weak var btnSortByRelevence: UIButton!
    @IBOutlet weak var txtSortByRelevance: DropDown!
    
    //MARK: - Variables
    private let viewModel = GetEventCategoryViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwBlack.isHidden =  true
        self.vwSearchBar.delegate = self
        self.vwSearchBar.vwLocation.isHidden = true
        self.collVwEvent.configure()
        self.tblEvents.configure(isComingFrom: IsComingFromForEventsOrganizesListTableView.EventSearch)
        self.collVwEvent.isFromCategory = true
        self.collVwEventSubCategory.configure()
        self.collVwEventSubCategory.isFromCategory = false
        [self.btnReset, self.btnShowResult,self.btnSortByRelevence,self.btnFIlter,].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.tblEvents.tableDidSelectAtIndex = { _ in
            
        }
        self.collVwEvent.collVwDidSelectAtIndex = { _ in
            self.vwBlack.isHidden =  false
            self.tblEvents.reloadData()
           
        }
        self.collVwEventSubCategory.collectionViewLayout = createLeftAlignedLayout()
        self.btnShowResult.setTitles(text: SHOW_RESULT, font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
        self.btnReset.setTitles(text: RESET, font: .systemFont(ofSize: 20), tintColour: .blue, textColour: UIColor.setColor(colorType: .TGBlue))
        self.viewModel.funcCallApi(vc: self)
        self.funcSetDropDown()
    }
}

//MARK: - Functions
extension EventSearchHomeVC {
    func funcSetDropDown(){
        txtSortByRelevance.optionArray = ["Jan", "Feb", "Mar","April"]
        txtSortByRelevance.delegate = self
        txtSortByRelevance.optionIds = [1,23,54,22]
        txtSortByRelevance.didSelect{(selectedText , index ,id) in
            self.txtSortByRelevance.text = "\(selectedText)\(index)"
        }
    }
}

//MARK: - Actions
extension EventSearchHomeVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnReset:
            self.btnResetAction()
        case btnFIlter :
            self.btnFilterAction()
        case btnShowResult :
            self.btnShowResultAction()
        case btnSortByRelevence :
            self.btnSortByRelevenceAction()
        default:
            break
        }
    }
    
    func btnResetAction() {
        self.vwBlack.isHidden =  true
    }
    
    func btnFilterAction() {
        self.vwBlack.isHidden =  false
        
    }
    
    func btnSortByRelevenceAction() {
        self.txtSortByRelevance.showList()
    }
    
    func btnShowResultAction() {
        self.vwBlack.isHidden =  true
    }
    
}

//MARK: - CustomSearchMethodsDelegate
extension EventSearchHomeVC: CustomSearchMethodsDelegate {
    func leftButtonPressed(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    
    func RightButtonPressed(_ sender: UIButton) {
        print("hello")
    }
    
    private func createLeftAlignedLayout() -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(          // this is your cell
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(40),         // variable width
                heightDimension: .absolute(50)          // fixed height
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),  // 100% width as inset by its Section
                heightDimension: .estimated(40)         // variable height; allows for multiple rows of items
            ),
            subitems: [item]
        )
        group.contentInsets = .init(top: 5, leading: 0, bottom: 5, trailing: 5)
        group.interItemSpacing = .fixed(10)         // horizontal spacing between cells
        
        return UICollectionViewCompositionalLayout(section: .init(group: group))
    }
    
}
