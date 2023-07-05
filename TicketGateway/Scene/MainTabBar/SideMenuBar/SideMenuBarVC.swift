//
//  SideMenuBarVC.swift
//  TicketGateway
//
//  Created by Apple  on 02/05/23.
//



import UIKit
import SWRevealViewController

class Side: UIViewController {
    
    /// overlay view
    lazy var overlayView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupView()
        setupNavBar()
        setupSWReveal()
    }
    
    /// adds overlay view
    func setupView(){
        
        view.addSubview(overlayView)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        overlayView.alpha = 0
    }

    /// setup navigation bar
    func setupNavBar(){
        navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburger"), style: .plain, target: self, action: #selector(hamburgerClicked))
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 255/255, green: 215/255, blue: 0, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    /// setup swreveal controller
    func setupSWReveal(){
       //adding panGesture to reveal menu controller
        view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
       
       //adding tap gesture to hide menu controller
        view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        
        //setting reveal width of menu controller manually
        self.revealViewController()?.rearViewRevealWidth = UIScreen.main.bounds.width * (2/3)
        
        self.revealViewController()?.delegate = self
        
    }

    //MARK: - action
    @objc func hamburgerClicked(){
        //toggle frontVC on clicking hamburger menu
        self.revealViewController()?.revealToggle(animated: true)
    }
}

//MARK: - SWRevealController delegates
extension FrontViewController : SWRevealViewControllerDelegate{
    
    //varying alpha of overlayView with progress of panGesture to reveal or hide menu view
    func revealController(_ revealController: SWRevealViewController!, panGestureMovedToLocation location: CGFloat, progress: CGFloat) {
        overlayView.alpha = progress
    }
    
    //animating alpha in case user just taps hamburger menu which directly change FrontViewPosition
    func revealController(_ revealController: SWRevealViewController!, animateTo position: FrontViewPosition) {
        
        //menu view is hidden
        if position == FrontViewPosition.left{
            overlayView.alpha = 0
        }

        //menu view is revealed
        if position == FrontViewPosition.right{
            overlayView.alpha = 1
        }
    }
}

