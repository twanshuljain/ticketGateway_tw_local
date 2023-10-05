//
//  AddCardViewModel.swift
//  TicketGateway
//
//  Created by Apple on 22/06/23.
//

import UIKit

final class AddCardViewModel {
// MARK: - Variables
    var MONTH = 0
    var YEAR = 1
    var selectedMonthName = ""
    var selectedyearName = ""
    var months = [String]()
    var years = [String]()
    var minYear: Int = 0
    var maxYear: Int = 0
    var rowHeight: Int = 0
    var strMonth = ""
    var strYear = ""
    let colorTop =  UIColor(red: 146.0/255.0, green: 254.0/255.0, blue: 157.0/255.0, alpha: 0.2).cgColor
    let colorBottom = UIColor(red: 0/255.0, green: 201.0/255.0, blue: 255.0/255.0, alpha: 0.2).cgColor
    let gradientLayer = CAGradientLayer()
}

// MARK: - Functions
extension AddCardViewModel {
    func loadDefaultsParameters() {
        let components: DateComponents? = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        let year: Int? = components?.year
        self.minYear = year ?? 0
        self.maxYear = year! + 30
        self.rowHeight = 44
        self.months = nameOfMonths()
        self.years = nameOfYears()
        let str = "\(Int(year!))"
        if (str.count ) > 2 {
            let _: String = ((str as? NSString)?.substring(from: (str.count ) - 2))!
            selectedyearName = "\(str)"
        }
        selectedMonthName = "01"
    }
    func nameOfMonths() -> [String] {
        return ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    }
    func nameOfYears() -> [String] {
        var years = [String]()
        for year in (minYear)...(maxYear) {
            let yearStr = "\(Int(year))"
            years.append(yearStr)
        }
        return years
    }
}
