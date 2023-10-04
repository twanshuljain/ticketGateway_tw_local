//
//  CostumeFrontLineViewController.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 05/05/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count

import UIKit
import iOSDropDown

class CostumeFrontLineViewController: UIViewController, UITextFieldDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var costumeTypeCollectionView: CostumeTypeCollectionView!
    @IBOutlet weak var costumeTableView: CostumeListTableView!
    @IBOutlet weak var addOnTableView: UITableView!
    @IBOutlet weak var lblSelectSize: UILabel!
    @IBOutlet weak var btnSizeChart: UIButton!

    @IBOutlet weak var braBgView: UIView!
    @IBOutlet weak var lblBraSize: UILabel!
    @IBOutlet weak var btnBraSize: UIButton!
    @IBOutlet weak var txtBraSize: DropDown!

    @IBOutlet weak var cupBgView: UIView!
    @IBOutlet weak var lblCupSize: UILabel!
    @IBOutlet weak var btnCupSize: UIButton!
    @IBOutlet weak var txtCupSize: DropDown!

    @IBOutlet weak var waistBgView: UIView!
    @IBOutlet weak var lblWaistSize: UILabel!
    @IBOutlet weak var btnWaistSize: UIButton!
    @IBOutlet weak var txtWaistSize: DropDown!

    @IBOutlet weak var bottomBgView: UIView!
    @IBOutlet weak var lblBottomSize: UILabel!
    @IBOutlet weak var btnBottomSize: UIButton!
    @IBOutlet weak var txtBottomSize: DropDown!

    @IBOutlet weak var hipBgView: UIView!
    @IBOutlet weak var lblHipSize: UILabel!
    @IBOutlet weak var btnHipSize: UIButton!
    @IBOutlet weak var txtHipSize: DropDown!

    @IBOutlet weak var pantyBgView: UIView!
    @IBOutlet weak var lblPantySize: UILabel!
    @IBOutlet weak var btnPantySize: UIButton!
    @IBOutlet weak var txtPantySize: DropDown!

    @IBOutlet weak var beltBgView: UIView!
    @IBOutlet weak var lblBeltSize: UILabel!
    @IBOutlet weak var btnBeltSize: UIButton!
    @IBOutlet weak var txtBeltSize: DropDown!

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

    // MARK: - Variables
    var addOnTableData = ["Tshirt_ip", "Tshirt_ip", "Tshirt_ip", "Tshirt_ip"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.setUI()
        self.setTextFieldDropDown()
        self.setTableView()
        self.setFont()
        self.setCollectionView()
    }
}

// MARK: - Functions
extension CostumeFrontLineViewController {
    func setCollectionView() {
        self.costumeTypeCollectionView.configure()
        self.costumeTableView.configure(vc: self)
        self.costumeTableView.isScrollEnabled = false
        self.costumeTableView.isForDetailVC = "FrontLineVC"
    }

    func setTableView() {
        self.addOnTableView.separatorColor = UIColor.clear
        self.addOnTableView.delegate = self
        self.addOnTableView.dataSource = self
        self.addOnTableView.register(UINib(nibName: "AddOnTableViewCell", bundle: nil), forCellReuseIdentifier: "AddOnTableViewCell")
    }

    func setNavigationBar() {
        self.vwNavigationBar.lblTitle.text = COSTUME_DETAILS
        self.vwNavigationBar.delegateBarAction = self
        self.vwNavigationBar.btnBack.isHidden = false
        self.vwNavigationBar.vwBorder.isHidden = false

    }
    func setFont() {
        self.selectSizeDottedLine.createDottedLine(width: 2, color: UIColor.setColor(colorType: .borderLineColour).cgColor, dashPattern: [8,4])
        self.addOnDottedLine.createDottedLine(width: 2, color: UIColor.setColor(colorType: .borderLineColour).cgColor, dashPattern: [8,4])
        self.promoCodeDottedLine.createDottedLine(width: 2, color: UIColor.setColor(colorType: .borderLineColour).cgColor, dashPattern: [8,4])
        self.lblSelectSize.font = UIFont.setFont(fontType: .semiBold, fontSize: .seventeen)
        self.lblSelectSize.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)

