//
//  NSDataExtensionTest.swift
//  HKDFKit
//
//  Created by silenteh on 08/02/16.
//  Copyright © 2016 silenteh. All rights reserved.
//

import Foundation
import XCTest


class NSDataExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHexToData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let IKM  = "0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b";
        
        let data = IKM.dataFromHexString()
        
        let dataString = data.toHexString()
        
        XCTAssert(dataString == dataString, "Basic hex conversion");
        
    }
    
    func testLeadingZeroHexToData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let IKM  = "000102030405060708090a0b0c";
        
        let data = IKM.dataFromHexString()
        
        let dataString = data.toHexString()
        
        XCTAssert(dataString == dataString, "Basic hex conversion");
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}

