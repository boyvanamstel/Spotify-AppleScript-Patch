//
//  Patcher.swift
//  Spotify AppleScript Patch
//
//  Created by Boy van Amstel on 11/03/15.
//  Copyright (c) 2015 Danger Cove. All rights reserved.
//

import Cocoa

class Patcher: NSObject {
  
  var isInstalled: Bool {
    get {
      return spotifyPath != nil
    }
  }
  
  var needsPatch: Bool {
    get {
      
      if let info = self.info {
        
        if let sdefFilename: AnyObject = info.valueForKey("OSAScriptingDefinition") {
          
          let sdefPath: String? = self.spotifyPath?.stringByAppendingPathComponent("/Contents/Resources/\(sdefFilename)")
          
          let manager = NSFileManager.defaultManager()
          var isDir: ObjCBool = false
          if !manager.fileExistsAtPath(sdefPath!, isDirectory: &isDir) {
            return true
          }
        }
      }
      return false
    }
  }
  
  var info: NSDictionary? {
    get {
      
      if let plistPath = self.plistPath {
        
        let dict = NSDictionary(contentsOfFile: plistPath)
        return dict
      }
      return nil
    }
  }
  
  var appImage: NSImage? {
    get {
      
      if let info = self.info {
        
        if let iconFilename: AnyObject = info.valueForKey("CFBundleIconFile") {
        
          let imagePath = self.spotifyPath?.stringByAppendingPathComponent("/Contents/Resources/\(iconFilename)")
          
          return NSImage(contentsOfFile: imagePath!)
        }
      }
      return nil
    }
  }
  
  func patch() -> Bool {
    
    if !self.needsPatch {
      DCOLogger.log("Patching not required")
      return false
    }
    
    if let oddSdefPath = self.oddSdefPath {
      if let sdefPath = self.sdefPath {
        
      }
    }
    
    return false
  }
  
  private var spotifyPath: String? {
    get {
      
      let manager = NSFileManager.defaultManager()
      // Find Spotify in /Applications
      let paths: [String] = ["~/Applications/Spotify.app".stringByExpandingTildeInPath, "/Applications/Spotify.app"]
      var isDir: ObjCBool = true
      var spotifyPath: String?
      
      for path in paths {
        
        // Check if Spotify exists at the path
        if manager.fileExistsAtPath(path, isDirectory: &isDir) {
          spotifyPath = path
          break // Quit loop
        }
      }

      return spotifyPath
    }
  }
  
  private var sdefPath:String? {
    get {
    
      if let spotifyPath = self.spotifyPath {
        if let info = self.info {
          
          if let sdefFilename: AnyObject = info.valueForKey("OSAScriptingDefinition") {
            
            return spotifyPath.stringByAppendingPathComponent("/Contents/Resources/\(sdefFilename)")
          }
        }
      }
      return nil
    }
  }
  
  private var oddSdefPath: String? {
    get {
      
      if let spotifyPath = self.spotifyPath {
        
        let oddSdefPath = spotifyPath.stringByAppendingPathComponent("/Contents/Resources/applescript/Spotify.sdef")
        
        let manager = NSFileManager.defaultManager()
        var isDir: ObjCBool = false
        if manager.fileExistsAtPath(oddSdefPath, isDirectory: &isDir) {
          return oddSdefPath
        }
      }
      return nil
    }
  }
  
  private var plistPath: NSString? {
    get {
      
      if let spotifyPath = self.spotifyPath {
        
        let plistPath: String? = spotifyPath.stringByAppendingPathComponent("/Contents/Info.plist")
        
        let manager = NSFileManager.defaultManager()
        var isDir: ObjCBool = false
        if manager.fileExistsAtPath(plistPath!, isDirectory: &isDir) {
          return plistPath
        }
      }
      return nil
    }
  }
}