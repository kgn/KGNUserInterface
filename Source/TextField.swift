//
//  TextField.swift
//  KGNUserInterface
//
//  Created by David Keegan on 10/29/15.
//  Copyright © 2015 David Keegan. All rights reserved.
//

import UIKit
import KGNPreferredFontManager

/// Subclass of `PreferredFontTextField`. This implementation also allows
/// the text color to be set by `Label.appearance().textColor`.
public class TextField: PreferredFontTextField {

    override public func setup() {
        super.setup()

        self.textColor = TextField.appearance().textColor
    }

}
