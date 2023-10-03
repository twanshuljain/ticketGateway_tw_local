//
//  SuggestedOrganizerList.swift
//  TicketGateway
//
//  Created by Apple  on 28/04/23.

import UIKit

private let reuseIdentifier = "Cell"
protocol NavigateToProfile {
    func tapActionOrganiser(index: Int, data: Organizers)
}
protocol SuggestedOrganizerListProtocol: class {
    func followUnfollowAction(tag: Int)
}
class SuggestedOrganizerList: UICollectionView {
    var arrOrganizersList: [Organizers]?
    var delegateOrgansierToProfile: NavigateToProfile?
    weak var followUnfollowDelegate:SuggestedOrganizerListProtocol?
    func configure() {
        self.register(UINib(nibName: "SuggestedOrganizerCell", bundle: nil), forCellWithReuseIdentifier: "SuggestedOrganizerCell")
        self.delegate = self
        self.dataSource = self
    }
}
extension SuggestedOrganizerList: UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
         return arrOrganizersList?.count ?? 0
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedOrganizerCell", for: indexPath) as! SuggestedOrganizerCell
         if let data = self.arrOrganizersList?[indexPath.row] {
             cell.delegate = self
             cell.btnFollerwers.tag = indexPath.row
             cell.setData(organizerDetail: data)
         }
         return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.bounds.width/1.7, height: collectionView.bounds.height - 30.0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegateOrgansierToProfile?.tapActionOrganiser(index: indexPath.row, data: (arrOrganizersList?[indexPath.row])! )
    }
}

extension SuggestedOrganizerList: SuggestedOrganizerCellProtocol{
    func followUnfollowAction(tag: Int) {
        self.followUnfollowDelegate?.followUnfollowAction(tag: tag)
    }
}
