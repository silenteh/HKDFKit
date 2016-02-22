//
//  HKDFKit.swift
//  HKDFKit
//
//  Created by silenteh on 06/02/16.
//  Copyright © 2016 silenteh. All rights reserved.
//

import Foundation
import CommonCrypto

public class HKDFKit {
    
    // MARK: - Types
    
    public enum Hash {
        case SHA256
        case SHA384
        case SHA512
        case SHA224
        
        public var function: CCHmacAlgorithm {
            switch self {
            case .SHA224: return CCHmacAlgorithm(kCCHmacAlgSHA224)
            case .SHA256: return CCHmacAlgorithm(kCCHmacAlgSHA256)
            case .SHA384: return CCHmacAlgorithm(kCCHmacAlgSHA384)
            case .SHA512: return CCHmacAlgorithm(kCCHmacAlgSHA512)
            }
        }
        
        public var length: Int {
            switch self {
            case .SHA224: return Int(CC_SHA224_DIGEST_LENGTH)
            case .SHA256: return Int(CC_SHA256_DIGEST_LENGTH)
            case .SHA384: return Int(CC_SHA384_DIGEST_LENGTH)
            case .SHA512: return Int(CC_SHA512_DIGEST_LENGTH)
            }
        }
    }

    /**
     *  Standard HKDF implementation. http://tools.ietf.org/html/rfc5869
     *
     *  @param algorithm  Hash.[SHA256,SHA224,SHA384,SHA512]
     *  @param seed       Original keying material
     *  @param info       Expansion "salt"
     *  @param salt       Extraction salt
     *  @param outputSize Size of the output
     *
     *  @return The derived key material
     */
    static func deriveKey(algorithm: Hash, seed:NSData, info:NSData, salt:NSData, outputSize:Int) -> NSData {
        return deriveKey(algorithm, seed:seed, info:info, salt:salt, outputSize:outputSize, offset:1)
    }
    
    /**
    *  TextSecure v2 HKDF implementation
    *
    *  @param algorithm  Hash.[SHA256,SHA224,SHA384,SHA512]
    *  @param seed       Original keying material
    *  @param info       Expansion "salt"
    *  @param salt       Extraction salt
    *  @param outputSize Size of the output
    *
    *  @return The derived key material
    */
    
    static func TextSecureV2deriveKey(algorithm: Hash, seed:NSData, info:NSData, salt:NSData, outputSize:Int) -> NSData {
        return deriveKey(algorithm, seed:seed, info:info, salt:salt, outputSize:outputSize, offset:0)
    }
    
    // MARK: - Private Methods
    private static func deriveKey(algorithm: Hash,
        seed:NSData, info:NSData, salt:NSData, outputSize:Int, offset:Int) -> NSData {
            
        // extract phase
        let prk:NSData = extract(algorithm, key: seed, salt: salt)
            
        // expand phase
        let okm:NSData = expand(algorithm, prk: prk, info: info, outputSize: outputSize, offset: offset)
        return okm;
    }
    
    internal static func extract(algorithm: Hash, key:NSData, salt:NSData) -> NSData {
        
        // simpler variant
        //var prk = [CChar](count:algorithm.length, repeatedValue: 0)
        
        // malloc the pointer
        let prk = UnsafeMutablePointer<CChar>.alloc(algorithm.length)
        // initialize the pointer so that it does nto contain garbage
        prk.initialize(0)        
        
        CCHmac(algorithm.function, salt.bytes, salt.length, key.bytes, key.length, prk);
        
        let result = NSData(bytes: prk, length: algorithm.length)
        
        // destroy the pointer (we clean up the memory)
        prk.destroy()
        // free the pointer
        prk.dealloc(algorithm.length)
        
        return result
        
    }

    // prk = pseudo random key. Please note this is NOT a password !!!
    internal static func expand(algorithm: Hash, prk:NSData, info:NSData, outputSize:Int, offset:Int) -> NSData {
        // calculate N in T(N)
        let iterations = Int(ceil(Double(outputSize)/Double(algorithm.length)))
        
        var mixin = NSData()
        
        let results = NSMutableData()

        var index: Int
        for index = offset; index < iterations + offset; ++index {
            
            let hmac = HMAC(algorithm: algorithm, key: prk)
        
            // T(0) = empty string | info | index
            if index != 1 {
                hmac.updateWithData(mixin)
            }
            
            if info.length > 0 {
                hmac.updateWithData(info)
            }
            
            let counter = NSData(bytes: &index, length: 1)
            
            hmac.updateWithData(counter)
        
            let stepResult = NSData(bytes:hmac.finalData().bytes, length:hmac.finalData().length)
            
            results.appendData(stepResult)
            mixin = stepResult.copy() as! NSData
        }

        return NSData(data: results).subdataWithRange(NSMakeRange(0, outputSize))
    }
    
}



