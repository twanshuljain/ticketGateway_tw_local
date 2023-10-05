//
//  ManageMyEventCateoryList.swift
//  TicketGateway
//
//  Created by Apple  on 10/05/23.

import UIKit

class ManageMyEventCateoryList: UICollectionView {
    var selectedIndex = 0
    func configure() {
        self.register(UINib(nibName: "ManageMyEventCategoryCell", bundle: nil), forCellWithReuseIdentifier: "ManageMyEventCategoryCell")
        self.delegate = self
        self.dataSource = self
    }
}
extension ManageMyEventCateoryList: UICollectionViewDataSource ,UICollectionViewDelegate {
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
        if indexPath.row == selectedIndex {
            cell.vwbg.backgroundColor = .white
        } else {
            cell.vwbg.backgroundColor = .clear
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.reloadData()
    }
}
