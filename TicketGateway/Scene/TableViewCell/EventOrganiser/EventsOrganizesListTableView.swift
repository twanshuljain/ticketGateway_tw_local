//
//  EventsOrganizesListTableView.swift
//  TicketGateway
//
//  Created by Apple  on 28/04/23.
//
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name

import UIKit

enum IsComingFromForEventsOrganizesListTableView{
    case Home
    case EventDetail
    case Venue
    case EventSearch
    case None
    case NoneEventDetail
}

protocol EventsOrganizesListTableViewProtocol{
    func tapActionOfViewMoreEvents(index:Int)
}

class EventsOrganizesListTableView: UITableView {
    var arrData = [GetEventModel]()
    var arrDataa = [GetEventModel]()
    var arrEventCategory = [EventCategories]()
    
    var arrDataaWeekend = [GetEventModel]()
    var arrDataaVirtual = [GetEventModel]()
    var arrDataaPopular = [GetEventModel]()
    var arrDataaFree = [GetEventModel]()
    var arrDataaUpcoming = [GetEventModel]()
    
    var isFromSearch: Bool = false
    var tableDidSelectAtIndex: ((IndexPath) -> Void)?
    var selectedDevice = ""
    var isFromDeselected = false
    var isComingFrom:IsComingFromForEventsOrganizesListTableView? = .Home
    var delegateViewMore: EventsOrganizesListTableViewProtocol?
    
