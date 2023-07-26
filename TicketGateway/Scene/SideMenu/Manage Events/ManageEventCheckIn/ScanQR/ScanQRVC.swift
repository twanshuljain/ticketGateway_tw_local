//
//  ScanQRVC.swift
//  TicketGateway
//
//  Created by Apple on 28/06/23.
// swiftlint: disable force_cast
// swiftlint: disable line_length
import UIKit
import AVFoundation
class ScanQRVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var vwNavigationView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnFlash: UIButton!
    @IBOutlet weak var lblScanTGQR: UILabel!
    @IBOutlet weak var scanQRView: UIView!
    @IBOutlet weak var lblPleaseAlignQR: UILabel!
    @IBOutlet weak var btnScanWithImage: CustomButtonNormal!
    @IBOutlet weak var bgScanQRView: UIView!
   // MARK: - Variables
    let viewModel = ScanQRModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.setFont()
        self.getCameraPreview()
        // self.createScanningIndicator()
        self.setUI()
    }
}
// MARK: -
extension ScanQRVC {
    func setNavigationBar() {
        self.lblScanTGQR.text = SCAN_TG_QR
        self.lblScanTGQR.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblScanTGQR.textColor = UIColor.setColor(colorType: .white)
    }
    func setFont() {
        self.lblPleaseAlignQR.text = PLEASE_ALIGN_QR
        self.lblPleaseAlignQR.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblPleaseAlignQR.textColor = UIColor.setColor(colorType: .tgBlue)
        self.btnScanWithImage.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnScanWithImage.titleLabel?.textColor = UIColor.setColor(colorType: .white)
        self.btnScanWithImage.addLeftIcon(image: UIImage(named: IMAGE_ICON_))
    }
    func getCameraPreview() {
        viewModel.captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        if viewModel.captureSession.canAddInput(videoInput) {
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
        viewModel.previewLayer.frame = scanQRView.layer.bounds
        viewModel.previewLayer.videoGravity = .resizeAspectFill
        scanQRView.layer.addSublayer(viewModel.previewLayer)
        DispatchQueue.global(qos: .background).async {
            self.viewModel.captureSession.startRunning()
        }
    }
    func createScanningIndicator() {
        let height: CGFloat = 15
        let opacity: Float = 0.4
        let topColor = UIColor.setColor(colorType: .tgBlue).withAlphaComponent(0)
        let bottomColor = UIColor.setColor(colorType: .tgBlue)
        let layer = CAGradientLayer()
        layer.colors = [topColor.cgColor, bottomColor.cgColor]
        layer.opacity = opacity
        let squareWidth = bgScanQRView.frame.width * 0.6
        let xOffset = bgScanQRView.frame.width * 0.2
        let yOffset = bgScanQRView.frame.midY - (squareWidth / 2)
        layer.frame = CGRect(x: xOffset, y: yOffset, width: squareWidth, height: height)
        self.bgScanQRView.layer.insertSublayer(layer, at: 0)
        let initialYPosition = layer.position.y
        let finalYPosition = initialYPosition + squareWidth - height
        let duration: CFTimeInterval = 2
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = initialYPosition as NSNumber
        animation.toValue = finalYPosition as NSNumber
        animation.duration = duration
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        layer.add(animation, forKey: nil)
    }
}
// MARK: - Instance Method
extension ScanQRVC {
    func setUI () {
        [btnBack, btnFlash, btnScanWithImage].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
        }
    }
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnBack:
            self.btnBackAction()
        case btnFlash:
            self.btnFlashAction()
        case btnScanWithImage:
            ImagePickerManager().openGallery(viewController: self)
        default:
            break
        }
    }
    func btnBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    func btnFlashAction() {
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
}
// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension ScanQRVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        viewModel.captureSession.stopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let codeString = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.receivedCode(qrcode: codeString)
        }
    }
    func receivedCode(qrcode: String) {
        print(qrcode)
        let view = createView(storyboard: .manageevent, storyboardID: .AttendeeDetailsVC) as! AttendeeDetailsVC
        self.navigationController?.pushViewController(view, animated: true)
    }
}
