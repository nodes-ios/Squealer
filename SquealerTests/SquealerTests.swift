//
//  SquealerTests.swift
//  SquealerTests
//
//  Created by Jakob Mygind on 21/10/16.
//  Copyright © 2016 nodes. All rights reserved.
//

import XCTest
import SwiftyBeaver
@testable import Squealer


class SquealerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSwiftyBeaverPlugin() {
        
        //Custom tracker
        class SBTracker: Squealable {
            
            var trackingHandler: ((Squealer.Level) -> Void) = { (event) in
                let log = SwiftyBeaver.self
                let cloud = SBPlatformDestination(appID: "foo", appSecret: "bar", encryptionKey: "123") // to cloud
                
                
                switch event {
                case .info(let squeal):
                    log.info(squeal.additionalInfo)
                case .warning(let squeal):
                    log.warning(squeal.additionalInfo)
                case .error(let squeal):
                    log.error(squeal.additionalInfo)
                }
            }
        }
        
        Squealer.add(tracker: SBTracker())
        
        let unfortunateEvent = Squealer.Squeal(message: "It's not good", object: NSData())
        
        Squealer.track(warning: unfortunateEvent)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
