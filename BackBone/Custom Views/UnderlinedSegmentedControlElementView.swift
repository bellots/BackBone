//
//  UnderlinedSegmentedControlElementView.swift
//  BackBone
//
//  Created by Andrea Bellotto on 13/12/16.
//  Copyright © 2016 JoeBee Srl. All rights reserved.
//

import UIKit


protocol UnderlinedSegmentedControlElementViewDelegate:class {
    func didTouchButton(at index:Int)
}

@IBDesignable

class UnderlinedSegmentedControlElementView: UIView {
    
    var index:Int = 0
    weak var delegate:UnderlinedSegmentedControlElementViewDelegate?
    
    @IBOutlet weak var segmentedButton: SelectableButton!
    
    var buttonText:String {
        get {
            if let text = segmentedButton.titleLabel?.text {
                return text
            }
            else {
                return "noDefined"
            }
        }
        set(buttonText){
            self.segmentedButton.setTitle(buttonText, for: .normal)
        }
    }
    
    @IBInspectable var elementSelected:Bool = false {
        didSet{
            self.segmentedButton.borderLayer.isHidden = !elementSelected
        }
    }
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
//        segmentedButton.backgroundColor = UIColor.lightGray
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        setup()
    }

    override func setup() {
        super.setup()
        segmentedButton.imageView?.backgroundColor = .clear
    }
    @IBAction func buttonDidPressed(_ sender: SelectableButton) {
        delegate?.didTouchButton(at: index)
    }
}
