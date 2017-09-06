//
//  ArrayExtensions.swift
//  UsefulExtensions
//
//  Created by Andrea Bellotto on 06/09/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation


extension Array{
    
    public var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    public func grouped<T>(by criteria: (Element) -> T) -> [T: [Element]] {
        var groups = [T: [Element]]()
        for element in self {
            let key = criteria(element)
            if groups.keys.contains(key) == false {
                groups[key] = [Element]()
            }
            groups[key]?.append(element)
        }
        return groups
    }
    
    public func splitted(in numElementsPerBlock:Int)->[[Element]] {
        var toRet = [[Element]]()
        var blockArray = [Element]()
        
        for i in 0..<self.count {
            if i % numElementsPerBlock == 0 && i > 0 {
                toRet.append(blockArray)
                blockArray = [Element]()
            }
            blockArray.append(self[i])
        }
        toRet.append(blockArray)
        return toRet
    }
}


extension Array where Element:AnyObject {
    mutating public func remove(object: Element) {
        if let index = index(where: { $0 === object }) {
            remove(at: index)
        }
    }
    mutating public func exchange(element1:Element, with element2:Element){
        if let index = self.index(where:{$0 === element1}), let index2 = self.index(where:{$0 === element2}){
            let temp = element1
            self[index] = element2
            self[index2] = temp
        }
    }
}
