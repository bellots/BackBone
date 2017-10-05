//
//  MainViewController.swift
//  BackBone
//
//  Created by Andrea Bellotto on 05/10/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import UIKit
import MBProgressHUD
import UsefulExtensions

public enum TypeNavigation{
    
    case none
    case title(withTitle:String)
    case titleWithAction(withTitle:String, andAction:(()->Void))
    case titleWithImage(withTitle:String, andImage:UIImage)
}

class MainViewController: UIViewController {
    
    
    func setTopMainViewController(){
        if let delegate = UIApplication.shared.delegate as? AppDelegate{
            delegate.topMainViewController = self
        }
    }
    
    var alreadySetupNavigation = false
    
    var typeNavigation:TypeNavigation = .none
    {
        didSet{
            setupNavView(with: typeNavigation)
        }
    }
    
    
    var progress:MBProgressHUD?
    
    private var shadowImageView: UIImageView?
    
    //MARK: - segment elements
    var numSegments = 0
    var viewControllers = [UIViewController]()
    var currentIndex = 0
    
    var mySegmentedControlScrollView:SegmentedControlScrollView?
    
    var navigationView:UIView!
    var navViewHeightConstraint: NSLayoutConstraint!
    
    var titleAction:(()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        createHeaderView()
        anchorToHeaderView()
        
        if let items = self.tabBarController?.tabBar.items {
            for (i,item) in items.enumerated() {
                switch i {
                case 0:
                    //                    item.selectedImage = Constants.TabBar.Icon.firstOn.withRenderingMode(.alwaysOriginal)
                    //                    item.image = Constants.TabBar.Icon.first.withRenderingMode(.alwaysOriginal)
                    item.title = "tab_first_title".localized
                default:
//                    item.selectedImage = Constants.TabBar.Icon.firstOn.withRenderingMode(.alwaysOriginal)
//                    item.image = Constants.TabBar.Icon.first.withRenderingMode(.alwaysOriginal)
                    item.title = "tab_first_title".localized
                }
            }
        }
        
        if #available(iOS 11.0, *){
            navigationController?.navigationBar.prefersLargeTitles = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setTopMainViewController()
        
        
        if let deepLink = DeepLinkManager.instance.deepLink{
            
            // step 1: cambio tab se ce l'ha, altrimenti faccio un bel
            
            if let tabNumber = DeepLinkManager.instance.tabIndex {
                self.tabBarController?.selectedIndex = tabNumber
                DeepLinkManager.instance.tabIndex = nil
                return
            }
                // step 2: cambio segment se ce l'ha
                
            else if let mySegmentedControlScrollView = mySegmentedControlScrollView, let tabSegmented = DeepLinkManager.instance.segmentedControlScrollViewTabIndex{
                if tabSegmented < mySegmentedControlScrollView.numElements - 1 {
                    mySegmentedControlScrollView.selectTab(at: tabSegmented, animated: true)
                }
                DeepLinkManager.instance.segmentedControlScrollViewTabIndex = nil
                return
            }
                // altrimenti gestisco il link
            else{
                switch deepLink{
                case .link(let linkModel):
                    // go to link detail ViewController
                    DeepLinkManager.instance.deepLink = nil
                default:
                    return
                }
                DeepLinkManager.instance.deepLink = nil
            }
        }
    }
    
    
    func showQuizDetail(){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if shadowImageView == nil {
            shadowImageView = findShadowImage(under: navigationController!.navigationBar)
        }
        shadowImageView?.isHidden = true
        //        setStyle()
        if !alreadySetupNavigation {
            alreadySetupNavigation = true
        }
        navigationView.backgroundColor = self.navigationController?.navigationBar.backgroundColor
        
    }
    
    
    func createHeaderView(){
        
        navigationView = UIView()
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navigationView)
        
        view.addConstraint(NSLayoutConstraint(
            item: navigationView,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1,
            constant: 0)
        )
        
        view.addConstraint(NSLayoutConstraint(
            item: navigationView,
            attribute: .left,
            relatedBy: .equal,
            toItem: view,
            attribute: .left,
            multiplier: 1,
            constant: 0)
        )
        
        view.addConstraint(NSLayoutConstraint(
            item: navigationView,
            attribute: .right,
            relatedBy: .equal,
            toItem: view,
            attribute: .right,
            multiplier: 1,
            constant: 0)
        )
        
        navViewHeightConstraint = NSLayoutConstraint(
            item: navigationView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height,
            multiplier: 1,
            constant: 30)
        
