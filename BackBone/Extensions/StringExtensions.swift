//
//  StringExtensions.swift
//  JoeBee
//
//  Created by Andrea Bellotto on 14/11/16.
//  Copyright © 2016 JoeBee Srl. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    // return the localized string from a string label
    public var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    public func localizedWithComment(comment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
    
    // trims the string from useless whitespaces and newlines
    public var trimmed:String{
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    public var dictionary:[String:Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    public var array:[[String:Any]]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    public static func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    
    public static func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    public func substr(_ start:Int, length:Int=0) -> String? {
        guard start > -1 else {
            return nil
        }
        
        let count = self.characters.count - 1
        
        guard start <= count else {
            return nil
        }
        
        let startOffset = max(0, start)
        let endOffset = length > 0 ? min(count, startOffset + length - 1) : count
        
        return self[self.index(self.startIndex, offsetBy: startOffset)...self.index(self.startIndex, offsetBy: endOffset)]
    }
    public var encoded:String
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    public var decoded:String
    {
        return self.removingPercentEncoding!
    }
    
    
    public func heightForWidthWithFont(font: UIFont, width: CGFloat, insets: UIEdgeInsets) -> CGFloat {
        
        let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width:width + insets.left + insets.right, height:CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        
        label.sizeToFit()
        return label.frame.height + insets.top + insets.bottom
    }

    
}
