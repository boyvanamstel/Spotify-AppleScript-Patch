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
  @IBOutlet weak var patchButton: NSButton?
  @IBOutlet weak var createBackupButton: NSButton?
  
  @IBAction func toggleShouldBackup(sender: NSButton) {
    
    if sender.state == 1 {
      self.patcher.shouldCreateBackup = true
    } else {
      self.patcher.shouldCreateBackup = false
    }
  }

  var patcher = Patcher.sharedInstance
  var patchingEnabled: Bool = false {
    willSet {
      
      self.willChangeValueForKey("patchingEnabled")
    }
    didSet {
      
      if self.patchingEnabled {
        self.patchButton?.title = "Apply Patch..."
      } else {
        self.patchButton?.title = "All Done!"
      }
      self.didChangeValueForKey("patchingEnabled")
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.

    // Observe
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "patchStatusUpdated", name: "patchStatusUpdate", object: nil)
    
    // Setup design
    let patchButtonCell: TextButtonCell = self.patchButton?.cell() as TextButtonCell
    patchButtonCell.textColor = NSColor.whiteColor()
    
    if self.patcher.isInstalled {
      self.spotifyIconImageView?.image = self.patcher.appImage
      self.patchingEnabled = self.patcher.needsPatch
    } else {
      self.patchButton?.title = "Spotify Not Found"
    }
    
    // Set default value for creating a backup
    if let createBackupButton = self.createBackupButton {
      self.toggleShouldBackup(createBackupButton)
    }
  }

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override var representedObject: AnyObject? {
    didSet {
      // Update the view, if already loaded.
    }
  }
  
  func patchStatusUpdated() {
    self.patchingEnabled = self.patcher.needsPatch
  }
  
}

