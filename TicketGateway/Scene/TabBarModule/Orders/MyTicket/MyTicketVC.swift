//
//  MyTicketVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 31/05/23.
// swiftlint: disable force_cast
// swiftlint: disable line_length

import UIKit

class MyTicketVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnAddAppToWallet: CustomButtonNormal!
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    
    var viewModel: MyTicketViewModel = MyTicketViewModel()
    var myOrderViewModel: MyOrderViewModel = MyOrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.setFont()
        self.setNavigationBar()
        self.apiCallForMyTicketList()
    }
    @objc func addActionSheet() {
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Transfer this ticket", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            if let transferTicketVC = self.createView(storyboard: .order, storyboardID: .TransferTicketVC) as? TransferTicketVC{
                transferTicketVC.viewModel.ticketDetails = self.viewModel.ticketDetails
                transferTicketVC.viewModel.eventDetail = self.viewModel.eventDetail
                transferTicketVC.viewModel.myTicket = self.viewModel.myTicket
                self.navigationController?.pushViewController(transferTicketVC, animated: true)
            }
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Exchange ticket", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            let exchangeTicketVC = self.createView(storyboard: .order, storyboardID: .ExchangeTicketVC)
            self.navigationController?.pushViewController(exchangeTicketVC, animated: true)
        }))
        actionsheet.addAction(UIAlertAction(title: "Change name on ticket", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            if let changeNameVC = self.createView(storyboard: .order, storyboardID: .ChangeNameVC) as? ChangeNameVC{
                changeNameVC.viewModel.myTicket = self.viewModel.myTicket
                self.navigationController?.pushViewController(changeNameVC, animated: true)
            }
        }))
        actionsheet.addAction(UIAlertAction(title: "Share this event", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            if let eventDetail = self.viewModel.eventDetail {
                self.shareEventDetailData(eventDetail: eventDetail)
            }
        }))
        actionsheet.addAction(UIAlertAction(title: "Contact organiser", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            if let contactOrganiserVC = self.createView(storyboard: .order, storyboardID: .ContactOrganiserVC) as? ContactOrganiserVC{
                contactOrganiserVC.viewModel.eventDetail = self.viewModel.eventDetail
                contactOrganiserVC.viewModel.oranizerId = self.viewModel.eventDetail?.organizer?.id ?? 0
                self.navigationController?.pushViewController(contactOrganiserVC, animated: true)
            }
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) -> Void in
        }))
        self.present(actionsheet, animated: true, completion: nil)
    }
}

// MARK: - Functions
extension MyTicketVC {
    func configure() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "MyTicketCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyTicketCollectionViewCell")
    }
    
    func setNavigationBar() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = MY_TICKETS
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        if !self.viewModel.isFromPast{
            self.vwNavigationView.btnRight.isHidden = false
            self.vwNavigationView.btnRight.setImage(UIImage(named: MENU_DOT_ICON), for: .normal)
            self.vwNavigationView.btnRight.addTarget(self, action: #selector(addActionSheet), for: .touchUpInside)
        }
    }
    func setFont() {
        self.btnAddAppToWallet.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnAddAppToWallet.titleLabel?.textColor = UIColor.setColor(colorType: .white)
        self.btnAddAppToWallet.addLeftIcon(image: UIImage(named: APPLE_WALLET_ICON))
    }
    
//    func setData(){
//        if let base64String = self.viewModel.myTicket?.items?.first?.qrcodeBase64Data{
//            self.imgQRCode.image = UIImage.decodeBase64(toImage: base64String)
//        }
//    }
    
    func apiCallForMyTicketList(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            self.viewModel.dispatchGroup1.enter()
            self.view.showLoading(centreToView: self.view)
            viewModel.getMyTicketList(complition: { isTrue, messageShowToast in
                if isTrue == true {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        //self.setData()
                        if self.viewModel.myTicket?.items?.count == 0{
                            self.showToast(message: "No Tickets Found!!")
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.showToast(message: messageShowToast)
                    }
                }
            })
            self.viewModel.dispatchGroup1.notify(queue: .main) {
                self.collectionView.reloadData()
                self.funcCallApiForEventDetail(eventId: self.viewModel.ticketDetails?.eventId)
            }
            
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
    
    func funcCallApiForEventDetail(eventId:Int?){
        if let eventId = eventId{
            if Reachability.isConnectedToNetwork() //check internet connectivity
            {
                self.view.showLoading(centreToView: self.view)
                viewModel.GetEventDetailApi(eventId: eventId, complition: { isTrue, messageShowToast in
                    if isTrue == true {
                        DispatchQueue.main.async {
                            self.view.stopLoading()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.view.stopLoading()
                            self.showToast(message: messageShowToast)
                        }
                    }
                })
            } else {
                DispatchQueue.main.async {
                    self.view.stopLoading()
                    self.showToast(message: ValidationConstantStrings.networkLost)
                }
            }
        }
    }
}

