//
//  Button.swift
//  KGNUserInterface
//
//  Created by David Keegan on 1/11/15.
//  Copyright © 2015 David Keegan. All rights reserved.
//

import UIKit
import KGNPreferredFontManager

/// Subclass of `PreferredFontButton`.
public class Button: PreferredFontButton {

    /// Helper property that sets the button title for the `Normal` state
    public var title: String? {
        get {
            return self.titleForState(.Normal)
        }

        set(title) {
            self.setTitle(title, forState: .Normal)
        }
    }

    /// Helper property that sets the button image for the `Normal` state
    public var image: UIImage? {
        get {
            return self.imageForState(.Normal)
        }

        set(image) {
            self.setImage(image, forState: .Normal)
        }
    }

    override public func setup() {
        super.setup()
    }

}
