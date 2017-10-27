//
//  UICollectionViews.swift
//  BackBone
//
//  Created by Andrea Bellotto on 06/03/17.
//  Copyright © 2017 BackBone Srl. All rights reserved.
//

import Foundation
import UIKit

class IntrinsicCollectionView:UICollectionView{
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
        
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
