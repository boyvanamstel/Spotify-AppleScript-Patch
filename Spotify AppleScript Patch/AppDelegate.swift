//
//  AppDelegate.swift
//  Spotify AppleScript Patch
//
//  Created by Boy van Amstel on 10/03/15.
//  Copyright (c) 2015 Danger Cove. All rights reserved.
//

import Cocoa

import CocoaLumberjack

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application

        // Setup logging
        #if DEBUG
            defaultDebugLevel = DDLogLevel.All
        #else
            defaultDebugLevel = DDLogLevel.Warning
        #endif
        DDLog.addLogger(DDTTYLogger.sharedInstance())
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }

}

