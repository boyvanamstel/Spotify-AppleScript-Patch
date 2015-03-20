//
//  DCOLogger.swift
//  Spotify AppleScript Patch
//
//  Created by Boy van Amstel on 10/03/15.
//  Copyright (c) 2015 Danger Cove. All rights reserved.
//

import Foundation

class DCOLogger {
  
  class func verbose(message: String) {
    #if DEBUG
      NSLog(message);
    #endif
  }
  
  class func warn(message: String) {
    NSLog(message);
  }
  
  class func error(message: String) {
    NSLog(message);
  }
  
  class func info(message: String) {
    NSLog(message);
  }
  
}