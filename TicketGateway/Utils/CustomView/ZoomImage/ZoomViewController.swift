//
//  ZoomViewController.swift
//  TicketGateway
//
//  Created by Apple on 03/07/23.

import UIKit

class ZoomViewController: UIViewController {

    var imgProfile: UIImage?
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet private var mainScrollView: UIScrollView!
    @IBOutlet private var backgroundView: UIView!
    @IBOutlet private var mainView:UIView!

    var cropView: UIView?
    var imgBackground: UIImageView?
   // var imgVZoomedParcelPhoto: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationview()
        imgBackground?.image = imgProfile
        self.setImageView()
        self.addGesture()

        self.setLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       setupScales()
    }

}

// MARK: - Functions
extension ZoomViewController{

    func setImageView() {
        // Creates an image view with a test image
        self.imgBackground = UIImageView()
        imgBackground?.image = imgProfile

        // Add the imageview to the scrollview
        mainScrollView.addSubview(imgBackground!)

        // Sets the following flag so that auto layout is used correctly
       // imgBackground?.translatesAutoresizingMaskIntoConstraints = false
        // self.imgVZoomedParcelPhoto.translatesAutoresizingMaskIntoConstraints = NO;

        // Sets the scrollview delegate as self
        mainScrollView.delegate = self

        // Creates references to the views

        // Sets the image frame as the image size

        imgBackground?.frame = CGRect(x: 0, y: mainView.frame.size.height, width: (imgProfile?.size.width)!, height: (imgProfile?.size.height)!)

        // Tell the scroll view the size of the contents
        mainScrollView.contentSize = imgProfile!.size
    }

    func setLayer() {
//        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 244, y: 244), radius: CGFloat(122), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
//
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = circlePath.cgPath
//
//        // Change the fill color
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        // You can change the stroke color
//        shapeLayer.strokeColor = UIColor.red.cgColor
//        // You can change the line width
//        shapeLayer.lineWidth = 3.0
//
//        self.view.layer.addSublayer(shapeLayer)

        let overlay = createOverlay(frame: backgroundView.frame,
                                    xOffset: backgroundView.frame.midX,
                                    yOffset: backgroundView.frame.midY,
                                    radius: 122.0)
        backgroundView.addSubview(overlay)
        cropView = overlay
        overlay.isUserInteractionEnabled = false
    }

    func setNavigationview() {
        self.navigationView.delegateBarAction = self
        self.navigationView.navViewbackgroundColor = UIColor.setColor(colorType: .btnDarkBlue)
         self.navigationView.btnBack.isHidden = true
        self.navigationView.imgBack.isHidden = true
         self.navigationView.lblTitle.text = "Move and Scale"
        //self.navigationView.backgroundColor = .clear
         self.navigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
         self.navigationView.lblTitle.textColor = UIColor.setColor(colorType: .white)
        self.navigationView.setBackgroundColor()
        self.navigationView.vwBorder.isHidden = true
    }

    func addGesture() {
        // Add doubleTap recognizer to the scrollView
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollViewDoubleTapped(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        mainScrollView.addGestureRecognizer(doubleTapRecognizer)

        // Add two finger recognizer to the scrollView
        let twoFingerTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollViewTwoFingerTapped(_:)))
        twoFingerTapRecognizer.numberOfTapsRequired = 1

