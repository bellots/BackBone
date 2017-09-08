//
//  UIImageExtensions.swift
//  UsefulExtensions
//
//  Created by Andrea Bellotto on 06/09/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation

extension UIImage{
    
    public func formData(boundary:String,fileName:String) -> Data {
        var fullData = Data()
        // 1 - Boundary should start with --
        let lineOne = "--" + boundary + "\r\n"
        fullData.append(lineOne.data(using:
            String.Encoding.utf8,
                                     allowLossyConversion: false)!)
        
        // 2
        let lineTwo = "Content-Disposition: form-data; name=\"image\"; filename=\"" + fileName + "\"\r\n"
        NSLog(lineTwo)
        fullData.append(lineTwo.data(using:
            String.Encoding.utf8,
                                     allowLossyConversion: false)!)
        
        // 3
        let lineThree = "Content-Type: image/jpg\r\n\r\n"
        fullData.append(lineThree.data(using:
            String.Encoding.utf8,
                                       allowLossyConversion: false)!)
        
        // 4
        
        let data = UIImageJPEGRepresentation(self, 1.0)!
        fullData.append(data)
        
        // 5
        let lineFive = "\r\n"
        fullData.append(lineFive.data(using:
            String.Encoding.utf8,
                                      allowLossyConversion: false)!)
        
        // 6 - The end. Notice -- at the start and at the end
        let lineSix = "--" + boundary + "--\r\n"
        fullData.append(lineSix.data(using:
            String.Encoding.utf8,
                                     allowLossyConversion: false)!)
        
        return fullData
    }
}
