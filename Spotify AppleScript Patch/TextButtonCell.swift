//
//  TextButtonCell.swift
//  Spotify AppleScript Patch
//
//  Created by Boy van Amstel on 18/03/15.
//  Copyright (c) 2015 Danger Cove. All rights reserved.
//

import Cocoa

class TextButtonCell: NSButtonCell {
  
  var textColor: NSColor?
  
  func attributedStringWithColor(attributedString: NSAttributedString, color: NSColor) -> NSAttributedString {
    
    // Create mutable copy
    var mutableString = attributedString.mutableCopy() as NSMutableAttributedString
    
    // Set alignment
    let paragrahStyle = NSMutableParagraphStyle()
    paragrahStyle.alignment = NSTextAlignment.CenterTextAlignment
    
    let range = NSMakeRange(0, mutableString.length);
    
    // Set alignment
    mutableString.addAttribute(NSParagraphStyleAttributeName, value: paragrahStyle, range: range)
    
    // Set color
    if self.textColor != nil {
      mutableString.addAttribute(NSForegroundColorAttributeName, value: self.textColor!, range: range)
    }
    
    return mutableString.copy() as NSAttributedString
  }
  
  override func drawBezelWithFrame(frame: NSRect, inView controlView: NSView) {
    // Draw nothing
    
    self.attributedTitle = self.attributedStringWithColor(self.attributedTitle, color: NSColor.whiteColor())
  }
}
