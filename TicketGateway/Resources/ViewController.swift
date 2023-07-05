//
//  ViewController.swift
//  TicketGateway
//
//  Created by Apple  on 10/04/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for family: String in UIFont.familyNames {
           print("\(family)")
           for names: String in UIFont.fontNames(forFamilyName: family) {
              print("== \(names)")
           }
        }
    }


}

