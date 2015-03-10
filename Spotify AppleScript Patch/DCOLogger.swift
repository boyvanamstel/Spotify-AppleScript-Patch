//
//  DCOLogger.swift
//  Spotify AppleScript Patch
//
//  Created by Boy van Amstel on 10/03/15.
//  Copyright (c) 2015 Danger Cove. All rights reserved.
//

import Foundation

class DCOLogger {

    class func log(message: String) {
        #if DEBUG
            NSLog(message);
        #endif
    }
        
}