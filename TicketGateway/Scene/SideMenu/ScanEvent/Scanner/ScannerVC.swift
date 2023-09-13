//
//  ScannerVC.swift
//  TicketGateway
//
//  Created by Apple on 20/06/23.
// swiftlint: disable force_cast
// swiftlint: disable line_length
import UIKit
import AVFoundation
import SDWebImage

class ScannerVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var qrScannerView: UIView!
    @IBOutlet weak var lblScan: UILabel!
    @IBOutlet weak var imgScan: UIImageView!
    @IBOutlet weak var btnScan: UIButton!
    @IBOutlet weak var lblFindRfid: UILabel!
    @IBOutlet weak var imgFindRfid: UIImageView!
    @IBOutlet weak var btnFindRfid: UIButton!
    @IBOutlet weak var lblSearch: UILabel!
    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var lbl3Tix: UILabel!
    @IBOutlet weak var btnTicket: CustomButtonGradiant!
    @IBOutlet weak var lblSunburnReload: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnTourch: UIButton!
    @IBOutlet weak var btn1X: UIButton!
    @IBOutlet weak var btnEndScan: UIButton!
    @IBOutlet weak var lblAccepted: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblRejected: UILabel!
    @IBOutlet weak var imgProfileImage: UIImageView!
    // MARK: - Variables
    let viewModel = ScannerViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setFont()
        self.getCameraPreview()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUIAndGetScanDetail()
    }
}
// MARK: -
extension ScannerVC {
    func getCameraPreview(){
        viewModel.captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        if viewModel.captureSession.canAddInput(videoInput){
            viewModel.captureSession.addInput(videoInput)
        } else {
            showAlertController(message: SCANNING_DOES_NOT_SUPPORT)
            return
        }
        let metadataOutput = AVCaptureMetadataOutput()
        if viewModel.captureSession.canAddOutput(metadataOutput) {
            viewModel.captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            showAlertController(message: SCANNING_DOES_NOT_SUPPORT)
            return
        }
        viewModel.previewLayer = AVCaptureVideoPreviewLayer(session: viewModel.captureSession)
        viewModel.previewLayer.frame = qrScannerView.layer.bounds
        viewModel.previewLayer.videoGravity = .resizeAspectFill
        qrScannerView.layer.addSublayer(viewModel.previewLayer)
        DispatchQueue.global(qos: .background).async {
            self.viewModel.captureSession.startRunning()
        }
    }
    func setFont() {
        self.lblScan.text = SCAN
        self.lblScan.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        let gradient = getGradientLayer(bounds: view.bounds)
        self.lblScan.textColor = gradientColor(bounds: view.bounds, gradientLayer: gradient)
        self.imgScan.image = UIImage(named: SCAN_SELECTED_ICON)
        self.lblFindRfid.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblFindRfid.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblFindRfid.text = FIND_RFID
        self.imgFindRfid.image = UIImage(named: FIND_UNSELECT_ICON)
        self.lblSearch.text = SEARCH
        self.lblSearch.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblSearch.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.imgSearch.image = UIImage(named: SEARCH_UNSELECT_ICON)
        self.lbl3Tix.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lbl3Tix.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblSunburnReload.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblSunburnReload.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblDate.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblDate.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btn1X.titleLabel?.font = UIFont.setFont(fontType: .regular, fontSize: .ten)
        self.btn1X.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlue)
        self.btnEndScan.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnEndScan.titleLabel?.textColor = UIColor.setColor(colorType: .tgRed)
        self.lblAccepted.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblAccepted.textColor = UIColor.setColor(colorType: .tgGreen)
        self.lblTotal.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblTotal.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblRejected.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblRejected.textColor = UIColor.setColor(colorType: .tgRed)
    }
}
// MARK: - Instance Method
extension ScannerVC {
    func setUI() {
        [self.btnSearch, self.btnScan, self.btnFindRfid, self.btnTicket, self.btn1X, self.btnTourch, self.btnEndScan].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        }
    }
    func dataSetAfterAPICall() {
        lblAccepted.text = "Accepted : \(viewModel.getScanDetailData?.acceptedCount ?? 0)"
        lblRejected.text = "Rejected : \(viewModel.getScanDetailData?.rejectedCount ?? 0)"
        lblTotal.text = "Total : \(viewModel.getScanDetailData?.totalCount ?? 0)"
    }
    func setUIAndGetScanDetail() {
        if let url = (APIHandler.shared.s3URL + viewModel.getScanTicketDetails.imageUrl).getCleanedURL() {
            self.imgProfileImage.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
        } else {
            self.imgProfileImage.image = UIImage(named: "homeDas")
        }
        // Here the data is being set to the model which we are bringing from the previous screen
        viewModel.scanBarCodeModel.name = viewModel.getScanTicketDetails.name
        viewModel.scanBarCodeModel.event_id = viewModel.getScanTicketDetails.eventId
        viewModel.scanBarCodeModel.scan_ticket_types = viewModel.getScanTicketDetails.selectedTicketType
        // Set Data to UI Components
        self.lblSunburnReload.text = viewModel.getScanTicketDetails.eventName
        self.lblDate.text = Date().convertToString()
        getScanDetail()
    }
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnScan:
            self.btnScanAction()
        case btnFindRfid:
            self.btnFindRfidAction()
        case btnSearch:
            self.btnSearchAction()
        case btnTicket:
            self.btnTicketAction()
        case btn1X:
            self.btn1XAction()
        case btnTourch:
            self.btnTourchAction()
        case btnEndScan:
            self.btnEndScanAction()
        default:
            break
        }
    }
    func btnScanAction() {
    }
    func btnFindRfidAction() {
        if let findRFIDVc = createView(storyboard: .scanevent, storyboardID: .FindRFIDVC) as? FindRFIDVC {
            findRFIDVc.viewModel.getScanTicketDetails = viewModel.getScanTicketDetails
            self.navigationController?.pushViewController(findRFIDVc, animated: false)
        }
    }
    func btnSearchAction() {
        if let searchVc = createView(storyboard: .scanevent, storyboardID: .SearchVC) as? SearchVC {
            searchVc.viewModel.getScanTicketDetails = viewModel.getScanTicketDetails
            self.navigationController?.pushViewController(searchVc, animated: false)
        }
    }
    func btnTicketAction() {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: SelectTicketTypeVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    func btn1XAction() {
    }
    func btnTourchAction() {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        if (device?.hasTorch) != nil {
            do {
                try device?.lockForConfiguration()
                if device?.torchMode == AVCaptureDevice.TorchMode.on {
                    device?.torchMode = AVCaptureDevice.TorchMode.off
                } else {
                    do {
                        try device?.setTorchModeOn(level: 1.0)
                    } catch {
                        print(error)
                    }
                }
                device?.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    func btnEndScanAction() {
        let popUpVc = self.createView(storyboard: .scanevent, storyboardID: .EndScanPoPUpVC) as! EndScanPoPUpVC
        popUpVc.delegate = self
        popUpVc.strMsgForTitle = END_SCAN
        popUpVc.strMsgForDescription = WANT_TO_SCAN_EVENT
        popUpVc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(popUpVc, animated: true)
    }
    func getScanDetail() {
        if Reachability.isConnectedToNetwork() { // check internet connectivity
            self.view.showLoading(centreToView: self.view)
            viewModel.getScanDetail(
                complition: { isTrue, showMessage in
                    if isTrue {
                        DispatchQueue.main.async {
                            self.view.stopLoading()
                            self.dataSetAfterAPICall()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.view.stopLoading()
                            self.showToast(message: showMessage)
                        }
                    }
                }
            )
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
    func scanBarCode() {
        if Reachability.isConnectedToNetwork() { // check internet connectivity
            self.view.showLoading(centreToView: self.view)
            viewModel.scanBarCodeApi(
                complition: { isTrue, showMessage in
                    if isTrue {
                        DispatchQueue.main.async {
                            self.view.stopLoading()
                            // Get Updated Data after send QRid
                            self.getScanDetail()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.view.stopLoading()
                            self.showToast(message: showMessage)
                        }
                    }
                }
            )
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
}
// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        viewModel.captureSession.stopRunning() // stop scanning after receiving metadata output
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let codeString = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.receivedCodeForQR(qrcode: codeString)
        }
    }
    func receivedCodeForQR(qrcode: String) {
        print("qrcode", qrcode)
        viewModel.scanBarCodeModel.qrid = qrcode
        scanBarCode()
    }
}
// MARK: - AlertAction
extension ScannerVC: AlertAction {
    func alertYesaction() {
        if let view = createView(storyboard: .scanevent, storyboardID: .ScanSummaryVC) as? ScanSummaryVC {
            view.viewModel.scanSummaryModel.event_id = viewModel.getScanTicketDetails.eventId
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
}
