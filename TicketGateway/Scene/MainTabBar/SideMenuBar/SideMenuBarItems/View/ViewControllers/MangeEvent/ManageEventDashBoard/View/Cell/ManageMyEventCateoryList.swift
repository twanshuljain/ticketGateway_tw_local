//
//  ManageMyEventCateoryList.swift
//  TicketGateway
//
//  Created by Apple  on 10/05/23.
//

import UIKit

class ManageMyEventCateoryList: UICollectionView {

var SelectedIndex = 0
func configure() {
    self.register(UINib(nibName: "ManageMyEventCategoryCell", bundle: nil), forCellWithReuseIdentifier: "ManageMyEventCategoryCell")
    self.delegate = self
    self.dataSource = self
}
    

}
extension ManageMyEventCateoryList : UICollectionViewDataSource ,UICollectionViewDelegate {

 func numberOfSections(in collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
}


 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return 4
}

 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ManageMyEventCategoryCell", for: indexPath) as! ManageMyEventCategoryCell
     if indexPath.row == SelectedIndex {
         cell.vwbg.backgroundColor = .white
     } else {
         cell.vwbg.backgroundColor = .clear
     }
     return cell
}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.SelectedIndex = indexPath.row
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



