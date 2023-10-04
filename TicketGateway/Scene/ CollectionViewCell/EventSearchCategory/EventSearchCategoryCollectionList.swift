//
//  EventSearchCategoryCollectionList.swift
//  TicketGateway
//
//  Created by Apple  on 22/05/23.
//

import UIKit



class EventSearchCategoryCollectionList: UICollectionView {
   
// MARK: - Variables
    var selectedIndex = -1
    var isFromCategory = false
    var collVwDidSelectAtIndex: ((GetEventCategoryModel) -> Void)?
    var arrData = [GetEventCategoryModel]()
   
    func configure() {
        self.register(UINib(nibName: "EventSearchCategoryCell", bundle: nil), forCellWithReuseIdentifier: "EventSearchCategoryCell")
        self.delegate = self
        self.dataSource = self
    }

}

// MARK: - UICollectionViewDataSource ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
extension EventSearchCategoryCollectionList: UICollectionViewDataSource ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
         return 1
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
         return arrData.count
        
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventSearchCategoryCell", for: indexPath) as? EventSearchCategoryCell
         cell?.lblTittle.text = arrData[indexPath.row].name
         if selectedIndex == indexPath.row{
             cell?.vwBg.backgroundColor = UIColor.setColor(colorType: .lightBlack)
             cell?.lblTittle.textColor = UIColor.setColor(colorType: .white)
             cell?.imgArrow.image = UIImage(named: ARROW_DOWN_WHITE_ICON)
        } else {
             cell?.vwBg.backgroundColor = .clear
             cell?.imgArrow.image = UIImage(named: ARROW_DOWN_BLACK_ICON)

             if  isFromCategory == true {
                 cell?.lblTittle.textColor = UIColor.setColor(colorType: .lightBlack)
             } else {
                 cell?.lblTittle.textColor = UIColor.setColor(colorType: .tgGrey)
             }
         }
         if isFromCategory == true {
             cell?.vwBg.layer.borderColor = UIColor.setColor(colorType: .lightBlack).cgColor
             cell?.vwBg.layer.borderWidth = 1
             cell?.vwBg.layer.cornerRadius = 10
             cell?.imgArrow.isHidden = false
         } else {
             cell?.vwBg.layer.borderColor = UIColor.setColor(colorType: .tgGrey).cgColor
             cell?.vwBg.layer.borderWidth = 1
             cell?.vwBg.layer.cornerRadius = 10
             cell?.imgArrow.isHidden = true
         }
        
         return cell!
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventSearchCategoryCell", for: indexPath) as? EventSearchCategoryCell
        self.selectedIndex = indexPath.row
        let obj = arrData[indexPath.row]
        if isFromCategory == true {
            self.collVwDidSelectAtIndex!(obj)
        } else {

        }
        self.reloadData()
    }
   
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
