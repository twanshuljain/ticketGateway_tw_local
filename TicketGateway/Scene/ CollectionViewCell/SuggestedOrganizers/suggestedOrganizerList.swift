//
//  suggestedOrganizerList.swift
//  TicketGateway
//
//  Created by Apple  on 28/04/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name
// swiftlint: disable vertical_whitespace
import UIKit

private let reuseIdentifier = "Cell"

class suggestedOrganizerList: UICollectionView {
    var arrOrganizersList:[Organizers]?
    
    func configure() {
        self.register(UINib(nibName: "suggestedOrganizerCell", bundle: nil), forCellWithReuseIdentifier: "suggestedOrganizerCell")
        self.delegate = self
        self.dataSource = self
    }

}
extension suggestedOrganizerList : UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
         return arrOrganizersList?.count ?? 0
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "suggestedOrganizerCell", for: indexPath) as! suggestedOrganizerCell
         if let data = self.arrOrganizersList?[indexPath.row]{
             cell.setData(organizerDetail: data)
         }
         return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.bounds.width/1.7, height: collectionView.bounds.height - 30.0)
    }

}