        view.addConstraint(navViewHeightConstraint)
        
    }
    
    func anchorToHeaderView(){
        for view in self.view.subviews {
            var found = false
            var constant:CGFloat = 0.0
            for constraint in view.constraintsAffectingLayout(for: .vertical){
                if view.isTopConstraint(constraint: constraint) {
                    if let secondItem = constraint.secondItem as? UIView, secondItem == self.view {
                        if let firstItem = constraint.firstItem as? UIView{
                            if firstItem != navigationView {
                                constant = constraint.constant
                                constraint.isActive = false
                                found = true
                                break
                            }
                        }
                    }
                    if (constraint.secondItem?.conforms(to: UILayoutSupport.self))!{
                        if let firstItem = constraint.firstItem as? UIView{
                            if firstItem != navigationView {
                                constant = constraint.constant
                                constraint.isActive = false
                                found = true
                                break
                            }
                        }
                    }
                }
            }
            if found {
                self.view.addConstraint(NSLayoutConstraint(
                    item: view,
                    attribute: .top,
                    relatedBy: .equal,
                    toItem: navigationView,
                    attribute: .bottom,
                    multiplier: 1,
                    constant: constant)
                )
            }
        }
        self.view.setNeedsLayout()
        
    }
    
    
    
    private func findShadowImage(under view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1 {
            return (view as! UIImageView)
        }
        
        for subview in view.subviews {
            if let imageView = findShadowImage(under: subview) {
                return imageView
            }
        }
        return nil
    }
    
    //MARK: - Navigation button actions
    
    
    @IBAction func mapButtonPressed(sender:UIButton){
        
    }
    
    @IBAction func listButtonPressed(sender:UIButton){
        
    }
    
}



extension MainViewController{
    
    func setupNavView(with typeNavigation:TypeNavigation){
        switch typeNavigation {
            
            
        case .title(let title):
            navViewHeightConstraint.constant = 0
            addTitleHeader(title: title)
        case .titleWithImage(let title, let image):
            navViewHeightConstraint.constant = 0
            addTitleWithImageHeader(title: title, image: image)
        default:
            navViewHeightConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func addTitleWithImageHeader(title:String, image:UIImage){
        let container = UIView(frame: CGRect(x:0,y:0,width:200,height:40))
        let buffer:CGFloat = 2.0
        let maxWidth:CGFloat = 120.0
        
        let imageView = UIImageView(frame: CGRect(x: self.view.frame.size.width/2, y: 0, width: 30, height: 30))
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        let titleLabel = BoldContrastSecondaryLabel(frame: CGRect(x: 0, y: 0, width: 180, height: 20))
        titleLabel.text = title
        titleLabel.textColor = Constants.Label.TextColor.contrastSecondary
        titleLabel.font = Constants.Font.Bold.medium
        titleLabel.sizeToFit()
        titleLabel.center =  CGPoint(x:container.frame.size.width  / 2,
                                     y:container.frame.size.height / 2)
        
        imageView.center = CGPoint(x: titleLabel.frame.maxX + imageView.frame.size.width * 0.5 + buffer,
                                   y:container.frame.size.height / 2)
        container.addSubview(titleLabel)
        container.addSubview(imageView)
        
        self.navigationItem.titleView = container
    }
    
    func addTitleHeader(title:String){
        self.navigationItem.title = title
    }
    
    class func showLoader(){
        DispatchQueue.main.async {
            if let delegate = UIApplication.shared.delegate as? AppDelegate{
                if let topViewController = delegate.topMainViewController{
                    if topViewController.progress == nil {
                        topViewController.progress = MBProgressHUD.showAdded(to: UIApplication.shared.windows.first!, animated: true)
                    }
                }
            }
        }
    }
    
    
    class func hideLoader(){
        DispatchQueue.main.async {
            if let delegate = UIApplication.shared.delegate as? AppDelegate{
                if let topViewController = delegate.topMainViewController{
                    guard let progress = topViewController.progress else {
                        return
                    }
                    progress.hide(animated: true)
                    topViewController.progress = nil
                }
            }
        }
    }
    
    class func showAlert(with error:ErrorModel){
        showAlert(withTitle: "alert_attention".localized, message: error.message!, cancelTitle: "alert_ok".localized, actionCancel: nil)
    }
    
    class func showAlert(withTitle title:String, message:String, cancelTitle:String, actionCancel:(()->Void)?){
        DispatchQueue.main.async {
            if let delegate = UIApplication.shared.delegate as? AppDelegate{
                if let topViewController = delegate.topMainViewController{
                    UIAlertController.show(withTitle: title, message: message, cancelTitle: cancelTitle, actionCancel: actionCancel, inViewController: topViewController)
                }
            }
        }
    }
    
    
}