// MARK: - Actions
extension MyTicketVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnAddAppToWallet:
            break
        default:
            break
        }
    }
    @objc func seeFullTicketAction(_ sender: UIButton) {
        let seeFullTicketVC = self.createView(storyboard: .order, storyboardID: .SeeFullTicketVC) as? SeeFullTicketVC
        seeFullTicketVC?.viewModel.ticketDetails = viewModel.ticketDetails
        seeFullTicketVC?.viewModel.eventDetail = viewModel.eventDetail
        seeFullTicketVC?.viewModel.myTicket = viewModel.myTicket
        seeFullTicketVC?.viewModel.myTicketList = viewModel.myTicket?.items?[sender.tag]
        seeFullTicketVC?.viewModel.isFromPast = self.viewModel.isFromPast
        self.navigationController?.pushViewController(seeFullTicketVC!, animated: false)
    }
   @objc func saveTicketAsImage(_ sender: UIButton) {
       if let cell = self.collectionView.cellForItem(at: IndexPath.init(row: sender.tag, section: 0)) as? MyTicketCollectionViewCell{
           if let imageToSave =  cell.imgQRCode.image{
               UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
           }
       }
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
           if let error = error {
               // Handle the error here, for example, show an alert to inform the user.
               print("Error saving image: \(error.localizedDescription)")
               self.showToast(message: "Error while image saving: \(error.localizedDescription)")
           } else {
               // Image saved successfully, you can show a success message to the user.
               print("Image saved successfully!")
               self.showToast(message: "Image saved successfully!")
           }
       }
    func addAppToWalletAction() {
        
    }
    func shareEventDetailData(eventDetail: EventDetail) {
        self.shareEventDetailData(
            eventStartDate: eventDetail.eventDateObj?.eventStartDate ?? "",
            eventEndDate: eventDetail.eventDateObj?.eventEndDate ?? "",
            eventCoverImage: eventDetail.eventCoverImageObj?.eventCoverImage,
            eventTitle: eventDetail.event?.title,
            eventStartTime: eventDetail.eventDateObj?.eventStartTime ?? "",
            eventEndTime: eventDetail.eventDateObj?.eventEndDate ?? "",
            eventDescription: eventDetail.event?.eventDescription
        )
    }
}
// MARK: - NavigationBarViewDelegate
extension MyTicketVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.myTicket?.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyTicketCollectionViewCell", for: indexPath) as? MyTicketCollectionViewCell{
            cell.lblTicket.text = "Ticket \(indexPath.row+1) of \(self.viewModel.myTicket?.items?.count ?? 0)"
            cell.btnSeeFullTicket.tag = indexPath.row
            cell.btnSaveTicketAsImage.tag = indexPath.row
            cell.btnSaveTicketAsImage.addTarget(self, action: #selector(saveTicketAsImage(_:)), for: .touchUpInside)
            cell.btnSeeFullTicket.addTarget(self, action: #selector(seeFullTicketAction(_:)), for: .touchUpInside)
            cell.btnSaveTicketAsImage.tag = indexPath.row
            cell.btnSaveTicketAsImage.addTarget(self, action: #selector(saveTicketAsImage), for: .touchUpInside)
            if viewModel.myTicket?.items?.indices.contains(indexPath.row) ?? false{
                cell.setData(myTicket: viewModel.myTicket?.items?[indexPath.row])
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}


// MARK: - NavigationBarViewDelegate
extension MyTicketVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
