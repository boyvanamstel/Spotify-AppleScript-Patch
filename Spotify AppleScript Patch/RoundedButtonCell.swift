//
//  RoundedButton.swift
//  Spotify AppleScript Patch
//
//  Created by Boy van Amstel on 16/03/15.
//  Copyright (c) 2015 Danger Cove. All rights reserved.
//

import Cocoa

class RoundedButtonCell: TextButtonCell {
  
  override func drawingRectForBounds(theRect: NSRect) -> NSRect {

    return super.drawingRectForBounds(NSInsetRect(theRect, 8.0 * 2, 0.0))
  }
  
  override func drawBezelWithFrame(frame: NSRect, inView controlView: NSView) {
    
    if self.enabled == false {
      SpotifyASPatchStyleKit.drawRoundedButton(frame: frame, withBackgroundColor: SpotifyASPatchStyleKit.actionColorDisabled)
    } else if self.highlighted {
      SpotifyASPatchStyleKit.drawRoundedButton(frame: frame, withBackgroundColor: SpotifyASPatchStyleKit.actionColorHighlighted)
    } else {
      SpotifyASPatchStyleKit.drawRoundedButton(frame: frame, withBackgroundColor: SpotifyASPatchStyleKit.actionColor)
    }
    
    self.attributedTitle = self.attributedStringWithColor(self.attributedTitle, color: NSColor.whiteColor())
  }
}