        twoFingerTapRecognizer.numberOfTouchesRequired = 2
        mainScrollView.addGestureRecognizer(twoFingerTapRecognizer)
    }

    // MARK: - Scroll View scales setup and center
    func setupScales() {
        // Set up the minimum & maximum zoom scales
        let scrollViewFrame = mainScrollView.frame
        let scaleWidth = scrollViewFrame.size.width / mainScrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / mainScrollView.contentSize.height
        let minScale = CGFloat(min(scaleWidth, scaleHeight))

        mainScrollView.minimumZoomScale = minScale
        mainScrollView.maximumZoomScale = 1.0
        mainScrollView.zoomScale = minScale

        centerScrollViewContents()
    }

    func centerScrollViewContents() {
        // This method centers the scroll view contents also used on did zoom
        let boundsSize = mainScrollView.bounds.size
        var contentsFrame = imgBackground?.frame

        if (contentsFrame?.size.width)! < boundsSize.width {
            contentsFrame!.origin.x = (boundsSize.width - contentsFrame!.size.width) / 2.0
        } else {
            contentsFrame?.origin.x = 0
        }

        if (contentsFrame?.size.height)! < boundsSize.height {
            contentsFrame!.origin.y = (boundsSize.height - contentsFrame!.size.height) / 2
        } else {
            contentsFrame!.origin.y = (boundsSize.height - contentsFrame!.size.height) / 2
           // contentsFrame?.origin.y = mainView.frame.size.height / 2
        }

        imgBackground?.frame = contentsFrame!
    }
    // MARK: - Rotation
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        // When the orientation is changed the contentSize is reset when the frame changes. Setting this back to the relevant image size
        mainScrollView.contentSize = (imgBackground?.image!.size)!
        // Reset the scales depending on the change of values
        setupScales()
    }

    func createOverlay(frame: CGRect,
                       xOffset: CGFloat,
                       yOffset: CGFloat,
                       radius: CGFloat) -> UIView {
        // Step 1
        let overlayView = UIView(frame: frame)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        // Step 2
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: xOffset, y: yOffset),
                    radius: radius,
                    startAngle: 0.0,
                    endAngle: 2.0 * .pi,
                    clockwise: false)
        path.addRect(CGRect(origin: .zero, size: overlayView.frame.size))
        // Step 3
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        // For Swift 4.0
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        // For Swift 4.2
        maskLayer.fillRule = .evenOdd
        // Step 4
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true

        return overlayView
    }
}

// MARK: - Actions
extension ZoomViewController{
    @IBAction private func btnCancelPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction private func btnChoosePressed(_ sender: UIButton) {
        print(cropView?.frame)
    }
}

// MARK: - ScrollView Delegate methods
extension ZoomViewController:UIScrollViewDelegate{

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        // Return the view that we want to zoom
        return imgBackground
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // The scroll view has zoomed, so we need to re-center the contents
        centerScrollViewContents()
    }
}

// MARK: - ScrollView gesture methods
extension ZoomViewController {
    @objc func scrollViewDoubleTapped(_ recognizer: UITapGestureRecognizer?) {
        // Get the location within the image view where we tapped
        let pointInView = recognizer?.location(in: imgBackground)
        // Get a zoom scale that's zoomed in slightly, capped at the maximum zoom scale specified by the scroll view
        var newZoomScale = mainScrollView.zoomScale * 1.5
        newZoomScale = CGFloat(min(newZoomScale, mainScrollView.maximumZoomScale))
        // Figure out the rect we want to zoom to, then zoom to it
        let scrollViewSize = mainScrollView.bounds.size
        let width = scrollViewSize.width / newZoomScale
        let height = scrollViewSize.height / newZoomScale
        let xAxis = (pointInView?.x ?? 0.0) - (width / 2.0)
        let yAxis = (pointInView?.y ?? 0.0) - (height / 2.0)
        let rectToZoomTo = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        mainScrollView.zoom(to: rectToZoomTo, animated: true)
    }

    @objc func scrollViewTwoFingerTapped(_ recognizer: UITapGestureRecognizer?) {
        // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
        var newZoomScale = mainScrollView.zoomScale / 1.5
        newZoomScale = CGFloat(max(newZoomScale, mainScrollView.minimumZoomScale))
        mainScrollView.setZoomScale(newZoomScale, animated: true)
    }
}

// MARK: - NavigationBarViewDelegate
extension ZoomViewController: NavigationBarViewDelegate {
    func navigationBackAction() {
    self.navigationController?.popViewController(animated: true)
  }
}
