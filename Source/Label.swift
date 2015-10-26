//
//  Label.swift
//  Vesting
//
//  Created by David Keegan on 1/11/15.
//  Copyright (c) 2015 David Keegan. All rights reserved.
//

import UIKit
import KGNPreferredFontManager

public class Label: PreferredFontLabel {

    public var intrinsicWidth = true
    public var intrinsicHeight = true

    override public func setup() {
        self.preferredFontManager = Style.PreferredFontManager
        self.textColor = Style.Color.White
        super.setup()
    }

    override public func intrinsicContentSize() -> CGSize {
        var intrinsicContentSize = super.intrinsicContentSize()
        if !self.intrinsicWidth {
            intrinsicContentSize.width = UIViewNoIntrinsicMetric
        }
        if !self.intrinsicHeight {
            intrinsicContentSize.height = UIViewNoIntrinsicMetric
        }
        return intrinsicContentSize
    }

}
