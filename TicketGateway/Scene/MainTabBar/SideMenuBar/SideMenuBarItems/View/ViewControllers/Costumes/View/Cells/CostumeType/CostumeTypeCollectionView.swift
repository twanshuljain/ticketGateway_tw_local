//
//  CostumeTypeCollectionView.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 03/05/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disbale identifier_name
// swiftlint: disbalefunction_parameter_count

import UIKit

class CostumeTypeCollectionView: UICollectionView {

    var costumeType = ["Detail", "BackLine", "MidLine", "FrontLine", "UltraFrontLine"]

    var collectionDidSelectAtIndex:((Int) ->())?
    var selectedIndex = Int ()

    func configure() {
        self.delegate = self
        self.dataSource = self
        self.register(UINib(nibName: "CostumeTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CostumeTypeCollectionViewCell")
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CostumeTypeCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return costumeType.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CostumeTypeCollectionViewCell", for: indexPath) as! CostumeTypeCollectionViewCell
        let data = costumeType[indexPath.row]
        cell.lblCostumeType.text = data
        cell.bgView.backgroundColor = selectedIndex == indexPath.row ? UIColor.setColor(colorType: .lblTextPara) : UIColor.setColor(colorType: .BorderLineColour)
        cell.lblCostumeType.textColor = selectedIndex == indexPath.row ? UIColor.white : UIColor.darkGray
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionDidSelectAtIndex?(indexPath.row)
        selectedIndex = indexPath.row
        self.reloadData()

    }

}
