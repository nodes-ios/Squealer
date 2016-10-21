//
//  Squealer.swift
//  Squealer
//
//  Created by Jakob Mygind on 21/10/16.
//  Copyright © 2016 nodes. All rights reserved.
//

import Foundation

public protocol Squealable : class {
    var trackingHandler:((Squealer.Level) -> Void) {get}
}

public class Squealer {
    
    public class Squeal {
        var date = Date()
        var eventObject: Any?
        var additionalInfo: String?
        var error: Error?
        
        convenience init(message: String? = nil, object:Any? = nil, error: Error? = nil) {
            self.init()
            additionalInfo = message ?? additionalInfo
            eventObject = object ?? eventObject
            self.error = error ?? error
        }
    }
    
    public enum Level {
        case error(Squeal)
        case warning(Squeal)
        case info(Squeal)
    }
    
    fileprivate var trackers = [Squealable]()
    
    fileprivate static let sharedInstance = Squealer()
    
    public static func add(tracker: Squealable) {
        sharedInstance.trackers.append(tracker)
    }
    
    public static func clearTrackers() {
        sharedInstance.trackers = []
    }
    
    public static func track(warning: Squeal) {
        track(event: .warning(warning))
    }
    
    public static func track(error: Squeal) {
        track(event: .error(error))
    }
    
    public static func track(info: Squeal) {
        track(event: .info(info))
    }
    
    private static func track(event: Level) {
        sharedInstance.trackers.forEach {$0.trackingHandler(event); print("hej") }
    }
}
