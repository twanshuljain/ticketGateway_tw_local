//
//  AttendeeDetailsVC.swift
//  TicketGateway
//
//  Created by Apple on 26/06/23.
//

import UIKit

class AttendeeDetailsVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var lblAttendee: UILabel!
    @IBOutlet weak var lblAttendeeName: UILabel!
    @IBOutlet weak var lblAttendeeEmail: UILabel!
    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var lblOrderNoValue: UILabel!
    @IBOutlet weak var lblDeliveryMethod: UILabel!
    @IBOutlet weak var lblDeliveryMethodValue: UILabel!
    @IBOutlet weak var lblTicketType: UILabel!
    @IBOutlet weak var lblTicketTypeValue: UILabel!
    @IBOutlet weak var checkedInStackView: UIStackView!
    @IBOutlet weak var lblCheckedIn: UILabel!
    @IBOutlet weak var lblCheckedInValue: UILabel!
    @IBOutlet weak var lblBarcode: UILabel!
    @IBOutlet weak var lblBarcodeValue: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var txtNotes: UITextView!
    @IBOutlet weak var btnCheckIn: CustomButtonGradiant!
    
    //MARK: - Variables
    let viewModel = AttendeeDetailViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.setFont()
        
    }
    

    
}

//MARK: -
extension AttendeeDetailsVC {
    
    func setNavigationBar() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = "Attendee Details"
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
    }
    
    func setFont() {
        if viewModel.isCheckedIn {
            self.checkedInStackView.isHidden = false
            self.btnCheckIn.setTitle("Checked In", for: .normal)
            self.btnCheckIn.addLeftIcon(image: UIImage(named: "check-circle"))
            self.btnCheckIn.backgroundColor = UIColor.setColor(colorType: .TGYellow)
            
        } else {
            self.btnCheckIn.setTitle("Check In", for: .normal)
            self.checkedInStackView.isHidden = true
        }
        
        let lbls = [lblAttendee, lblAttendeeEmail, lblOrderNo, lblTicketType, lblDeliveryMethod, lblBarcode, lblNotes, lblCheckedIn]
        for lbl in lbls {
            lbl?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            lbl?.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
        self.lblOrderNoValue.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblOrderNoValue.textColor = UIColor.setColor(colorType: .TGBlue)
        
        self.lblAttendeeName.font = UIFont.setFont(fontType: .semiBold, fontSize: .eighteen)
        self.lblAttendeeName.textColor = UIColor.setColor(colorType: .TGBlack)
        
        let valueLbls = [lblDeliveryMethodValue, lblTicketTypeValue, lblBarcodeValue, lblCheckedInValue]
        for valueLbl in valueLbls {
            valueLbl?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            valueLbl?.textColor = UIColor.setColor(colorType: .TGBlack)
        }
        
        self.txtNotes.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.txtNotes.textColor = UIColor.setColor(colorType: .TGBlack)
        
        
        self.btnCheckIn.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnCheckIn.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        
    }
    
}


//MARK: - NavigationBarViewDelegate
extension AttendeeDetailsVC: NavigationBarViewDelegate ,UITextFieldDelegate{
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
