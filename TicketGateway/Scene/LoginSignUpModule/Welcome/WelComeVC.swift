//
//  WelComeVC.swift
//  TicketGateway
//
//  Created by Apple  on 13/04/23.
// swiftlint: disable file_length
// swiftlint: disable force_cast
// swiftlint: disable line_length

import UIKit
class WelComeVC: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet var cvSlider: UICollectionView!
    // MARK: - Variable
    var viewModel = WelcomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = WelcomeViewModel(wlcmVC: self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @objc func skipBtn(sender: UIButton) {
        // ...
        let view = self.createView(storyboard: .main, storyboardID: .WelcomeLoginSignupVC)
        self.navigationController?.pushViewController(view, animated: true)
    }
    @objc func nextBtn(sender: UIButton) {
        // ...
        self.viewModel.setPageController()
    }
}
// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension WelComeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.arrSliderImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelComeCell", for: indexPath) as! WelComeCell
        cell.imgPageControl.image = self.viewModel.arrSliderImages[indexPath.row]
        //   cell.imgAdvertisement.image = self.arrImages[indexPath.row]
        cell.btnSkip.tag = indexPath.row
        cell.btnNext.tag = indexPath.row
        cell.btnSkip.addTarget(self, action: #selector(skipBtn), for: .touchUpInside)
        cell.btnNext.addTarget(self, action: #selector(nextBtn), for: .touchUpInside)
        if self.viewModel.arrSliderImages.count-1 == indexPath.row {
            cell.btnNext.setTitle(FINISH, for: .normal)
        } else {
            cell.btnNext.setTitle(NEXT, for: .normal)
        }
        if self.viewModel.arrSliderImages.count-1 == indexPath.row || indexPath.row == 0 {
            cell.btnSkip.isHidden = true
        } else {
            cell.btnSkip.isHidden = false
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        cellWidth = CGFloat(self.view.frame.size.width)
        cellHeight = CGFloat(self.view.frame.size.height)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.viewModel.currentIndex = indexPath.row
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.currentIndex = indexPath.row
        self.viewModel.setPageController()
    }
}
