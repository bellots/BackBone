//
//  UITableViewExtensions.swift
//  JoeBee
//
//  Created by Andrea Bellotto on 14/11/16.
//  Copyright © 2016 JoeBee Srl. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    // checks if uitableview is already to bottom
    
    public var isScrolledToBottom:Bool {
        return self.contentOffset.y >= (self.contentSize.height - self.frame.size.height)
    }
    
    // scrolls automatically to bottom uitableview
    
    public func scrollToBottom(animated: Bool) {
        
        let delay = 0.1 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                self.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: animated)
            }
            
        })
    }
    
    // registers uitableviewcell in viewcontroller in a more simple way
    
    public func register<T: UITableViewCell>(_: T.Type){
        self.register(UINib(nibName: T.nameIdentifier, bundle: Bundle.main), forCellReuseIdentifier: T.nameIdentifier)
    }
    
}
