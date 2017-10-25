//
//  UnderlinedSegmentedViewControl.swift
//  BackBone
//
//  Created by Andrea Bellotto on 13/12/16.
//  Copyright © 2016 JoeBee Srl. All rights reserved.
//

import UIKit

protocol UnderlinedSegmentedControlViewDelegate:class {
    func didSelectElement(at index:Int)
    var buttonBackgroundColor:UIColor?{get}
}

@IBDesignable

class UnderlinedSegmentedControlView: UIView {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var underlineViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var underlineViewWidthConstraint: NSLayoutConstraint!
    
    weak var delegate:UnderlinedSegmentedControlViewDelegate?
    var elements = [UnderlinedSegmentedControlElementView]()
    
    var selectedTextColor:UIColor!
    var deselectedTextColor:UIColor!
    
    var selectedFont:UIFont!
    var deselectedFont:UIFont!

    var selectedTab:Int = 0
    
    @IBInspectable var numElements:Int = 1 {
        didSet{
            setup(with: numElements)
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
        underlineView.backgroundColor = UIColor.white
        numElements = 1
        underlineViewWidthConstraint.constant = frame.width
        underlineViewLeadingConstraint.constant = 0

    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        setup()
        underlineView.backgroundColor = UIColor.orange
        numElements = 1
        underlineViewWidthConstraint.constant = frame.width
        underlineViewLeadingConstraint.constant = 0

    }
    
    func setup(with numTabs:Int){
        elements = [UnderlinedSegmentedControlElementView]()
        for el in stackView.subviews {
            el.removeFromSuperview()
        }
        for i in 0..<numTabs {
            let tab = UnderlinedSegmentedControlElementView(frame: CGRect(x: 0, y: 0, width: (self.frame.size.width / CGFloat(numTabs)), height: 30))
            tab.delegate = self
            tab.segmentedButton.backgroundColor = delegate?.buttonBackgroundColor
            if i == selectedTab {
                tab.elementSelected = true
            }
            else {
                tab.segmentedButton.titleLabelFont = deselectedFont
                tab.segmentedButton.textColor = deselectedTextColor
                tab.elementSelected = false
            }
            tab.index = i
            stackView.addArrangedSubview(tab)
            elements.append(tab)
        }
        underlineViewLeadingConstraint.constant = 0
    }
    
    
    func selectTab(at index:Int, animated:Bool = true){
        self.selectedTab = index
        for (i, element) in stackView.subviews.enumerated() {
            if let underlinedElementView = element as? UnderlinedSegmentedControlElementView {
                if i == index {
                    underlinedElementView.elementSelected = true
                    underlinedElementView.segmentedButton.textColor = selectedTextColor
                    underlinedElementView.segmentedButton.titleLabelFont = selectedFont
                }
                else {
                    underlinedElementView.elementSelected = false
                    underlinedElementView.segmentedButton.textColor = deselectedTextColor
                    underlinedElementView.segmentedButton.titleLabelFont = deselectedFont
                }
            }
        }
        underlineViewLeadingConstraint.constant = elements[index].frame.origin.x
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutIfNeeded()
            })
        }
        else{
            self.layoutIfNeeded()
        }
    }
    
    func setupTabs(with titles:[String], selectedTextColor:UIColor, deselectedTextColor:UIColor, selectedFont:UIFont, deselectedFont:UIFont){
        self.selectedTextColor = selectedTextColor
        self.deselectedTextColor = deselectedTextColor
        
        self.selectedFont = selectedFont
        self.deselectedFont = deselectedFont
        
        var limit = titles.count
//        if titles.count > elements.count {
//            limit = elements.count
//        }
        self.numElements = limit
        for i in 0 ..< limit {
            elements[i].buttonText = titles[i]
            if elements[i].elementSelected {
                elements[i].segmentedButton.textColor = selectedTextColor
                elements[i].segmentedButton.titleLabelFont = selectedFont
            }
            else {
                elements[i].segmentedButton.textColor = deselectedTextColor
                elements[i].segmentedButton.titleLabelFont = deselectedFont

            }
        }
        layoutIfNeeded()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if numElements > 0 {
            underlineViewWidthConstraint.constant = self.frame.size.width / CGFloat(numElements)
        }
        else{
            underlineViewWidthConstraint.constant = self.frame.size.width / 1
        }
    }
    
    
}


extension UnderlinedSegmentedControlView:UnderlinedSegmentedControlElementViewDelegate{
    func didTouchButton(at index: Int) {
        selectTab(at: index)
        if let delegate = delegate {
            delegate.didSelectElement(at: index)
        }
    }
}

