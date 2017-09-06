//
//  RawRepresentableExtensions.swift
//  UsefulExtensions
//
//  Created by Andrea Bellotto on 24/03/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation

extension RawRepresentable where RawValue == Int {
    
   public static var itemsCount: Int {
        var index = 0
        while Self(rawValue: index) != nil { index += 1 }
        return index
    }
    
   public static var items: [Self] {
        var items: [Self] = []
        var index = 0
        while let item = Self(rawValue: index) {
            items.append(item)
            index += 1
        }
        return items
    }
}
