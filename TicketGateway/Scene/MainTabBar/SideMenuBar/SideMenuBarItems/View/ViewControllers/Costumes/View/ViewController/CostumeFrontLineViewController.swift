//
//  CostumeFrontLineViewController.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 05/05/23.
//

import UIKit
import iOSDropDown

class CostumeFrontLineViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var costumeTypeCollectionView: CostumeTypeCollectionView!
    @IBOutlet weak var costumeTableView: CostumeListTableView!
    @IBOutlet weak var addOnTableView: UITableView!
    @IBOutlet weak var lblSelectSize: UILabel!
    @IBOutlet weak var btnSizeChart: UIButton!
   
    @IBOutlet weak var braBgView: UIView!
    @IBOutlet weak var lblBraSize: UILabel!
    @IBOutlet weak var btnBraSize: UIButton!
   
    @IBOutlet weak var cupBgView: UIView!
    @IBOutlet weak var lblCupSize: UILabel!
    @IBOutlet weak var btnCupSize: UIButton!
   
    @IBOutlet weak var waistBgView: UIView!
    @IBOutlet weak var lblWaistSize: UILabel!
    @IBOutlet weak var btnWaistSize: UIButton!
    
    @IBOutlet weak var bottomBgView: UIView!
    @IBOutlet weak var lblBottomSize: UILabel!
    @IBOutlet weak var btnBottomSize: UIButton!
    
    
    @IBOutlet weak var hipBgView: UIView!
    @IBOutlet weak var lblHipSize: UILabel!
    @IBOutlet weak var btnHipSize: UIButton!
    
    
    @IBOutlet weak var pantyBgView: UIView!
    @IBOutlet weak var lblPantySize: UILabel!
    @IBOutlet weak var btnPantySize: UIButton!
    
    @IBOutlet weak var beltBgView: UIView!
    @IBOutlet weak var lblBeltSize: UILabel!
    @IBOutlet weak var btnBeltSize: UIButton!
    
  
    @IBOutlet weak var lblAddOns: UILabel!
    @IBOutlet weak var lblPromoCode: UILabel!
    @IBOutlet weak var lblApplyPromo: UILabel!
    @IBOutlet weak var txtEnterPromo: UITextField!
    @IBOutlet weak var btnApply: UIButton!
  
    @IBOutlet weak var btnGoToCart: CustomButtonGradiant!
    @IBOutlet weak var selectSizeDottedLine: UIView!
    @IBOutlet weak var addOnDottedLine: UIView!
    @IBOutlet weak var promoCodeDottedLine: UIView!
    
    
    @IBOutlet weak var vwNavigationBar: NavigationBarView!
  
    var addOnTableData = ["Tshirt_ip", "Tshirt_ip", "Tshirt_ip", "Tshirt_ip"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [self.btnBraSize, self.btnCupSize, self.btnWaistSize, self.btnBottomSize, self.btnHipSize, self.btnPantySize, self.btnBeltSize].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
       // setTextFieldDropDown()
        costumeTypeCollectionView.configure()
        costumeTableView.configure()
        setTableView()
        costumeTableView.isScrollEnabled = false
        costumeTableView.isForDetailVC = "DetailVC"
        setFont()
        setNavigationBar()
        
        

       
    }
    
    func setTableView() {
        addOnTableView.delegate = self
        addOnTableView.dataSource = self
        addOnTableView.register(UINib(nibName: "AddOnTableViewCell", bundle: nil), forCellReuseIdentifier: "AddOnTableViewCell")
    }
    
    func setNavigationBar() {
        vwNavigationBar.lblTitle.text = "Costume Details"
        vwNavigationBar.delegateBarAction = self
        vwNavigationBar.btnBack.isHidden = false
    }
    
    @IBAction func actionGoToCart(_ sender: CustomButtonGradiant) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TheBandViewController") as! TheBandViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func setFont() {

        selectSizeDottedLine.createDottedLine(width: 2, color: UIColor.setColor(colorType: .BorderLineColour).cgColor, dashPattern: [8,4])
        addOnDottedLine.createDottedLine(width: 2, color: UIColor.setColor(colorType: .BorderLineColour).cgColor, dashPattern: [8,4])
        promoCodeDottedLine.createDottedLine(width: 2, color: UIColor.setColor(colorType: .BorderLineColour).cgColor, dashPattern: [8,4])
        lblSelectSize.font = UIFont.setFont(fontType: .semiBold, fontSize: .seventeen)
        lblSelectSize.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        btnSizeChart.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnSizeChart.titleLabel?.textColor = UIColor.setColor(colorType: .TGBlue)
        
        lblBraSize.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblBraSize.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblCupSize.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblCupSize.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblWaistSize.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblWaistSize.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblBottomSize.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblBottomSize.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblHipSize.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblHipSize.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblPantySize.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblPantySize.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblBeltSize.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblBeltSize.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblAddOns.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        lblAddOns.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        lblPromoCode.font = UIFont.setFont(fontType: .medium, fontSize: .eighteen)
        lblPromoCode.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        lblApplyPromo.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        lblApplyPromo.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        btnApply.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnApply.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        
        btnGoToCart.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnGoToCart.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        btnGoToCart.addLeftIcon(image: UIImage(named: "Cart_ip"))
       
       
        
    }
    
