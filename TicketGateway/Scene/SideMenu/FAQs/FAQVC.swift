//
//  FAQVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 30/05/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable cyclomatic_complexity
// swiftlint: disable shorthand_operator
// swiftlint: disable type_name
import UIKit
import SideMenu

class arrdata {
    var queValue:String
    var ansValue: String
    var isExpand:Bool
    init(queValue: String, isExpand: Bool, ansValue: String)
    {
        self.queValue = queValue
        self.isExpand = isExpand
        self.ansValue = ansValue
    }
    
}

class FAQVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var vwNavigatioView: NavigationBarView!
    @IBOutlet weak var vwSegmentBackgroundView: UIView!
    @IBOutlet weak var faqTableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    // MARK: -  Variables
    let arrDataValues = [arrdata(queValue: "What’s needed to get started on TicketGetway?", isExpand: false, ansValue: "Lorem ipsum dolor sit amet consectetur. Egestas sit fringilla faucibus cursus nunc. Ut sit dis proin nullam mi viverra vel euismod. Ultrices nunc nec porttitor amet velit turpis facilisis nunc. Pellentesque sed vitae ut purus semper cras eu mauris integer. Faucibus enim vitae interdum est tortor purus eu porta. Nunc aliquet eu purus gravida aliquet lacinia enim nec hendrerit. Eget tortor non sed ullamcorper eleifend lorem nulla velit quisque. Viverra sed non et tellus placerat. Vitae ornare et mattis et."),
                         arrdata(queValue: "How do I find my tickets?", isExpand: false, ansValue: "ghdfuhguhgjdgbhjgg"),
                         arrdata(queValue: "Can I get a refund?", isExpand: false, ansValue: "fggughghghbvgyeruerer"),
                         arrdata(queValue: "Is this event I’m attending cancelled", isExpand: false, ansValue: "bfytertyvdfhgjg"),
                         arrdata(queValue: "Can I change the name on my ticket?", isExpand: false, ansValue: "jghgrtgujnnb")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.vwSegmentBackgroundView.addBottomShadow()
        self.setTableView()
        
    }
}

// MARK: - Functions
extension FAQVC {
    func setNavigationBar() {
        self.vwNavigatioView.lblTitle.text = FAQS
        self.vwNavigatioView.delegateBarAction = self
        self.vwNavigatioView.imgBack.image = UIImage(named: MENU_ICON)
        self.vwNavigatioView.btnBack.isHidden = false
        self.vwNavigatioView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.vwNavigatioView.lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
    }
    
    func setTableView() {
        self.faqTableView.delegate = self
        self.faqTableView.dataSource = self
        self.faqTableView.separatorColor = UIColor.clear
        faqTableView.register(UINib(nibName: "FAQTableviewCell", bundle: nil), forCellReuseIdentifier: "FAQTableviewCell")
    }
}

// MARK: - Actions
extension FAQVC {
    @IBAction private func actionSegment(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0 :
            self.faqTableView.reloadData()
        case 1:
            self.faqTableView.reloadData()
        default:
            break
        }
    }
    
    @objc func buttonPressed(sender: UIButton) {
        print("......",sender.tag)
        let indexPath = IndexPath(row: sender.tag, section: 0)
        print("....",indexPath)
        let cell = self.faqTableView.cellForRow(at: indexPath) as! FAQTableviewCell
        
        
        print("....",cell)
        let obj = arrDataValues[indexPath.row]
        if obj.isExpand == false {
            obj.isExpand = true
            
        } else {
            obj.isExpand = false
        }
        self.faqTableView.layoutIfNeeded()
        self.faqTableView.reloadData()
        self.faqTableView.layoutIfNeeded()
    }
    
}


// MARK: - UITableViewDelegate,UITableViewDataSource
extension FAQVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDataValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQTableviewCell", for: indexPath) as! FAQTableviewCell
        let obj = arrDataValues[indexPath.row]
        cell.lblQuestion.text = obj.queValue
        
        cell.btnUp.tag = indexPath.row
        cell.btnUp.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        if obj.isExpand == true {
            let gradient = getGradientLayer(bounds: view.bounds)
            cell.lblQuestion.textColor = gradientColor(bounds: view.bounds, gradientLayer: gradient)
           
            cell.btnUp.setImage(UIImage(named: CHEVRON_UP_GD_ICON), for: .normal)
            let height = cell.bgView.bounds.height
            print("......................................", height)
            cell.lblAnswer.text = obj.ansValue
            cell.bgView.layoutIfNeeded()
        } else {
            cell.lblAnswer.text = ""
            cell.btnUp.setImage(UIImage(named: CHEVRON_DOWN_DB_ICON), for: .normal)
            cell.bgView.borderColor = UIColor.setColor(colorType: .borderLineColour)
            cell.lblQuestion.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
            cell.bgView.layoutIfNeeded()
            
        }
        return cell
    }
}



// MARK: - NavigationBarViewDelegate
extension FAQVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
}
