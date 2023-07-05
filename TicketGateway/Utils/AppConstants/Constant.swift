//
//  Secens.swift
//  TicketGateway
//
//  Created by Apple  on 13/04/23.
//
import Foundation
import UIKit

enum Storyboard: String {
    case main = "Main"
    case home = "Home"
    case sidemenu = "SideMenu"
    case costumes =  "Costume"
    case manageevent = "ManageEvents"
    case scanevent = "ScanEvents"
    case wallet = "Wallet"
    case order = "Order"
    case profile = "Profile"
    case settings = "Settings"
    case manageventorder = "ManageEventOrder"
    case favourites = "Favorites"
}

enum StoryboardIdentifier: String {
    case LoginVC
    case SignUpVC
    case WelComeVC
    case WelcomeLoginSignupVC
    case ForgotPasswordVC
    case OtpNumberVC
    case OtpEmailVC
    case CreateAccountVC
    case VerifyPopupVC
    case LoginNmberWithEmailVC
    
    //Home
    case HomeVC
    case EventSearchHomeVC
    case EventSearchLocationVC
    case EventBookingTicketVC
    case EventBookingTicketOnApplyCouponVC
    case EventBookingTicketAddOnsVC
    case EventBookingOrderSummaryVC
    case EventBookingPaymentMethodVC
    case PaymentSuccessFullVC
    case PhoneVerificationViewController
    //SideMenuBar
    case AddAmountWalletVC
    case AmountAddedSuccessfullyVC
    case Organizers_Artists_ListVC
    case MyFollowersVC
    case VenueVC
    case EventDetailVC
    case MyWalletVC
    case MyRefundVC
    case CostumeViewController
    case DeviceSettingVC
    case Reward_LoyaltyPointsVC
    case NotificationVC
    case FAQVC
    //order
    case MyOrderViewController
    case SegmentCostumeVC
    case MyTicketVC
    case SeeFullTicketVC
    case TransferTicketVC
    case ContinueToTransferVC
    case ExchangeTicketVC
    case OrderSummaryVC
    case ChangeNameVC
    case ContactOrganiserVC
    case RequestRefundVC
    case EventDetailStatusVC
    case FeedbackViewController
    
    //ManageEvent
    //DashBoard
    case ManageEventVC
    case ManageEventDashboardVC
    case ManageEventTicketSoldVC
    case PromoCodeVC
    case ManageSellTicketSuccessfully
    case ManageSellTicketComplimentary
    case AddCardVC
    //sell
    case ManageSellAddBuyerVC
    case ManageSellBuyersInfoListVC
    
    //Check In
      case ManageEventCheckInVC
      case AttendeeDetailsVC
      case ScanQRVC
    
    //Profile/Settings
    case ManageEventSettingVC
    case ManageEventProfileVC
    case SoldOutTicketVC
    case CancelThisEventVC
    case ZoomViewController
    case ManageEventEditProfileVC
    //order
    case ManageEventOrderDeatilVC
    case RefundOptionsVC
    case ReviewRefundVC
    //Favourites
    case FavouriteVC
    
    //ScanEvents
      case ScanEventVC
      case SelectTicketTypeVC
      case ScannerVC
      case SearchVC
      case ScanSummaryVC
      case FindRFIDVC
      case EndScanPoPUpVC
  
}


public extension Notification.Name {
     static let didUpdateWorkoutData = Notification.Name(rawValue: "didUpdateWorkoutData")
     static let didStopWorkoutTimer = Notification.Name(rawValue: "didStopWorkoutTimer")
}


let GOOGLE_CLIENT_ID = "1090307909671-o90bdqh5777lnkgqk9mugturu85d524g.apps.googleusercontent.com"
let TITLE_LOGIN = "Login"
let TITLE_CONTINUE = "Continue"


//MARK: - IMAGE NAME
let RIGHT_BUTTON_ICON = "rightOnButton"
let X_ICON = "x"
let PROFILE_ICON = "profile"
let PLUS_ICON = "plus"
let SHARE_ICON = "share"
let DOWNLOAD_ICON = "download"
let LEFT_ARROW_ICON = "arrow left"
let RIGHT_ARROW_ICON = "arrow right"
let CREDIT_CARD_ICON = "credit-card"
let DOLLAR_ICON = "dollar-sign"
let MENU_ICON = "Menu"
let SAVE_ICON = "Save"
let EDIT_2_ICON = "edit-2"
let CIRCLE_CHEVRON_UP_ICON = "circlechevronUp_ip"
let CIRCLE_CHEVRON_DOWN_ICON = "circleChevron-down_ip"
let REFUND_ICON = "Refund_ip"
let EVEN_FILTER_ICON = "EventFilter_ip"
let BACK_ARROW_ICON = "backArrow"
let RIGHT_BLUE_ICON = "ri8Blue"
let CHEVRON_UP_GD_ICON = "chevron-upGD_ip"
let CHEVRON_DOWN_DB_ICON = "chevron-downDB_ip"
let UNACTIVE_ICON = "unActive"
let ARROW_UP = "arrow-up"
let ACTIVE_ICON = "active"
let ARROW_DOWN_ICON = "arrow-down"
let CART_ICON = "Cart_ip"
let RADIO_SELECTION_ICON = "radio selection_ip"
let REMOVE_ICON = "Remov_ip"
let UNSELECTED_ICON = "Unselected_ip"
let ADD_ICON = "Add_ip"
let LEFT_ARROW = "LeftArrow_ip"
let CHEVRON_DOWN = "chevron-down_ip"
let FILTER_ICON = "ic-Filter"
let SORT_ICON = "sort_ip"
let IMAGE_ICON = "image"
let IMAGE_UNACTIVE_TERM_ICON = "unactiveTerm"
let IMAGE_ACTIVE_TERM_ICON = "activeTerm"
let UPLOAD_ICON = "upload_ip"
let FILTER_RADIO_INACTIVE = "filter_radio_inactive"
let FILTER_RADIO_ACTIVE = "filter_radio_active"
let BRAND_LEADER_ICON = "img_brand_leader"
let THUMBSUP_SELECTED_ICON = "img_thumbsup_selected"
let THUMBSUP_UNSELECTED_ICON = "img_thumbsup_unselected"
let THUMBSDOWN_SELECTED_ICON = "img_thumbsdown_selected"
let THUMBSDOWN_UNSELECTED_ICON = "img_thumbsdown_unselected"