//    func setTextFieldDropDown() {
//        let txtFields = [txtBraSize, txtCupSize, txtWaistSize, txtBottomSize, txtHipSize, txtPantySize, txtBeltSize]
//        for txtField in txtFields {
//            txtField?.optionArray = ["S", "L", "M","XL","XXl"]
//
//            txtField?.optionIds = [1,23,54,22]
//
//            txtField?.didSelect{(selectedText , index ,id) in
//            txtField?.text = "Selected String: \(selectedText) \n index: \(index)"
//
//            }
//        }
//
//    }
    
   
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension CostumeFrontLineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addOnTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddOnTableViewCell", for: indexPath) as! AddOnTableViewCell
        let data = addOnTableData[indexPath.row]
        cell.imgImage.image = UIImage(named: data)
        cell.lblTitle.text = "T-shirt"
        cell.lblPrice.text = "$ 0.00"
     //   cell.txtSelect.delegate = self
//        cell.txtSelect.optionArray = ["Jan", "Feb", "Mar","April"]
//            cell.txtSelect.optionIds = [1,23,54,22]
//            cell.txtSelect.didSelect{(selectedText , index ,id) in
//                cell.txtSelect.text = "Selected String: \(selectedText) \n index: \(index)"
//
//              }
        
        return cell
        
    }
    
    @objc func dropDownBtn(sender: UIButton){
       let indexPath = IndexPath(row: sender.tag, section: 0)
       let cell = addOnTableView.cellForRow(at: indexPath) as! AddOnTableViewCell
      // cell.txtSelect.showList()
       }
    
    
    
}
//MARK: - NavigationBarViewDelegate
extension CostumeFrontLineViewController: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
    
    
}

//MARK: - Button Action
extension CostumeFrontLineViewController {

    @objc func buttonPressed(_ sender: UIButton)  {
        switch sender {
        case btnBraSize:
            self.braDropDwonAction()
        case btnCupSize:
            self.cupDropDwonAction()
        case btnWaistSize:
            self.waistDropDwonAction()
        case btnBottomSize:
            self.BottomDropDwonAction()
        case btnHipSize:
            self.hipDropDwonAction()
        case btnPantySize:
            self.pantyDropDwonAction()
        case btnBeltSize:
            self.beltDropDwonAction()

        default:
            break
        }

    }
     func braDropDwonAction() {
      //  txtBraSize.showList()
    }

     func cupDropDwonAction() {
      //  txtCupSize.showList()
    }

     func waistDropDwonAction() {
       // txtWaistSize.showList()
    }

     func BottomDropDwonAction() {
      //  txtBottomSize.showList()
    }

     func hipDropDwonAction() {
      //  txtHipSize.showList()
    }
     func pantyDropDwonAction() {
       // txtPantySize.showList()
    }

     func beltDropDwonAction() {
       // txtBeltSize.showList()
    }


}
