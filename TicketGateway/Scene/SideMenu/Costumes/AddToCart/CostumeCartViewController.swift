//
//  CostumeCartViewController.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 08/05/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disbale identifier_name
// swiftlint: disbalefunction_parameter_count

import UIKit


class InstallmentInfo {
    var isExpanded : Bool
    
    init(isExpanded:Bool){
        self.isExpanded = isExpanded
        
    }
}

class ExpandableCells {
    var isExpanded : Bool
    var data: [InstallmentInfo]
    init(data: [InstallmentInfo],isExpanded:Bool) {
        self.isExpanded = isExpanded
        self.data = data
    }
}

class CostumeCartViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var bgBandView: UIView!
    @IBOutlet weak var lblJouvertRepublic: UILabel!
    @IBOutlet weak var lblFrontline: UILabel!
    @IBOutlet weak var lblOnlyFewLeft: UILabel!
    @IBOutlet weak var bgFewLeft: UIView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var txtNotes: UITextView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var bgFirstName: UIView!
    @IBOutlet weak var bgLastName: UIView!
    @IBOutlet weak var bgNotes: UIView!
    @IBOutlet weak var paymentTableView: UITableView!
    @IBOutlet weak var lblChoosePaymentMode: UILabel!
    @IBOutlet weak var vwNavigationBar: NavigationBarView!
    @IBOutlet weak var tbleViewHeight: NSLayoutConstraint!
    
    // MARK: - Variables
    var arrData: [ExpandableCells] = []
    var isPartialSelected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        configure()
        vwNavigationBar.lblTitle.text = THE_BAND_TRINI_REVELLARS
        vwNavigationBar.delegateBarAction = self
        vwNavigationBar.btnBack.isHidden = false
        vwNavigationBar.vwBorder.isHidden = false

        self.arrData.removeAll()
        isPartialSelected = false
        let arrExpan = [InstallmentInfo]()
        arrData = [ExpandableCells( data: arrExpan, isExpanded: false)]
        self.view.layoutIfNeeded()
        self.paymentTableView.reloadData()
        self.paymentTableView.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
            self.tbleViewHeight.constant = self.paymentTableView.contentSize.height
       // self.paymentTableView.contentInsetAdjustmentBehavior = .never

    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.tbleViewHeight.constant = paymentTableView.contentSize.height
      }
}


//MARK: - Functions
extension CostumeCartViewController{
    func setUI() {
        lblJouvertRepublic.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        lblJouvertRepublic.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        lblFrontline.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        lblFrontline.textColor = UIColor.setColor(colorType: .headinglbl)
        lblOnlyFewLeft.font = UIFont.setFont(fontType: .regular, fontSize: .ten)
        lblOnlyFewLeft.textColor = UIColor.red
        lblPrice.font = UIFont.setFont(fontType: .medium, fontSize: .eighteen)
        lblPrice.textColor = UIColor.setColor(colorType: .lightBlack)
        lblTax.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblTax.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblSize.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblSize.textColor = UIColor.setColor(colorType: .lightBlack)
        lblFirstName.text = FIRST_NAME
        lblFirstName.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblFirstName.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblLastName.text = LAST_NAME
        lblLastName.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblLastName.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblNotes.text = NOTES
        lblNotes.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblNotes.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblChoosePaymentMode.text = Choose_Payment_Mode
        lblChoosePaymentMode.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblChoosePaymentMode.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .white) ], for: .selected)
        self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .segmentColor) ], for: .normal)

        
        }
    
    func configure() {
        paymentTableView.delegate = self
        paymentTableView.dataSource = self
        paymentTableView.register(UINib(nibName: "DepositeTableViewCell", bundle: nil), forCellReuseIdentifier: "DepositeTableViewCell")
        paymentTableView.register(UINib(nibName: "OrderDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderDetailTableViewCell")
        paymentTableView.register(UINib(nibName: "InstallmentHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "InstallmentHeaderView")
        paymentTableView.register(UINib(nibName: "InstallmentTableViewCell", bundle: nil), forCellReuseIdentifier: "InstallmentTableViewCell")
     //   paymentTableView.reloadData()
        
    }
    
}

//MARK: - Actions
extension CostumeCartViewController{
    @objc func buttonPressed(_ sender: UIButton) {
        
        if sender.tag != 0 || sender.tag != arrData.count - 1 {
        let obj = arrData[sender.tag]
        if obj.isExpanded == false
        {
            obj.isExpanded = true
        } else {
            obj.isExpanded = false
        }
        self.paymentTableView.reloadData()
        }
        
    }
    
    @IBAction func actionSegmentControl(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            self.segmentControl.setTitleTextAttributes([.font: UIFont.setFont(fontType: .regular, fontSize:.twelve)], for: .normal)
            self.segmentControl.setTitleTextAttributes([.font: UIFont.setFont(fontType: .regular, fontSize:.twelve)], for: .selected)
            self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .segmentColor) ], for: .normal)
            self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .white) ], for: .selected)
            self.arrData.removeAll()
            self.paymentTableView.layoutIfNeeded()
            isPartialSelected = false
            let arrExpan = [InstallmentInfo]()
            arrData = [ExpandableCells( data: arrExpan, isExpanded: false)]
            self.paymentTableView.layoutIfNeeded()
            self.paymentTableView.reloadData()
            //  self.paymentTableView.layoutIfNeeded()
            
            
        case 1:
            self.segmentControl.setTitleTextAttributes([.font: UIFont.setFont(fontType: .regular, fontSize:.twelve)], for: .normal)
            self.segmentControl.setTitleTextAttributes([.font: UIFont.setFont(fontType: .regular, fontSize:.twelve)], for: .selected)
            self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .segmentColor) ], for: .normal)
            self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.setColor(colorType: .white) ], for: .selected)
            self.arrData.removeAll()
            self.paymentTableView.layoutIfNeeded()
            isPartialSelected = true
            let arrExpan = [InstallmentInfo]()
            arrData = [ExpandableCells( data: arrExpan, isExpanded: false),
                       ExpandableCells( data:[InstallmentInfo(isExpanded : false),InstallmentInfo(isExpanded : false), InstallmentInfo(isExpanded: false)], isExpanded: false),
                       
                       ExpandableCells( data:[InstallmentInfo(isExpanded : false),InstallmentInfo(isExpanded : false), InstallmentInfo(isExpanded: false)], isExpanded: false),
                       ExpandableCells( data:[InstallmentInfo(isExpanded : false),InstallmentInfo(isExpanded : false), InstallmentInfo(isExpanded: false)], isExpanded: false),
                       ExpandableCells( data: arrExpan, isExpanded: false)]
            
            self.paymentTableView.reloadData()
            
        default:
            break
        }
    }
    
}

