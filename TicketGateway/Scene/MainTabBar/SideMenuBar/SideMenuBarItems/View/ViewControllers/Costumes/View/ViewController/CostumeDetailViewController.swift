//
//  CostumeDetailViewController.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 03/05/23.
//

import UIKit
import MapKit
import AdvancedPageControl

class CostumeDetailViewController: UIViewController {
    
    @IBOutlet weak var cotumeTypeCollectionView: CostumeTypeCollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    @IBOutlet weak var costumeTableView: CostumeListTableView!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var similarProductCollectionView: UICollectionView!
   
    @IBOutlet weak var vwNavigationBar: NavigationBarView!
    
    @IBOutlet weak var photoPageController: AdvancedPageControlView!
    @IBOutlet weak var productPageController: AdvancedPageControlView!
    @IBOutlet weak var dottedLine: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblJuniorCarnival: UILabel!
    @IBOutlet weak var lblMasCamp: UILabel!
    @IBOutlet weak var lblSanFernado: UILabel!
    @IBOutlet weak var lblMon: UILabel!
    @IBOutlet weak var lblMonTime: UILabel!
    @IBOutlet weak var lblSat: UILabel!
    @IBOutlet weak var lblSatTime: UILabel!
    @IBOutlet weak var lblBandLeader: UILabel!
    @IBOutlet weak var lblDj: UILabel!
    @IBOutlet weak var btnContact: UIButton!
    @IBOutlet weak var lblSectionLeader: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var btnContactSectionLeader: UIButton!
    @IBOutlet weak var lblVideo: UILabel!
    @IBOutlet weak var lblPhotos: UILabel!
    @IBOutlet weak var lblSimilarProduct: UILabel!
    @IBOutlet weak var btnRegisterNow: CustomButtonGradiant!
    
   // @IBOutlet weak var lblVideoTime: UILabel!
    let productCollectionData = ["Product Details", "Delivery", "Returns", "Returns"]
    let videoCollectionData = ["Video_ip", "Video_ip", "Video_ip"]
    let photoCollectionData = ["photo_ip", "photo_ip", "photo_ip"]
    
