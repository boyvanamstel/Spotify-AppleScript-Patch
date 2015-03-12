//
//  ViewController.swift
//  Spotify AppleScript Patch
//
//  Created by Boy van Amstel on 10/03/15.
//  Copyright (c) 2015 Danger Cove. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  
  @IBOutlet weak var spotifyIconImageView: NSImageView?
  @IBOutlet weak var statusTextField: NSTextField?

  @IBAction func patch(sender: NSButton) {
    
    if self.patcher.patch() {
      self.patchingEnabled = self.patcher.needsPatch
    }
  }
  
  @IBAction func toggleShouldBackup(sender: NSButton) {
    
    if sender.state == 1 {
      self.patcher.shouldCreateBackup = true
    } else {
      self.patcher.shouldCreateBackup = false
    }
  }

  var patcher = Patcher()
  var patchingEnabled: Bool = false {
    willSet {
      
      self.willChangeValueForKey("patchingEnabled")
    }
    didSet {
      
      if self.patchingEnabled {
        self.statusTextField?.stringValue = "Needs to be patched"
      } else {
        self.statusTextField?.stringValue = "AppleScript is enabled!"
      }
      self.didChangeValueForKey("patchingEnabled")
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    if self.patcher.isInstalled {
      self.spotifyIconImageView?.image = self.patcher.appImage
      self.patchingEnabled = self.patcher.needsPatch
    } else {
      self.statusTextField?.stringValue = "Spotify is not installed"
    }
  }
  
  override var representedObject: AnyObject? {
    didSet {
      // Update the view, if already loaded.
    }
  }
  
}

