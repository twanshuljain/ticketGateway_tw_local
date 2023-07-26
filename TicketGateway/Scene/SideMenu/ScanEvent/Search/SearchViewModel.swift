//
//  SearchViewModel.swift
//  TicketGateway
//
//  Created by Apple on 30/06/23.
// swiftlint: disable line_length

import Foundation

struct SearchDummyData {
    let name: String?
    let orderID: String?
    let cardNo: String?
    let nameOnCard: String?
}
class SearchViewModel: NSObject {
    var orderInfo: [SearchDummyData] = []
    var searchData: [SearchDummyData] = []
    var isFromSearchTxtField: Bool = false
    var numberOfRows: Int {
        return isFromSearchTxtField ? searchData.count : orderInfo.count
    }
    func getItem(indexPath: Int) -> SearchDummyData {
        return isFromSearchTxtField ? searchData[indexPath] : orderInfo[indexPath]
    }
    override init() {
        super.init()
        self.setDummyData()
    }
    func setDummyData() {
        for _ in 0...4 {
            let data = SearchDummyData(name: "Mangesh Yahoo", orderID: "213456755", cardNo: "XXXXXXXX2145", nameOnCard: "Mnages Kamdim")
            orderInfo.append(data)
        }
    }
    // MARK: - SEARCH FUNC
    open func searchFilter(text: String, searchText: String) -> Bool {
        return text.range(of: searchText, options: .caseInsensitive) != nil
    }
    func filterData(searchText: String, completionHandler: @escaping() -> Void) {
        searchData.removeAll()
        var searchedItems = [SearchDummyData]()
        let filter = orderInfo.filter { info in
            return searchFilter(text: info.name ?? "", searchText: searchText) || searchFilter(text: info.cardNo ?? "", searchText: searchText)
        }
        searchedItems.append(contentsOf: filter)
        searchData = searchedItems
        //                isFromSearchTxtField = !searchText.isEmpty
        completionHandler()
    }
}