    var selectedIndex = Int ()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setCollectionView()
       // setMap()
        setUI()
        setPageControll()
        setNavigaionBar()
        
    }
    
    func setNavigaionBar() {
        vwNavigationBar.lblTitle.text = "Costume Details"
        vwNavigationBar.delegateBarAction = self
        vwNavigationBar.btnBack.isHidden = false
    }
    
    func setTableView() {
        costumeTableView.configure()
        costumeTableView.isScrollEnabled = false
        costumeTableView.isForDetailVC = "DetailVC"
       
    }
    
    func setCollectionView() {
        cotumeTypeCollectionView.configure()
        cotumeTypeCollectionView.collectionDidSelectAtIndex = didSelectedAtIndex(at:)
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.register(UINib(nibName: "PhotosProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotosProductCollectionViewCell")
        similarProductCollectionView.delegate = self
        similarProductCollectionView.dataSource = self
        similarProductCollectionView.register(UINib(nibName: "PhotosProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotosProductCollectionViewCell")
    }
    
    func setMap() {
        let initialLocation = CLLocation(latitude: 22.7196, longitude: 75.8577)
        mapView.centerToLocation(initialLocation)
    }
    
    func setUI() {
        lblDescription.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblDescription.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblLocation.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        lblLocation.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        lblAddress.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblAddress.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblJuniorCarnival.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        lblJuniorCarnival.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        lblMasCamp.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        lblMasCamp.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        lblSanFernado.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        lblSanFernado.textColor = UIColor.setColor(colorType: .Headinglbl)
        lblMon.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblMon.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblMonTime.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblMonTime.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblSat.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblSat.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblSatTime.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblSatTime.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblBandLeader.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        lblBandLeader.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        lblDj.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        lblDj.textColor = UIColor.setColor(colorType: .TGBlue)
        btnContact.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnContact.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        
        lblSectionLeader.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        lblSectionLeader.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        lblName.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        lblName.textColor = UIColor.setColor(colorType: .TGBlue)
       
        lblEmail.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblEmail.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblPhoneNo.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblPhoneNo.textColor = UIColor.setColor(colorType: .lblTextPara)
        btnContactSectionLeader.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnContactSectionLeader.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        
      
        lblVideo.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        lblVideo.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        lblPhotos.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        lblPhotos.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        lblSimilarProduct.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        lblSimilarProduct.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        dottedLine.createDottedLine(width: 2, color: UIColor.setColor(colorType: .BorderLineColour).cgColor, dashPattern: [2,4])

        btnRegisterNow.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnRegisterNow.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        btnRegisterNow.addRightIcon(image: UIImage(named: "LeftArrow_ip"))
        
      //  lblVideoTime.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
       // lblVideoTime.textColor = UIColor.setColor(colorType: .white)
        
    }
    
    private func didSelectedAtIndex(at index: Int) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CostumeFrontLineViewController") as! CostumeFrontLineViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CostumeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.productCollectionView {
            return productCollectionData.count
        } else if collectionView == self.videoCollectionView {
            return videoCollectionData.count
        } else if collectionView == self.photosCollectionView {
            return photoCollectionData.count
        } else if collectionView == self.similarProductCollectionView {
            return photoCollectionData.count

        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == productCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailCollectionViewCell", for: indexPath) as! ProductDetailCollectionViewCell
            let data = productCollectionData[indexPath.row]
            cell.lblProduct.text = data
            cell.bgView.backgroundColor = selectedIndex == indexPath.row ? UIColor.setColor(colorType: .lightBlack) : UIColor.white
            cell.lblProduct.textColor = selectedIndex == indexPath.row ? UIColor.white : UIColor.setColor(colorType: .lblTextPara)
            return cell
        } else if collectionView == videoCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
            let data = videoCollectionData[indexPath.row]
            cell.imgImage.image = UIImage(named: data)
            return cell
        } else if collectionView == photosCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosProductCollectionViewCell", for: indexPath) as! PhotosProductCollectionViewCell
            let data = photoCollectionData[indexPath.row]
            cell.imgImage.image = UIImage(named: data)
            cell.stackView.isHidden = true
            return cell
        } else if collectionView == similarProductCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosProductCollectionViewCell", for: indexPath) as! PhotosProductCollectionViewCell
            let data = photoCollectionData[indexPath.row]
            cell.imgImage.image = UIImage(named: data)
            cell.stackView.isHidden = false
            return cell
        }
         
        return UICollectionViewCell()
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        productCollectionView.reloadData()
    }
   
}


//MARK: - MKMapView
private extension MKMapView {
    func centerToLocation(_ location: CLLocation,regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

//MARK: - PageController
extension CostumeDetailViewController {
    func setPageControll() {
        photoPageController.drawer = ExtendedDotDrawer(numberOfPages: 3,
                                                       space: 16.0,
                                                       indicatorColor: UIColor.setColor(colorType: .TiitleColourDarkBlue),
                                                       dotsColor: UIColor.setColor(colorType: .PlaceHolder),
                                                       isBordered: false,
                                                       borderWidth: 0.0,
                                                       indicatorBorderColor: .clear,
                                                       indicatorBorderWidth: 0.0)
        
        productPageController.drawer = ExtendedDotDrawer(numberOfPages: 3,
                                                         space: 16.0,
                                                         indicatorColor: UIColor.setColor(colorType: .TiitleColourDarkBlue),
                                                         dotsColor: UIColor.setColor(colorType: .PlaceHolder),
                                                         isBordered: false,
                                                         borderWidth: 0.0,
                                                         indicatorBorderColor: .clear,
                                                         indicatorBorderWidth: 0.0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        if scrollView == photosCollectionView {
            photoPageController.setPageOffset(offSet / width)
        } else {
            productPageController.setPageOffset(offSet / width)
        }
        
       
        
    }
    
}

//MARK: - NavigationBarViewDelegate
extension CostumeDetailViewController: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
