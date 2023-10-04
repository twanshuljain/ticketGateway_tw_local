//
//  CostumeTableViewCell.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 03/05/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disbale identifier_name
// swiftlint: disbalefunction_parameter_count

import UIKit
import SwiftUI
import AdvancedPageControl


protocol CostumeTableViewCellProtocol {
    func didTapOnFrontLine(sender:UIButton)
    func didSelect(index:IndexPath)
}

extension CostumeTableViewCellProtocol {
    func didTapOnFrontLine(sender:UIButton) {}
    func didSelect(index:IndexPath) {}
}

class CostumeTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnFrontLine: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var collectionViewCostume: UICollectionView!
    @IBOutlet weak var lblPrice: UILabel!
   
    @IBOutlet weak var lblFlexiblePayment: UILabel!
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var vwLikeShare: UIView!
    
    @IBOutlet weak var vwGradientView: GradientView!
    @IBOutlet weak var lblDescription: UILabel!
   
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var imagePageController: AdvancedPageControlView!
    @IBOutlet weak var htImagePageController: NSLayoutConstraint!

    @IBOutlet weak var htRegisterBtn:NSLayoutConstraint!
    
    let imgCollectionData = ["costume_ip", "costume_ip", "costume_ip", "costume_ip"]
    var delegate:CostumeTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setFont()
        self.setCollectionView()
        toSetPageControll()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setData(costumeObj:UIViewController?, isForDetailVC:String?) {
        //cell.imgCostumeImage.image = UIImage(named: data)
        self.lblTitle.text = "  Jouvert Republic 2023"
        self.btnFrontLine.titleLabel?.text = "Frontline | Trini Revellers "
        self.lblDate.text = "Jan 19 to Feb 19, 2023"
        self.lblTime.text = "5:00 PM - 11:00 PM "
        self.lblPrice.text = "$250 - $500"
        self.lblFlexiblePayment.text = "Flexible Payment available "
        if isForDetailVC == "DetailVC" {
            self.backgroundColor = UIColor.setColor(colorType: .white)
            self.btnRegister.isHidden = true
            self.htRegisterBtn.constant = 0
           // self.vwLikeShare.isHidden = false
           // self.lblDescription.isHidden = false
            self.vwGradientView.startColor =  .white
            self.vwGradientView.endColor = .white
            self.htImagePageController.constant = 20
            self.collectionViewCostume.isScrollEnabled = true
            if let costumeObj = costumeObj as? CostumeDetailViewController{
                self.delegate = costumeObj
            }
        }else if isForDetailVC == "FrontLineVC"{
            self.backgroundColor = UIColor.setColor(colorType: .white)
            self.btnRegister.isHidden = true
            self.htRegisterBtn.constant = 0
           // self.vwLikeShare.isHidden = false
           // self.lblDescription.isHidden = false
            self.vwGradientView.startColor =  .white
            self.vwGradientView.endColor = .white
            self.htImagePageController.constant = 20
            self.collectionViewCostume.isScrollEnabled = true
            if let costumeObj = costumeObj as? CostumeFrontLineViewController{
                self.delegate = costumeObj
            }
        } else {
            if let costumeObj = costumeObj as? CostumeViewController{
                self.delegate = costumeObj
            }
            self.backgroundColor = UIColor.setColor(colorType: .bgPurpleColor)
            self.btnRegister.isHidden = false
            self.htRegisterBtn.constant = 48
            self.collectionViewCostume.isScrollEnabled = false
            self.htImagePageController.constant = 0
            //self.vwLikeShare.isHidden = false
            //self.lblDescription.isHidden = false
           // self.vwGradientView.startColor =  .white
           // self.vwGradientView.endColor = .white
        }
    }
    
    func setCollectionView() {
        collectionViewCostume.delegate = self
        collectionViewCostume.dataSource = self
        collectionViewCostume.backgroundColor = UIColor.setColor(colorType: .bgPurpleColor)
        self.collectionViewCostume.register(UINib(nibName: "CostumeImageCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CostumeImageCollectionViewCell")
        //
    }
    
    func setFont() {
        lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        btnFrontLine.titleLabel?.font = UIFont.setFont(fontType: .light, fontSize: .twelve)
        btnFrontLine.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlue)
        lblDate.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        lblDate.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblTime.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        lblTime.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblPrice.font = UIFont.setFont(fontType: .medium, fontSize: .eighteen)
        lblFlexiblePayment.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblFlexiblePayment.textColor = UIColor.setColor(colorType: .tgBlack)
        btnRegister.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnRegister.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        btnRegister.backgroundColor = UIColor.setColor(colorType: .white)
        lblDescription.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblDescription.textColor = UIColor.setColor(colorType: .lblTextPara)
        btnLike.addTarget(self, action: #selector(btnImage(sender:)), for:  .touchUpInside)
        btnFrontLine.addTarget(self, action: #selector(btnFrontLine(sender:)), for:  .touchUpInside)
    }
    
    @objc func btnImage(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            btnLike.setImage(UIImage(named: LIKE_ICON), for: .selected)

        } else {
            btnLike.setImage(UIImage(named: FAV_UNSELECT_ICON), for: .normal)

        }
    }
    
    @objc func btnFrontLine(sender: UIButton) {
        self.delegate?.didTapOnFrontLine(sender: sender)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout
extension CostumeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imgCollectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CostumeImageCollectionViewCell", for: indexPath) as! CostumeImageCollectionViewCell
        let data = imgCollectionData[indexPath.row]
        cell.imgImage.image = UIImage(named: data)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected")
        self.delegate?.didSelect(index: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - PageController
extension CostumeTableViewCell {
    func toSetPageControll() {
        imagePageController.drawer = ExtendedDotDrawer(numberOfPages: self.imgCollectionData.count,
                                                       space: 16.0,
                                                       indicatorColor: UIColor.setColor(colorType: .titleColourDarkBlue),
                                                       dotsColor: UIColor.setColor(colorType: .placeHolder),
                                                       isBordered: false,
                                                       borderWidth: 0.0,
                                                       indicatorBorderColor: .clear,
                                                       indicatorBorderWidth: 0.0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        imagePageController.setPageOffset(offSet / width)
        
    }
}
