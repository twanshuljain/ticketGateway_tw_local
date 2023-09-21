//
//  ScanEventVC.swift
//  TicketGateway
//
//  Created by Apple on 16/06/23.
//

import UIKit
class ScanEventVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var lblScanTicket: UILabel!
    @IBOutlet weak var lblEnterDetails: UILabel!
    @IBOutlet weak var lblYourName: UILabel!
    @IBOutlet weak var txtYourName: UITextField!
    @IBOutlet weak var lblEnterPin: UILabel!
    @IBOutlet weak var txtEnterPin: UITextField!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var lblForMoreInfo: UILabel!
    @IBOutlet weak var btnHere: UIButton!
    @IBOutlet weak var btnDissMiss: UIButton!
    @IBOutlet weak var btnSecurePassword: UIButton!
    // MARK: - Variable
    let viewModel = ScanEventViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFont()
        self.setUI()
    }
}
// MARK: - setFont
extension ScanEventVC {
    func setFont() {
        self.lblScanTicket.font = UIFont.setFont(fontType: .bold, fontSize: .twentyFour)
        self.lblScanTicket.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblEnterDetails.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblEnterDetails.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblYourName.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblYourName.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.txtYourName.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.txtYourName.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblEnterPin.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblEnterPin.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.txtEnterPin.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.txtEnterPin.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.btnContinue.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnContinue.titleLabel?.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        self.btnHere.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnHere.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlue)
        self.lblForMoreInfo.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblForMoreInfo.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
}
// MARK: - Instance Method
extension ScanEventVC {
    func setUI() {
        [self.btnContinue, self.btnHere, self.btnDissMiss, self.btnSecurePassword].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        }
    }
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        case btnHere:
            self.btnHereAction()
        case btnDissMiss:
            self.btnDissmissAction()
        case btnSecurePassword:
            self.btnSecurePasswordAction()
        default:
            break
        }
    }
    func btnContinueAction() {
        viewModel.scanTicketModel.name = txtYourName.text?.trimmingCharacters(in: .whitespaces) ?? "-"
        viewModel.scanTicketModel.scanPin = txtEnterPin.text?.trimmingCharacters(in: .whitespaces) ?? "-"
        if viewModel.scanTicketModel.name.isEmpty {
            self.showToast(message: Name_Not_Nil)
            return
        } else if viewModel.scanTicketModel.scanPin.isEmpty {
            self.showToast(message: Pin_Not_Nil)
            return
        }
        scanTicketLogin()
    }
    func btnHereAction() {
    }
    func btnDissmissAction() {
        self.navigationController?.popViewController(animated: true)
    }
    func btnSecurePasswordAction() {
        if self.txtEnterPin.isSecureTextEntry == false {
            self.btnSecurePassword.setImage(UIImage(named: EYE_CLOSE), for: .normal)
            self.txtEnterPin.isSecureTextEntry = true
        } else {
            self.btnSecurePassword.setImage(UIImage(named: EYE_OPEN), for: .normal)
            self.txtEnterPin.isSecureTextEntry = false
        }
    }
    func scanTicketLogin() {
        if Reachability.isConnectedToNetwork() { // check internet connectivity
            self.view.showLoading(centreToView: self.view)
            viewModel.scanTicketApi(
                scanTicketModel: viewModel.scanTicketModel,
                complition: { isTrue, showMessage in
                    if isTrue {
                        DispatchQueue.main.async {
                            self.view.stopLoading()
                            let selectTicketTypeVC = self.createView(storyboard: .scanevent, storyboardID: .SelectTicketTypeVC) as? SelectTicketTypeVC
                            self.viewModel.getScanTicketDetails.name = self.txtYourName.text ?? "-"
                            selectTicketTypeVC?.viewModel.getScanTicketDetails = self.viewModel.getScanTicketDetails
                            self.navigationController?.pushViewController(selectTicketTypeVC ?? UIViewController(), animated: true)
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
