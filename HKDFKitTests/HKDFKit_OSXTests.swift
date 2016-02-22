//
//  HKDFKitTests.swift
//  HKDFKitTests
//
//  Created by silenteh on 06/02/16.
//  Copyright © 2016 silenteh. All rights reserved.
//

import XCTest
@testable import HKDFKit

class HKDFKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFirstRFCExample() {
        
        let IKM  = "0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b"
        let salt = "000102030405060708090a0b0c"
        let info = "f0f1f2f3f4f5f6f7f8f9"
        let l    = 42
        
        let OKM  = "3cb25f25faacd57a90434f64d0362f2a2d2d0a90cf1a5a4c5db02d56ecc4c5bf34007208d5b887185865"
        
        let hkdf:NSData = HKDFKit.deriveKey(HKDFKit.Hash.SHA256, seed: IKM.dataFromHexString(), info: info.dataFromHexString(), salt: salt.dataFromHexString(), outputSize: l)
        
        XCTAssert(hkdf.toHexString() == OKM, "First RFC test case with SHA-256")
        
        HKDFKit.TextSecureV2deriveKey(<#T##algorithm: HKDFKit.Hash##HKDFKit.Hash#>, seed: <#T##NSData#>, info: <#T##NSData#>, salt: <#T##NSData#>, outputSize: <#T##Int#>)
        
    }
    
    func testSecondRFCExample() {
        
        let IKM  = "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f303132333435363738393a3b3c3d3e3f404142434445464748494a4b4c4d4e4f"
        
        let salt = "606162636465666768696a6b6c6d6e6f707172737475767778797a7b7c7d7e7f808182838485868788898a8b8c8d8e8f909192939495969798999a9b9c9d9e9fa0a1a2a3a4a5a6a7a8a9aaabacadaeaf"
        
        let info = "b0b1b2b3b4b5b6b7b8b9babbbcbdbebfc0c1c2c3c4c5c6c7c8c9cacbcccdcecfd0d1d2d3d4d5d6d7d8d9dadbdcdddedfe0e1e2e3e4e5e6e7e8e9eaebecedeeeff0f1f2f3f4f5f6f7f8f9fafbfcfdfeff"
        
        let l    = 82
        
        let OKM  = "b11e398dc80327a1c8e7f78c596a49344f012eda2d4efad8a050cc4c19afa97c59045a99cac7827271cb41c65e590e09da3275600c2f09b8367793a9aca3db71cc30c58179ec3e87c14c01d5c1f3434f1d87"
        
        let hkdf:NSData = HKDFKit.deriveKey(HKDFKit.Hash.SHA256, seed: IKM.dataFromHexString(), info: info.dataFromHexString(), salt: salt.dataFromHexString(), outputSize: l)
        
        XCTAssert(hkdf.toHexString() == OKM, "Second RFC test case with SHA-256")
        
    }
    
    func testThirdRFCExample() {
        
        let IKM  = "0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b"
        let salt = NSData()
        let info = NSData()
        let l    = 42
        
        let OKM  = "8da4e775a563c18f715f802a063c5a31b8a11f5c5ee1879ec3454e5f3c738d2d9d201395faa4b61a96c8"
        
        let hkdf:NSData = HKDFKit.deriveKey(HKDFKit.Hash.SHA256, seed: IKM.dataFromHexString(), info: info, salt: salt, outputSize: l)
        
        XCTAssert(hkdf.toHexString() == OKM, "Third RFC test case with SHA-256")
        
    }
    
    // 0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
