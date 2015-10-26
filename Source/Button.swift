//
//  Button.swift
//  Vesting
//
//  Created by David Keegan on 1/11/15.
//  Copyright (c) 2015 David Keegan. All rights reserved.
//

import UIKit
import KGNPreferredFontManager

/// Subclass of `PreferredFontButton` that registers 
/// `Style.PreferredFontManager` as the preferred font manger.
public class Button: PreferredFontButton {

    override public func setup() {
        self.preferredFontManager = Style.PreferredFontManager
        self.tintColor = Style.Color.Tint
        super.setup()
    }

}
