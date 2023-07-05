//
//  PeopleCollectionList.swift
//  TicketGateway
//
//  Created by Apple  on 10/05/23.
//

import UIKit

class PeopleCollectionList: UICollectionView {
    
    
    func configure() {
        self.register(UINib(nibName: "PeopleCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PeopleCollectionCell")
        self.delegate = self
        self.dataSource = self
    }

}
extension PeopleCollectionList : UICollectionViewDataSource ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
         if 5 > 3 {
            return 4
         }else{
            return 5
         }
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleCollectionCell", for: indexPath) as! PeopleCollectionCell
        // Configure the cell
         if indexPath.row == 0
         {
             cell.imgPeople.image = UIImage(named: "photo_ip")
         } else if indexPath.row == 1{
             
             cell.imgPeople.image = UIImage(named: "profile")
         } else if indexPath.row == 2{
             
             cell.imgPeople.backgroundColor = .black
             cell.imgPeople.image = UIImage(named: "user")
         }else if indexPath.row == 3{
    
             cell.imgPeople.image = UIImage(named: "photo_ip")
         }
         
         if indexPath.row == 3{
             let totalCount = 5 - 3
             cell.vwContainer.backgroundColor = UIColor.white
             cell.lblCount.text = "+" + String(totalCount)
             cell.lblCount.isHidden = false
             cell.imgPeople.isHidden = true
             cell.vwContainer.layer.masksToBounds = true
             cell.vwContainer.layer.borderWidth = 0.5
             cell.vwContainer.layer.borderColor = UIColor.gray.cgColor
             
         } else {
             cell.vwContainer.backgroundColor = UIColor.clear
             cell.vwContainer.layer.borderColor = UIColor.clear.cgColor
             cell.lblCount.isHidden = true
             cell.imgPeople.isHidden = false
         }
          
         return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
       // let width = (CGFloat(UIScreen.main.bounds.width)-45)/2
        return CGSize(width: 40, height  : 40)
        }
//     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//            return CGSizeMake(10, 10);
//        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
             return -10;
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10;
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



