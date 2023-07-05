//
//  CostumeTableView.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 03/05/23.
//

import UIKit


class CostumeListTableView: UITableView {

    var costumeTbleItem = ["costume_ip", "costume_ip", "costume_ip", "costume_ip"]
    var tableDidSelectAtIndex:((Int) ->())?
    var isForDetailVC: String?
    var tapOnFrontLine:((UIButton) ->())?
    var costumeObj:UIViewController?

    func configure(vc:UIViewController) {
        self.costumeObj = vc
        self.separatorColor = UIColor.clear
        self.delegate = self
        self.dataSource = self
        self.register(UINib(nibName: "CostumeTableViewCell", bundle: nil), forCellReuseIdentifier: "CostumeTableViewCell")
        self.reloadData()
    }
    
    
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension CostumeListTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return costumeTbleItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CostumeTableViewCell", for: indexPath) as? CostumeTableViewCell{
            cell.selectionStyle = .none
            let data = costumeTbleItem[indexPath.row]
            cell.setData(costumeObj: self.costumeObj, isForDetailVC: isForDetailVC)
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = costumeTbleItem[indexPath.row]
        self.tableDidSelectAtIndex?(indexPath.row)
    }
}

//MARK: - CostumeTableViewCellProtocol
extension CostumeListTableView:CostumeTableViewCellProtocol{
    func didSelect(index: IndexPath) {
        self.tableDidSelectAtIndex?(index.row)
    }
    
    
}
