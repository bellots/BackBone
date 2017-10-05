//
//  SegmentedControlScrollView.swift
//  BackBone
//
//  Created by Andrea Bellotto on 01/01/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import UIKit
import UsefulExtensions

struct ViewControllerWithSegmentedControlScrollViewDelegate{
    let proto: SegmentedControlScrollViewDelegate
    let viewController: UIViewController
    
    init <T:UIViewController>(vc:T) where T:SegmentedControlScrollViewDelegate {
        self.proto = vc
        self.viewController = vc
    }
}


protocol SegmentedControlScrollViewDelegate{
    func didChangeViewTo(index:Int)
}

@IBDesignable
class SegmentedControlScrollView: UIView {
    
    private var heightAnchors = [NSLayoutConstraint]()
    private var widthAnchors = [NSLayoutConstraint]()
    
    var viewControllers = [UIViewController]()
    var views = [UIView]()
    var titles = [String]()
    var delegate:ViewControllerWithSegmentedControlScrollViewDelegate?
    
    public dynamic var barBackgroundColor:UIColor?{
        get { return self.segmentedControlView?.backgroundColor }
        set { self.segmentedControlView?.backgroundColor = newValue }
    }
    
    public dynamic var selectedTextColor:UIColor?{
        get { guard let color = self.segmentedControlView.selectedTextColor else {
                return Constants.SegmentedControl.TextColor.selectedPrimary
            }
            return color
        }
        set { self.segmentedControlView.selectedTextColor = newValue }
    }
    
    public dynamic var deselectedTextColor:UIColor?{
        get { guard let color = self.segmentedControlView.deselectedTextColor else {
            return Constants.SegmentedControl.TextColor.deselectedPrimary
            }
            return color
        }
        set { self.segmentedControlView.deselectedTextColor = newValue }
    }
    
    public dynamic var underlineViewBackgroundColor:UIColor?{
        get { return self.segmentedControlView.underlineView.backgroundColor }
        set { self.segmentedControlView.underlineView.backgroundColor = newValue }
    }
    
    public dynamic var selectedFont:UIFont?{
        get { guard let font = self.segmentedControlView.selectedFont else {
            return Constants.Font.Regular.medium
            }
            return font
        }
        set { self.segmentedControlView.selectedFont = newValue }
    }
    
    public dynamic var deselectedFont:UIFont?{
        get { guard let font = self.segmentedControlView.deselectedFont else {
            return Constants.Font.Regular.medium
            }
            return font
        }
        set { self.segmentedControlView.deselectedFont = newValue }
    }
    
    @IBOutlet weak var segmentedHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentedControlView: UnderlinedSegmentedControlView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBInspectable var segmentedHeight:CGFloat = 70{
        didSet{
            segmentedHeightConstraint.constant = segmentedHeight
            layoutIfNeeded()
        }
    }
    
    @IBInspectable var numElements:Int = 1 {
        didSet{
            segmentedControlView.numElements = numElements
        }
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        
        super.init(coder: aDecoder)!
        self.setup()
    }
    
    override func setup() {
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName: SegmentedControlScrollView.nameIdentifier, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
        
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

    }
    
    func setup(with viewControllers:[UIViewController], and titles:[String]){
//        segmentedControlView.backgroundColor = kNavigationBackgroundColor
//        
        self.views = [UIView]()
        self.heightAnchors = [NSLayoutConstraint]()
        self.widthAnchors = [NSLayoutConstraint]()
        self.viewControllers = viewControllers
        self.numElements = viewControllers.count
        segmentedControlView.delegate = self
        stackView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControlView.isHidden = (titles.count == 1)
        scrollView.delegate = self
        self.layoutIfNeeded()

        segmentedControlView.setupTabs(with: titles, selectedTextColor: selectedTextColor!, deselectedTextColor: deselectedTextColor!, selectedFont: selectedFont!, deselectedFont: deselectedFont!)
        
        for el in stackView.subviews {
            el.removeFromSuperview()
        }
        
        for viewController in viewControllers {
            views.append(viewController.view)
            stackView.addArrangedSubview(viewController.view)
            let tempHeight = viewController.view.heightAnchor.constraint(equalToConstant: self.frame.size.height - self.segmentedControlView.frame.size.height)
            let tempWidth = viewController.view.widthAnchor.constraint(equalToConstant: self.frame.size.width)
            tempHeight.isActive = true
            tempWidth.isActive = true
            heightAnchors.append(tempHeight)
            widthAnchors.append(tempWidth)
        }
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let delegate = delegate{
            for viewController in viewControllers{
                delegate.viewController.addChildViewController(viewController)
            }
        }
        
        for i in 0 ..< self.views.count {
            let heightSegmented = self.segmentedControlView.isHidden ? 0 : self.segmentedControlView.frame.size.height
            heightAnchors[i].constant = self.frame.size.height - heightSegmented
            widthAnchors[i].constant = self.frame.size.width
        }
    }
    func selectTab(at index:Int, animated:Bool){
        if animated{
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollView.contentOffset.x = CGFloat(index) * self.frame.size.width
                
            }) { (completed) in
                if completed {
                    self.viewControllers[index].viewDidAppear(true)
                    let index = self.scrollView.contentOffset.x / self.frame.size.width
                    self.segmentedControlView.selectTab(at: Int(index), animated:animated)
                    self.viewControllers[Int(index)].viewDidAppear(true)
                }
            }
        }
        else{
            self.scrollView.contentOffset.x = CGFloat(index) * self.frame.size.width
            self.viewControllers[index].viewDidAppear(true)
            let index = self.scrollView.contentOffset.x / self.frame.size.width
            self.segmentedControlView.selectTab(at: Int(index), animated:animated)
            self.viewControllers[Int(index)].viewDidAppear(true)
        }
    }
}


extension SegmentedControlScrollView:UnderlinedSegmentedControlViewDelegate{
    var buttonBackgroundColor: UIColor? {
        return delegate?.viewController.navigationController?.navigationBar.backgroundColor
    }

    func didSelectElement(at index: Int) {
        
        UIView.animate(withDuration: 0.3, animations: { 
            self.scrollView.contentOffset.x = CGFloat(index) * self.frame.size.width
            
        }) { (completed) in
            if completed {
                self.viewControllers[index].viewDidAppear(true)
            }
        }
    }
    
}


extension SegmentedControlScrollView:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let index = scrollView.contentOffset.x / self.frame.size.width
        segmentedControlView.selectTab(at: Int(index))
        viewControllers[Int(index)].viewDidAppear(true)
    }
}


