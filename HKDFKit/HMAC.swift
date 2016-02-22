//
//  hmac.swift
//  HKDFKit
//
//  Created by silenteh on 07/02/16.
//  Copyright © 2016 silenteh. All rights reserved.
//

import Foundation
import CommonCrypto

public final class HMAC {
    var context: CCHmacContext = CCHmacContext()
    var algorithm:HKDFKit.Hash
    
    init(algorithm: HKDFKit.Hash, key: NSData) {
        self.algorithm = algorithm
        CCHmacInit(
            &context,
            algorithm.function,
            key.bytes,
            key.length
        )
    }
    
    func updateWithData(data: NSData) {
        CCHmacUpdate(&context, data.bytes, data.length)
    }
    
    func finalData() -> NSData {
        let hmac = NSMutableData(length: algorithm.length)!
        CCHmacFinal(&context, hmac.mutableBytes)
        return hmac
    }
}
