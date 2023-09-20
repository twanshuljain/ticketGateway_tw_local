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

protocol ActivityController {
    func toShowActivityController(eventDetail:GetEventModel)
}

protocol FavouriteAction {
    func toCallFavouriteaApi(eventDetail:GetEventModel, isForLocation: Bool)
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
    var delegateShareAction: ActivityController?
    var delegateLikeAction: FavouriteAction?
    var arrDataCategorySearch = [GetEventModel]()
    var arrSearchData = [GetEventModel]()
    var shareEvent:GetEventModel?
    var countryName = Locale.current.localizedString(forRegionCode: Locale.current.regionCode ?? "") ?? "Toronto"
    
    func configure(isComingFrom:IsComingFromForEventsOrganizesListTableView?) {
        self.isComingFrom = isComingFrom
        self.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        self.delegate = self
        self.dataSource = self
    }
    
    func btnShareActionTapped(btn:UIButton, indexPath:IndexPath) {
        print("IndexPath : \(indexPath.row)")
        if self.isComingFrom == .Home{
            switch self.arrEventCategory[indexPath.section] {
            case .noLocationData:
                print("No Location Data")
            case .nearByLocation:
                if arrDataCategorySearch.indices.contains(indexPath.row){
                    self.delegateShareAction?.toShowActivityController(eventDetail: self.arrDataCategorySearch[indexPath.row])
                }
            case .weekend:
                if arrDataaWeekend.indices.contains(indexPath.row){
                    self.delegateShareAction?.toShowActivityController(eventDetail: self.arrDataaWeekend[indexPath.row])
                }
            case .online:
                if arrDataaVirtual.indices.contains(indexPath.row){
                    self.delegateShareAction?.toShowActivityController(eventDetail: self.arrDataaVirtual[indexPath.row])
                }
            case .popular:
                if arrDataaPopular.indices.contains(indexPath.row){
                    self.delegateShareAction?.toShowActivityController(eventDetail: self.arrDataaPopular[indexPath.row])
                }
            case .free:
                if arrDataaFree.indices.contains(indexPath.row){
                    self.delegateShareAction?.toShowActivityController(eventDetail: self.arrDataaFree[indexPath.row])
                }
            case .upcoming:
                if arrDataaUpcoming.indices.contains(indexPath.row){
                    self.delegateShareAction?.toShowActivityController(eventDetail: self.arrDataaUpcoming[indexPath.row])
                }
            }
        } else if isComingFrom == .EventDetail {
            // Suggestions Event
            if arrData.indices.contains(indexPath.row){
                self.delegateShareAction?.toShowActivityController(eventDetail: self.arrData[indexPath.row])
            }
        } else if isComingFrom == .EventSearch {
            // For Serach Screen
            if arrSearchData.indices.contains(indexPath.row){
                self.delegateShareAction?.toShowActivityController(eventDetail: self.arrSearchData[indexPath.row])
            }
        }
    }
    func btnLikeActionTapped(btn:UIButton, indexPath:IndexPath) {
        print("IndexPath : \(indexPath.row)")
        if self.isComingFrom == .Home {
            switch self.arrEventCategory[indexPath.section] {
            case .noLocationData:
                print("No Location Data")
            case .nearByLocation:
                if arrDataCategorySearch.indices.contains(indexPath.row) {
                    arrDataCategorySearch[indexPath.row].likeCountData?.isLiked?.toggle()
                    self.delegateLikeAction?.toCallFavouriteaApi(eventDetail: self.arrDataCategorySearch[indexPath.row], isForLocation: true)
                    
                }
            case .weekend:
                if arrDataaWeekend.indices.contains(indexPath.row){
                    arrDataaWeekend[indexPath.row].likeCountData?.isLiked?.toggle()
                    self.delegateLikeAction?.toCallFavouriteaApi(eventDetail: self.arrDataaWeekend[indexPath.row], isForLocation: false)
                }
            case .online:
                if arrDataaVirtual.indices.contains(indexPath.row){
                    arrDataaVirtual[indexPath.row].likeCountData?.isLiked?.toggle()
                    self.delegateLikeAction?.toCallFavouriteaApi(eventDetail: self.arrDataaVirtual[indexPath.row], isForLocation: false)
                }
            case .popular:
                if arrDataaPopular.indices.contains(indexPath.row){
                    arrDataaPopular[indexPath.row].likeCountData?.isLiked?.toggle()
                    self.delegateLikeAction?.toCallFavouriteaApi(eventDetail: self.arrDataaPopular[indexPath.row], isForLocation: false)
                }
            case .free:
                if arrDataaFree.indices.contains(indexPath.row){
                    arrDataaFree[indexPath.row].likeCountData?.isLiked?.toggle()
                    self.delegateLikeAction?.toCallFavouriteaApi(eventDetail: self.arrDataaFree[indexPath.row], isForLocation: false)
                }
            case .upcoming:
                if arrDataaUpcoming.indices.contains(indexPath.row){
                    arrDataaUpcoming[indexPath.row].likeCountData?.isLiked?.toggle()
                    self.delegateLikeAction?.toCallFavouriteaApi(eventDetail: self.arrDataaUpcoming[indexPath.row], isForLocation: false)
                }
            }
        } else if isComingFrom == .EventDetail {
            // Suggestions Event
            if arrData.indices.contains(indexPath.row){
                arrData[indexPath.row].isLiked?.toggle()
                self.delegateLikeAction?.toCallFavouriteaApi(eventDetail: self.arrData[indexPath.row], isForLocation: true)
            }
        } else if isComingFrom == .EventSearch {
            // For Serach Screen
            if arrSearchData.indices.contains(indexPath.row) {
                arrSearchData[indexPath.row].likeCountData?.isLiked?.toggle()
                self.delegateLikeAction?.toCallFavouriteaApi(eventDetail: self.arrSearchData[indexPath.row], isForLocation: true)
            }
        }
        // Condition for -> If user with guest login then like/unlike feature should not work.
        if !(UserDefaultManager.share.getUserBoolValue(key: .isGuestLogin)) {
            self.reloadData()
        }
    }
    
//    @objc func btnShareAction(_ sender: UIButton) {
//        self.delegateShareAction?.toShowActivityController(index: sender.tag)
//    }

//    @objc func btnLikeAction(_ sender: UIButton) {
//
//        sender.isSelected = !sender.isSelected
//    }
    
    
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
            if self.arrEventCategory[section] == .noLocationData{
                return 1
            }else if self.arrEventCategory[section] == .nearByLocation{
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
                //return 3
            }
        }else if self.isComingFrom == .EventSearch {
            ///return arrDataCategorySearch.count
            return isFromSearch ? arrSearchData.count: arrDataCategorySearch.count
          }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as? EventTableViewCell {
//            cell.btnLike.addTarget(self, action: #selector(btnLikeAction(_ :)), for: .touchUpInside)
          //  cell.btnLike.tag = indexPath
//            cell.btnLike.setImage(UIImage(named: "favSele_ip"), for: .selected)
//            cell.btnLike.setImage(UIImage(named: "favUnSele_ip"), for: .normal)
            cell.btnShare.mk_addTapHandler { (btn) in
                 print("You can use here also directly : \(indexPath.row)")
                 self.btnShareActionTapped(btn: btn, indexPath: indexPath)
            }
            cell.btnLike.mk_addTapHandler { (btn) in
                 self.btnLikeActionTapped(btn: btn, indexPath: indexPath)
            }
            //cell.btnShare.addTarget(self, action: #selector(btnShareAction(_:)), for: .touchUpInside)
            if self.isComingFrom == .Home{
                
                switch self.arrEventCategory[indexPath.section] {
                case .noLocationData:
                    cell.setNoDataFound(countryName: self.countryName)
                case .nearByLocation:
                    if arrDataCategorySearch.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataCategorySearch[indexPath.row]
                        cell.btnLike.setImage(UIImage(named: (arrDataCategorySearch[indexPath.row].likeCountData?.isLiked ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
                       // cell.lblAddress.text = cell.getEvent?.locationType == "VIRTUAL" ? VirtualEvent : cell.getEvent?.locationType == "MULTIPLE" ? MultipleLocation : (cell.getEvent?.location?.eventAddress ?? "-")
                    }
                case .weekend:
                    if arrDataaWeekend.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataaWeekend[indexPath.row]
                        cell.btnLike.setImage(UIImage(named: (arrDataaWeekend[indexPath.row].likeCountData?.isLiked ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
                    }
                case .online:
                    if arrDataaVirtual.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataaVirtual[indexPath.row]
                        cell.btnLike.setImage(UIImage(named: (arrDataaVirtual[indexPath.row].likeCountData?.isLiked ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
                      //  cell.lblAddress.text = cell.getEvent?.locationType == "VIRTUAL" ? VirtualEvent : cell.getEvent?.locationType == "MULTIPLE" ? MultipleLocation : (cell.getEvent?.location?.eventAddress ?? "-")
                        
                    }
                case .popular:
                    if arrDataaPopular.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataaPopular[indexPath.row]
                        cell.btnLike.setImage(UIImage(named: (arrDataaPopular[indexPath.row].likeCountData?.isLiked ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
                    }
                case .free:
                    if arrDataaFree.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataaFree[indexPath.row]
                        cell.btnLike.setImage(UIImage(named: (arrDataaFree[indexPath.row].likeCountData?.isLiked ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
                    }
                case .upcoming:
                    if arrDataaUpcoming.indices.contains(indexPath.row){
                        cell.getEvent = self.arrDataaUpcoming[indexPath.row]
                        cell.btnLike.setImage(UIImage(named: (arrDataaUpcoming[indexPath.row].likeCountData?.isLiked ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
                    }
                }
            } else if self.isComingFrom == .EventSearch {
                if isFromSearch {
                    if arrSearchData.indices.contains(indexPath.row) {
                        cell.getEvent = self.arrSearchData[indexPath.row]
                        cell.btnLike.setImage(UIImage(named: (arrSearchData[indexPath.row].likeCountData?.isLiked ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
                    }
                } else {
                    if arrDataCategorySearch.indices.contains(indexPath.row) {
                        cell.getEvent = self.arrDataCategorySearch[indexPath.row]
                        cell.btnLike.setImage(UIImage(named: (arrDataCategorySearch[indexPath.row].likeCountData?.isLiked ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
                    }
                }
                //    if arrDataCategorySearch.indices.contains(indexPath.row) {
                //     cell.getEvent = self.arrDataCategorySearch[indexPath.row]
                //    }
            } else if isComingFrom == .EventDetail {
                  if arrData.indices.contains(indexPath.row) {
                      cell.getEvent = self.arrData[indexPath.row]
                      cell.btnLike.setImage(UIImage(named: (arrData[indexPath.row].isLiked ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
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
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            headerView.addSubview(label)
            
            
            switch self.arrEventCategory[section] {
            case .noLocationData:
                print("No Location Data")
                label.text = "Events Near \(self.countryName)"
                return headerView
            case .nearByLocation:
                label.text = "Events Near \(countryName)"
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
        if self.isComingFrom == .Home{
            switch self.arrEventCategory[section] {
            case .noLocationData:
                print("No Location Data")
                return nil
            case .nearByLocation:
                return footerView
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
        }else if self.isComingFrom == .EventDetail{
            return footerView
        }else{
            return nil
        }
    }

    // set height for footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.isComingFrom == .Home{
            if self.arrEventCategory[section] == .nearByLocation{
                return 40
            }else if self.arrEventCategory[section] == .noLocationData{
                return 0
            }
            return 40
        }else if self.isComingFrom == .EventDetail{
            return 40
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.isComingFrom == .Home{
            if self.arrEventCategory[indexPath.section] == .noLocationData{
                return 50
            }
            return UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       // print("in \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.isComingFrom == .Home{
//            if self.arrEventCategory[section] == .noLocationData{
//                return 0
//            }
            return 50
        }else{
            return 0
        }
    }
    
    @objc func buttonPressed(sender: UIButton) {
        if self.isComingFrom == .Home{
            switch self.arrEventCategory[sender.tag] {
            case .nearByLocation:
                self.delegateViewMore?.tapActionOfViewMoreEvents(index: sender.tag)
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
        }else if self.isComingFrom == .EventDetail{
            self.delegateViewMore?.tapActionOfViewMoreEvents(index: sender.tag)
        }

    }
   
    
}
