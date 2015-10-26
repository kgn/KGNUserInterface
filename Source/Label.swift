//
//  Label.swift
//  Vesting
//
//  Created by David Keegan on 1/11/15.
//  Copyright (c) 2015 David Keegan. All rights reserved.
//

import UIKit
import KGNPreferredFontManager

/// Subclass of `PreferredFontLabel` that registers
/// `Style.PreferredFontManager` as the preferred font manger.
public class Label: PreferredFontLabel {

    /// Allow intrinsic width, if `false` `UIViewNoIntrinsicMetric` is used.
    public var allowIntrinsicWidth = true

    /// Allow intrinsic height, if `false` `UIViewNoIntrinsicMetric` is used.
    public var allowIntrinsicHeight = true

    override public func setup() {
        self.preferredFontManager = Style.PreferredFontManager
        super.setup()
    }

    override public func intrinsicContentSize() -> CGSize {
        var intrinsicContentSize = super.intrinsicContentSize()
        if !self.allowIntrinsicWidth {
            intrinsicContentSize.width = UIViewNoIntrinsicMetric
        }
        if !self.allowIntrinsicHeight {
            intrinsicContentSize.height = UIViewNoIntrinsicMetric
        }
        return intrinsicContentSize
    }

}
