//
//  Patcher.swift
//  Spotify AppleScript Patch
//
//  Created by Boy van Amstel on 11/03/15.
//  Copyright (c) 2015 Danger Cove. All rights reserved.
//

import Cocoa

class Patcher: NSObject {
  
  class var sharedInstance: Patcher {
    struct Singleton {
      static let instance = Patcher()
    }
    return Singleton.instance
  }
  
  var shouldCreateBackup: Bool = false
  
  var debugMode: Bool {
    get {
      
      let theFlags = NSEvent.modifierFlags() & NSEventModifierFlags.AlternateKeyMask;
      return theFlags.rawValue != 0
    }
  }
  
  var isInstalled: Bool {
    get {
      
      if self.debugMode {
        return true
      }

      return spotifyPath != nil
    }
  }
  
  var needsPatch: Bool {
    get {

      if self.debugMode {
        return true
      }
      
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
    
    if !self.needsPatch && !self.debugMode {
      DCOLogger.error("[Patcher] patching not required, or Spotify not found")
      return false
    }
    
    if self.shouldCreateBackup {
      if !self.backup() {
        return false
      }
    }
    
//    if !self.killSpotify() {
//      return false
//    }

    var info = self.info?.mutableCopy() as NSMutableDictionary
    info.setValue(self.newSdefValue, forKey: "OSAScriptingDefinition")

    if let plistPath = self.plistPath {
      let manager = NSFileManager.defaultManager()
      var error: NSError?
      if !manager.removeItemAtPath(plistPath, error: &error) {
        DCOLogger.error("[Patcher] failed to remove existing Info.plist file")
        return false
      }
      self.willChangeValueForKey("needsPatch")
      let success = info.writeToFile(plistPath, atomically: true)
      self.didChangeValueForKey("needsPatch")
      return success
    }
    return false
  }
  
  private func killSpotify() -> Bool {
    
    
    return false
  }
  
  private func launchSpotify() -> Bool {
    return false
  }
  
  private func backup() -> Bool {
    
    if let plistPath = self.plistPath {
      
      let desktopPath = "~/Desktop/Info.plist-spotifybackup".stringByExpandingTildeInPath

      let manager = NSFileManager.defaultManager()
      
      if manager.fileExistsAtPath(desktopPath) {
        var removeError: NSError?
        if !manager.removeItemAtPath(desktopPath, error: &removeError) {
          DCOLogger.error("[Patcher] failed to remove existing backup plist file: \(removeError)")
          return false
        }
      }
      
      var copyError: NSError?
      if manager.copyItemAtPath(plistPath, toPath: desktopPath, error: &copyError) {
        return true
      } else {
        DCOLogger.error("[Patcher] failed to backup plist file: \(copyError)")
      }
    }
    return false
  }
  
  private var isSpotifyRunning: Bool {
    return false
  }
  
  private var spotifyPath: String? {
    get {
      
      let spotifyPathURL = NSWorkspace.sharedWorkspace().URLForApplicationWithBundleIdentifier("com.spotify.client")
      return spotifyPathURL?.path
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
  
  private var newSdefPath: String? {
    get {
      
      if let spotifyPath = self.spotifyPath {
        let newSdefPath = spotifyPath.stringByAppendingPathComponent("/Contents/Resources/applescript/Spotify.sdef")
        let manager = NSFileManager.defaultManager()
        var isDir: ObjCBool = false
        if manager.fileExistsAtPath(newSdefPath, isDirectory: &isDir) {
          return newSdefPath
        }
      }
      return nil
    }
  }
  
  private var newSdefValue: String? {
    get {
      
      if let spotifyPath = self.spotifyPath {
        if let newSdefPath = self.newSdefPath {
          var newSdefValue = newSdefPath.stringByReplacingOccurrencesOfString(spotifyPath.stringByAppendingPathComponent("/Contents/Resources/"), withString: "")
          if Array(newSdefValue)[0] == "/" {
            return newSdefValue.substringFromIndex(advance(newSdefValue.startIndex, 1))
          } else {
            return newSdefValue
          }
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