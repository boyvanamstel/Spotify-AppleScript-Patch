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
  @IBOutlet weak var patchButton: NSButton?
  
  @IBAction func patch(sender: NSButton) {
    
    var patcher = Patcher()
    patcher.patch()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    var patcher = Patcher()
    
    if patcher.isInstalled {

      self.spotifyIconImageView?.image = patcher.appImage
      
      if patcher.needsPatch {
        self.statusTextField?.stringValue = "Needs to be patched"
        self.patchButton?.enabled = true
      } else {
        self.statusTextField?.stringValue = "No patching required!"
        self.patchButton?.enabled = false
      }
      
    } else {
      self.statusTextField?.stringValue = "Spotify is not installed"
      self.patchButton?.enabled = false
    }
  }
  
  override var representedObject: AnyObject? {
    didSet {
      // Update the view, if already loaded.
    }
  }
  
}