        self.btnSizeChart.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSizeChart.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlue)
        self.lblBraSize.text = BRA_SIZE
        self.lblBraSize.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblBraSize.textColor = UIColor.setColor(colorType: .lblTextPara)

        self.lblCupSize.text = CUP_SIZE
        self.lblCupSize.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblCupSize.textColor = UIColor.setColor(colorType: .lblTextPara)

        self.lblWaistSize.text = WAIST_SIZE
        self.lblWaistSize.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblWaistSize.textColor = UIColor.setColor(colorType: .lblTextPara)

        self.lblBottomSize.text = BOTTOM_SIZE
        self.lblBottomSize.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblBottomSize.textColor = UIColor.setColor(colorType: .lblTextPara)

        self.lblHipSize.text = HIP_SIZE
        self.lblHipSize.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblHipSize.textColor = UIColor.setColor(colorType: .lblTextPara)

        self.lblPantySize.text = PANTY_SIZE
        self.lblPantySize.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblPantySize.textColor = UIColor.setColor(colorType: .lblTextPara)

        self.lblBeltSize.text = BELT_SIZE
        self.lblBeltSize.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblBeltSize.textColor = UIColor.setColor(colorType: .lblTextPara)

        self.lblAddOns.text = ADD_ONS
        self.lblAddOns.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblAddOns.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)

        self.lblPromoCode.text = PROMO_CODE
        self.lblPromoCode.font = UIFont.setFont(fontType: .medium, fontSize: .eighteen)
        self.lblPromoCode.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)

        self.lblApplyPromo.text = APPLY_PROMO
        self.lblApplyPromo.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblApplyPromo.textColor = UIColor.setColor(colorType: .lblTextPara)

        self.btnApply.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnApply.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)

        self.btnGoToCart.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnGoToCart.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        self.btnGoToCart.addLeftIcon(image: UIImage(named: CART_ICON))
    }

    func setTextFieldDropDown() {
        let txtFields = [txtBraSize, txtCupSize, txtWaistSize, txtBottomSize, txtHipSize, txtPantySize, txtBeltSize]
        for txtField in txtFields {
            txtField?.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
            txtField?.textColor = UIColor.setColor(colorType: .tgBlue)
            txtField?.optionArray = ["S", "L", "M","XL","XXl"]

            txtField?.optionIds = [1,23,54,22]

            txtField?.didSelect{(selectedText , index ,id) in
                txtField?.text = "\(selectedText)"

            }
        }

    }
    func setUI() {
        [self.btnBraSize, self.btnCupSize, self.btnWaistSize, self.btnBottomSize, self.btnHipSize, self.btnPantySize, self.btnBeltSize].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
    }

}

// MARK: - Actions
extension CostumeFrontLineViewController {

    @IBAction func actionGoToCart(_ sender: CustomButtonGradiant) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CostumeCartViewController") as! CostumeCartViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }

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
        self.txtBraSize.showList()
    }

    func cupDropDwonAction() {
        self.txtCupSize.showList()
    }

    func waistDropDwonAction() {
        self.txtWaistSize.showList()
    }

    func BottomDropDwonAction() {
        self.txtBottomSize.showList()
    }

    func hipDropDwonAction() {
        self.txtHipSize.showList()
    }
    func pantyDropDwonAction() {
        self.txtPantySize.showList()
    }

    func beltDropDwonAction() {
        self.txtBeltSize.showList()
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
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
         return cell
    }

}

// MARK: - CostumeTableViewCellProtocol
extension CostumeFrontLineViewController:CostumeTableViewCellProtocol{
    func didTapOnFrontLine(sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BandLeaderProfileViewController") as! BandLeaderProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - NavigationBarViewDelegate
extension CostumeFrontLineViewController: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
}
