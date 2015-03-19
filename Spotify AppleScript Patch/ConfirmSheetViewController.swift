//
//  ConfirmSheetViewController.swift
//  Spotify AppleScript Patch
//
//  Created by Boy van Amstel on 18/03/15.
//  Copyright (c) 2015 Danger Cove. All rights reserved.
//

import Cocoa

class ConfirmSheetViewController: NSViewController {
  
  @IBOutlet weak var patchButton: NSButton?
  
  var patcher = Patcher.sharedInstance
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let patchButtonCell: TextButtonCell = self.patchButton?.cell() as TextButtonCell
    patchButtonCell.textColor = NSColor.whiteColor()
  }
  
  @IBAction func patch(sender: NSButton) {
    
    if patcher.patch() {
      self.dismissController(self)
    }
  }
  
}