    var arrDataCategorySearch = [GetEventModel]()
    var arrSearchData = [GetEventModel]()
    
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
//            if self.arrDataaWeekend.count != 0{
//                return 1
//            }else if self.arrDataaVirtual.count != 0{
//                return 2
//            }else if self.arrDataaPopular.count != 0{
//                return 3
//            }else if self.arrDataaFree.count != 0{
//                return 4
//            }else if self.arrDataaUpcoming.count != 0{
//                return 5
//            }else{
//                return 0
//            }
           return self.arrEventCategory.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isComingFrom == .Home{
//            switch section {
//            case 0: return self.arrDataaWeekend.count
//            case 1: return self.arrDataaVirtual.count
//            case 2: return self.arrDataaPopular.count
//            case 3: return self.arrDataaFree.count
//            case 4: return self.arrDataaUpcoming.count
//            default:
//                return 0
//            }
//            if self.arrDataa.count == 0{
//                return 5
//            }else{
//                return self.arrDataa.count
//            }
            if self.arrEventCategory[section] == .nearByLocation{
                return self.arrDataCategorySearch.count
            }else if self.arrEventCategory[section] == .weekend{
                return self.arrDataaWeekend.count
            }else if self.arrEventCategory[section] == .online{
                return self.arrDataaVirtual.count
            }else if self.arrEventCategory[section] == .popular{
                return self.arrDataaPopular.count
            }else if self.arrEventCategory[section] == .free{
                return self.arrDataaFree.count
            }else if self.arrEventCategory[section] == .upcoming{
                return self.arrDataaUpcoming.count
            }else{
                return 0
            }
            
            
        }else if self.isComingFrom == .EventDetail{
            if self.arrData.count == 0{
                return 5
            }else{
                return self.arrData.count
            }
        }else if self.isComingFrom == .EventSearch {
            ///return arrDataCategorySearch.count
            return isFromSearch ? arrSearchData.count: arrDataCategorySearch.count
          }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as? EventTableViewCell {
            cell.btnLike.addTarget(self, action: #selector(btnLikeAction(_:)), for: .touchUpInside)
            cell.btnLike.setImage(UIImage(named: "favSele_ip"), for: .selected)
            cell.btnLike.setImage(UIImage(named: "favUnSele_ip"), for: .normal)
            cell.btnShare.addTarget(self, action: #selector(btnShareAction(_:)), for: .touchUpInside)
            if self.isComingFrom == .Home{
                
                switch self.arrEventCategory[indexPath.section] {
                case .nearByLocation:
                    if arrDataCategorySearch.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataCategorySearch[indexPath.row]
                    }
                case .weekend:
                    if arrDataaWeekend.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataaWeekend[indexPath.row]
                    }
                case .online:
                    if arrDataaVirtual.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataaVirtual[indexPath.row]
                    }
                case .popular:
                    if arrDataaPopular.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataaPopular[indexPath.row]
                    }
                case .free:
                    if arrDataaFree.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataaFree[indexPath.row]
                    }
                case .upcoming:
                    if arrDataaUpcoming.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataaUpcoming[indexPath.row]
                    }
                }
            }else if self.isComingFrom == .EventSearch {
                if isFromSearch {
                  if arrSearchData.indices.contains(indexPath.row) {
                    cell.getEvent = self.arrSearchData[indexPath.row]
                  }
                } else {
                  if arrDataCategorySearch.indices.contains(indexPath.row) {
                    cell.getEvent = self.arrDataCategorySearch[indexPath.row]
                  }
                }
                //    if arrDataCategorySearch.indices.contains(indexPath.row) {
                //     cell.getEvent = self.arrDataCategorySearch[indexPath.row]
                //    }
              }else{
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
            
            
            switch self.arrEventCategory[section] {
            case .nearByLocation:
                label.text = "Events Near Toronto"
                return headerView
            case .weekend:
                label.text = "This Weekend"
                return headerView
            case .online:
                label.text = "Online Events"
                return headerView
            case .popular:
                label.text = "Popular Events"
                return headerView
            case .free:
                label.text = "Free Events"
                return headerView
            case .upcoming:
                label.text = "Upcoming Events"
                return headerView
            }
        }
        return nil
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         if let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as? EventTableViewCell {
//             if arrEventCategory.indices.contains(indexPath.section){
//                 switch self.arrEventCategory[indexPath.section] {
//                 case .weekend: self.tableDidSelectAtIndex?(indexPath)
//                 case .online: self.tableDidSelectAtIndex?(indexPath)
//                 case .popular: self.tableDidSelectAtIndex?(indexPath)
//                 case .free: self.tableDidSelectAtIndex?(indexPath)
//                 case .upcoming: self.tableDidSelectAtIndex?(indexPath)
//                 default:
//                     break;
//                 }
//                 self.reloadData()
//             }
//         }
         self.tableDidSelectAtIndex?(indexPath)
    }
    
    // set view for footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if self.isComingFrom == .Home{
            let footerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
            let button = CustomButtonNormal()
            button.frame = CGRect.init(x: 16, y: 0, width: footerView.frame.width, height: footerView.frame.height)
            footerView.addSubview(button)
            button.setTitles(text: "View more events", font: .systemFont(ofSize: 20), tintColour: .blue, textColour: UIColor.setColor(colorType: .tgBlue))
            button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
            button.addRightIcon(image: UIImage(named: "ri8Blue"))
            button.tag = section
            
            let separatorView = UIView(frame: CGRect.init(x: 25, y: 45, width: tableView.frame.width - 50, height: 1))
            footerView.addSubview(separatorView)
            separatorView.backgroundColor = UIColor.setColor(colorType: .placeHolder)
            
            switch self.arrEventCategory[section] {
            case .nearByLocation:
                return nil
            case .weekend:
                return footerView
            case .online:
                return footerView
            case .popular:
                return footerView
            case .free:
                return footerView
            case .upcoming:
                return footerView
            
            }
        }
        return nil
    }

    // set height for footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.isComingFrom == .Home{
            if self.arrEventCategory[section] == .nearByLocation{
                return 0
            }
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
        switch self.arrEventCategory[sender.tag] {
        case .nearByLocation:
            //self.delegateViewMore?.tapActionOfViewMoreEvents(index: sender.tag)
            print(sender.tag)
        case .weekend:
            self.delegateViewMore?.tapActionOfViewMoreEvents(index: sender.tag)
            print(sender.tag)
        case .online:
            print(sender.tag)
            self.delegateViewMore?.tapActionOfViewMoreEvents(index: sender.tag)
        case .popular:
            print(sender.tag)
            self.delegateViewMore?.tapActionOfViewMoreEvents(index: sender.tag)
        case .free:
            print(sender.tag)
            self.delegateViewMore?.tapActionOfViewMoreEvents(index: sender.tag)
        case .upcoming:
            print(sender.tag)
            self.delegateViewMore?.tapActionOfViewMoreEvents(index: sender.tag)
        default:
            break;
        }
    }
    
    @objc func btnLikeAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc func btnShareAction(_ sender: UIButton) {
           
        
    }
    
}
