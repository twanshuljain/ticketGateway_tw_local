//
//  ScannerVC.swift
//  TicketGateway
//
//  Created by Apple on 20/06/23.
//

import UIKit
import AVFoundation

class ScannerVC: UIViewController {
    
 
//MARK: - Outlets
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
    
//MARK: - Variables
       let viewModel = ScannerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setFont()
        self.getCameraPreview()
    }
  
}

//MARK: -
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
        if (viewModel.captureSession.canAddInput(videoInput)){
            viewModel.captureSession.addInput(videoInput)
    } else {
    
    showAlertController(message: "Your device doesn't support for scanning a QR code. Please use a device with a camera.")
    return
    }
    let metadataOutput = AVCaptureMetadataOutput()
        if (viewModel.captureSession.canAddOutput(metadataOutput)) {
            viewModel.captureSession.addOutput(metadataOutput)
    metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    metadataOutput.metadataObjectTypes = [.qr]
    } else {
        showAlertController(message: "Your device doesn't support for scanning a QR code. Please use a device with a camera.")
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
        self.lblScan.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        let gradient = getGradientLayer(bounds: view.bounds)
        lblScan.textColor = gradientColor(bounds: view.bounds, gradientLayer: gradient)

        self.imgScan.image = UIImage(named: "ScanSelected_ip")
        self.lblFindRfid.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblFindRfid.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.imgFindRfid.image = UIImage(named: "FindUnselect_ip")
        self.lblSearch.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblSearch.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.imgSearch.image = UIImage(named: "SearchUnselect_ip")
        self.lbl3Tix.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lbl3Tix.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblSunburnReload.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblSunburnReload.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblDate.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblDate.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btn1X.titleLabel?.font = UIFont.setFont(fontType: .regular, fontSize: .ten)
        self.btn1X.titleLabel?.textColor = UIColor.setColor(colorType: .TGBlue)
        self.btnEndScan.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnEndScan.titleLabel?.textColor = UIColor.setColor(colorType: .TGRed)
        self.lblAccepted.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblAccepted.textColor = UIColor.setColor(colorType: .TGGreen)
        self.lblTotal.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblTotal.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblRejected.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblRejected.textColor = UIColor.setColor(colorType: .TGRed)
     
    }
}


//MARK: - Instance Method
extension ScannerVC {
    func setUI() {
        [self.btnSearch, self.btnScan, self.btnFindRfid, self.btnTicket, self.btn1X, self.btnTourch, self.btnEndScan].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        }
        
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
        let vc = createView(storyboard: .scanevent, storyboardID: .FindRFIDVC)
        self.navigationController?.pushViewController(vc, animated: false)

    }
    
    func btnSearchAction() {
   
        let vc = createView(storyboard: .scanevent, storyboardID: .SearchVC)
        self.navigationController?.pushViewController(vc, animated: false)

        
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
    }
    
    func btnEndScanAction() {
        let vc = self.createView(storyboard: .scanevent, storyboardID: .EndScanPoPUpVC) as! EndScanPoPUpVC
        vc.delegate = self
        vc.strMsgForTitle = "End scan?"
        vc.strMsgForDescription = "Are you sure you want to scan for this event."
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
        self.present(vc, animated: true)
        
        
    }
    
}

//MARK: - AVCaptureMetadataOutputObjectsDelegate
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
    print(qrcode)

    }

}
//MARK: - AlertAction
extension ScannerVC: AlertAction {
    func alertYesaction() {
        let vc = createView(storyboard: .scanevent, storyboardID: .ScanSummaryVC)
         self.navigationController?.pushViewController(vc, animated: true)
    }
}
