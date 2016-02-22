//
//  NSData+HexString.swift
//  HKDFKit
//
//  Created by silenteh on 07/02/16.
//  Copyright © 2016 silenteh. All rights reserved.
//

import Foundation

extension String {
    
    public func dataFromHexString() -> NSData {
        var bytes = [UInt8]()
        for i in 0..<(self.characters.count/2) {
            let stringBytes = self.substringWithRange(Range(start:self.startIndex.advancedBy(2*i), end:self.startIndex.advancedBy(2*i+2)))
            let byte = strtol((stringBytes as NSString).UTF8String, nil, 16)
            bytes.append(UInt8(byte))
        }

        return NSData(bytes:bytes, length:bytes.count)
    }
}

extension NSData {
    
    func toHexString() -> String {
        
        var hexString: String = ""
        let dataBytes =  UnsafePointer<CUnsignedChar>(self.bytes)
        
        for (var i: Int=0; i<self.length; ++i) {
            hexString +=  String(format: "%02x", dataBytes[i])
        }
        
        return hexString
    }
}
