//
//  DictionaryExtensions.swift
//  UsefulExtensions
//
//  Created by Andrea Bellotto on 06/09/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation

extension Dictionary{
    public var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
}