//MARK: -  UITableViewDelegate, UITableViewDataSource
extension CostumeCartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrData.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == arrData.count-1 {
            return 1
        } else {
             if arrData[section].isExpanded == false
            {
                 return 0
            } else {
                return arrData[section].data.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if isPartialSelected == true {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DepositeTableViewCell", for: indexPath) as! DepositeTableViewCell
                return cell
                
            } else if indexPath.section == arrData.count-1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailTableViewCell", for: indexPath) as!
                OrderDetailTableViewCell
                cell.btnContinue.addTarget(self, action: #selector(btncontinue(sender:)), for: .touchUpInside)
                cell.lblDescription.isHidden = true
                return cell
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "InstallmentTableViewCell", for: indexPath) as! InstallmentTableViewCell
                
                return cell
            }
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailTableViewCell", for: indexPath) as!
            OrderDetailTableViewCell
            cell.lblDescription.isHidden = false
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "InstallmentHeaderView") as! InstallmentHeaderView
        headerView.contentView.backgroundColor = UIColor.white
        headerView.btnSelected.tag = section
        headerView.btnSelected.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let obj = arrData[section]
        if obj.isExpanded == true {
             headerView.btnSelected.setImage(UIImage(named: RADIO_SELECTION_ICON), for: .normal)
            headerView.btnAdd.setImage(UIImage(named: REMOVE_ICON), for: .normal)
            headerView.bgView.borderColor = UIColor.setColor(colorType: .tgBlue)
        } else {
            headerView.btnSelected.setImage(UIImage(named: UNSELECTED_ICON), for: .normal)
            headerView.btnAdd.setImage(UIImage(named: ADD_ICON), for: .normal)//Remov_ip
            headerView.bgView.borderColor = UIColor.setColor(colorType: .borderLineColour)

        }
        return headerView
      
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isPartialSelected == false {
            print("SECTION",section)
            return 0
        } else {
        if section == 0 {
            print("SECTION 0",section)
            return 0
        }  else if arrData.count-1 == section
        {
            print("SECTION LAst",section)
            return 0
        } else {
            print("SECTION ", section)
            return 70
            
        }
        }
    }
    
    @objc func btncontinue(sender:UIButton)
    {
        let view = self.createView(storyboard: .main, storyboardID: .PhoneVerificationViewController) as? PhoneVerificationViewController
        self.navigationController?.pushViewController(view!, animated: true)
        
        //let view = self.createView(storyboard: .home, storyboardID: .EventBookingPaymentMethodVC) as? EventBookingPaymentMethodVC
        //self.navigationController?.pushViewController(view!, animated: true)
        
    }
   
}
//MARK: - NavigationBarViewDelegate
extension CostumeCartViewController: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
