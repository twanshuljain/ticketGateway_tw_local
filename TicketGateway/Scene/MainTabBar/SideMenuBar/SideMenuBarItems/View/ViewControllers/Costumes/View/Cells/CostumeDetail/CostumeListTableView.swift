//
//  CostumeTableView.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 03/05/23.
//

import UIKit

class CostumeListTableView: UITableView {

    var costumeTbleItem = ["costume_ip", "costume_ip", "costume_ip", "costume_ip"]
    var tableDidSelectAtIndex:((String) ->())?
    var isForDetailVC: String?

    func configure() {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CostumeTableViewCell", for: indexPath) as! CostumeTableViewCell
        let data = costumeTbleItem[indexPath.row]
        cell.imgCostumeImage.image = UIImage(named: data)
        cell.lblTitle.text = "Jouvert Republic 2023"
        cell.lblFrontLine.text = "Frontline | Trini Revellers "
        cell.lblDate.text = "Jan 19 to Feb 19, 2023"
        cell.lblTime.text = "5:00 PM - 11:00 PM "
        cell.lblPrice.text = "$250 - $500"
        cell.lblFlexiblePayment.text = "Flexible Payment available "
        if isForDetailVC == "DetailVC" {
            cell.btnRegister.isHidden = true
            cell.vwLikeShare.isHidden = false
            cell.lblDescription.isHidden = false
            cell.vwGradientView.startColor =  .white
            cell.vwGradientView.endColor = .white
            
        }
        
        return cell
       
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = costumeTbleItem[indexPath.row]
        self.tableDidSelectAtIndex?(data)
    }
    
   
    
}
