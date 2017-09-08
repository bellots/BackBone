//
//  UICollectionViewExtensions.swift
//  UsefulExtensions
//
//  Created by Andrea Bellotto on 29/01/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation

extension UICollectionView{
    
    // registers uicollectionviewcell in viewcontroller in a more simple way
    
    public func register<T: UICollectionViewCell>(_: T.Type){
        self.register(UINib(nibName: T.nameIdentifier, bundle: Bundle.main), forCellWithReuseIdentifier: T.nameIdentifier)
    }
}
