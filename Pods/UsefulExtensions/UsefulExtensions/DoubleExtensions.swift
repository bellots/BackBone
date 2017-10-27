//
//  DoubleExtensions.swift
//  JoeBee
//
//  Created by Andrea Bellotto on 14/11/16.
//  Copyright © 2016 JoeBee Srl. All rights reserved.
//

import Foundation

extension Double {
    
    // rounds to fraction digits the double
    
    public func roundToDecimal(fractionDigits: Int) -> Double {
        let multiplier = pow(10.0, Double(fractionDigits))
        return (self * multiplier).rounded() / multiplier
    }
    
    // returns number formatted in what you need
    
    public func format(with locale:Locale, and format:NumberFormatter.Style)->String{
        let converted = NSDecimalNumber(decimal: Decimal(self))
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = format
        return formatter.string(from: converted)!
    }
}
