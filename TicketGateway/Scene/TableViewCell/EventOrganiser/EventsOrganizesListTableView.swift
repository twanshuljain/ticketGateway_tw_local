//
//  EventsOrganizesListTableView.swift
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

import UIKit

enum IsComingFromForEventsOrganizesListTableView{
    case Home
    case EventDetail
    case Venue
    case EventSearch
}

protocol EventsOrganizesListTableViewProtocol{
    func tapActionOfViewMoreEvents(index:Int)
}

class EventsOrganizesListTableView: UITableView {
    var arrData = [GetEventModel]()
    var arrDataa = [GetEventModel]()
    
    var arrDataaWeekend = [GetEventModel]()
    var arrDataaVirtual = [GetEventModel]()
    var arrDataaPopular = [GetEventModel]()
    var arrDataaFree = [GetEventModel]()
    var arrDataaUpcoming = [GetEventModel]()
    var arrDataCategorySearch = [GetEventModel]()
    var arrSearchData = [GetEventModel]()
    
    
    var tableDidSelectAtIndex: ((IndexPath) -> Void)?
    var selectedDevice = ""
    var isFromDeselected = false
    var isComingFrom:IsComingFromForEventsOrganizesListTableView? = .Home
    var delegateViewMore:EventsOrganizesListTableViewProtocol?
    var isFromSearch: Bool = false
    
    func configure(isComingFrom:IsComingFromForEventsOrganizesListTableView?) {
        self.isComingFrom = isComingFrom
        self.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: - TableView Delegate
extension EventsOrganizesListTableView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.isComingFrom == .Home{
            return 5
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isComingFrom == .Home{
            switch section {
            case 0: return self.arrDataaWeekend.count
            case 1: return self.arrDataaVirtual.count
            case 2: return self.arrDataaPopular.count
            case 3: return self.arrDataaFree.count
            case 4: return self.arrDataaUpcoming.count
            default:
                return 0
            }
//            if self.arrDataa.count == 0{
//                return 5
//            }else{
//                return self.arrDataa.count
//            }
        }else if self.isComingFrom == .EventDetail{
            if self.arrData.count == 0{
                return 5
            }else{
                return self.arrData.count
            }
        } else if self.isComingFrom == .EventSearch {
            ///return arrDataCategorySearch.count
            return isFromSearch ? arrSearchData.count: arrDataCategorySearch.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as? EventTableViewCell {
            if self.isComingFrom == .Home{
                
                switch indexPath.section {
                case 0:
                    if arrDataaWeekend.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataaWeekend[indexPath.row]
                    }
                case 1:
                    if arrDataaVirtual.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataaVirtual[indexPath.row]
                    }
                case 2:
                    if arrDataaPopular.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataaPopular[indexPath.row]
                    }
                case 3:
                    if arrDataaFree.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataaFree[indexPath.row]
                    }
                case 4:
                    if arrDataaUpcoming.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataaUpcoming[indexPath.row]
                    }
                default:
                    if arrDataa.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataa[indexPath.row]
                    }
                }
            } else if self.isComingFrom == .EventSearch {
                if isFromSearch {
                    if arrSearchData.indices.contains(indexPath.row) {
                        cell.getEvent = self.arrSearchData[indexPath.row]
                    }
                } else {
                    if arrDataCategorySearch.indices.contains(indexPath.row) {
                        cell.getEvent = self.arrDataCategorySearch[indexPath.row]
                    }
                }
                
//                if arrDataCategorySearch.indices.contains(indexPath.row) {
//                    cell.getEvent = self.arrDataCategorySearch[indexPath.row]
//                }
            } else {
                if arrData.indices.contains(indexPath.row){
                    cell.getEvent = self.arrData[indexPath.row]
                }
            }
            
            
            cell.cellConfiguration()
            return cell
        } else {
            return UITableViewCell.init()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.isComingFrom == .Home{
            let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
            let label = UILabel()
            label.frame = CGRect.init(x: 16, y: 0, width: headerView.frame.width-16, height: headerView.frame.height)
            label.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
            label.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
            
            headerView.addSubview(label)
            switch section {
            case 0: label.text = This_Weekend
            case 1: label.text = Online_Events
            case 2: label.text = Popular_Events
            case 3: label.text = Free_Events
            case 4: label.text = Upcoming_Events
            default:
               label.text = Events_Near_Toronto
            }
            return headerView
        }
        return nil
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as? EventTableViewCell {
             switch indexPath.section {
             case 0: self.tableDidSelectAtIndex?(indexPath)
             case 1: self.tableDidSelectAtIndex?(indexPath)
             case 2: self.tableDidSelectAtIndex?(indexPath)
             case 3: self.tableDidSelectAtIndex?(indexPath)
             case 4: self.tableDidSelectAtIndex?(indexPath)
             default:
                 break;
             }
             self.reloadData()
         }
    }
    
    // set view for footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if self.isComingFrom == .Home{
            let footerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
            let button = CustomButtonNormal()
            button.frame = CGRect.init(x: 16, y: 0, width: footerView.frame.width, height: footerView.frame.height)
            footerView.addSubview(button)
            button.setTitles(text: VIEW_MORE_EVENT, font: .systemFont(ofSize: 20), tintColour: .blue, textColour: UIColor.setColor(colorType: .tgBlue))
            button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
            button.addRightIcon(image: UIImage(named: RIGHT_BLUE_ICON))
            button.tag = section
            
            let separatorView = UIView(frame: CGRect.init(x: 25, y: 45, width: tableView.frame.width - 50, height: 1))
            footerView.addSubview(separatorView)
            separatorView.backgroundColor = UIColor.setColor(colorType: .placeHolder)
            
            return footerView
        }
        return nil
    }

    // set height for footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.isComingFrom == .Home{
            return 40
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("in \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.isComingFrom == .Home{
            return 50
        }else{
            return 0
        }
    }
    
    @objc func buttonPressed(sender: UIButton) {
        switch sender.tag {
        case 0:
            self.delegateViewMore?.tapActionOfViewMoreEvents(index: sender.tag)
            print(sender.tag)
        case 1:
            print(sender.tag)
            self.delegateViewMore?.tapActionOfViewMoreEvents(index: sender.tag)
        case 2:
            print(sender.tag)
            self.delegateViewMore?.tapActionOfViewMoreEvents(index: sender.tag)
        case 3:
            print(sender.tag)
            self.delegateViewMore?.tapActionOfViewMoreEvents(index: sender.tag)
        case 4:
            print(sender.tag)
            self.delegateViewMore?.tapActionOfViewMoreEvents(index: sender.tag)
        default:
            break;
        }
    }
    
}
