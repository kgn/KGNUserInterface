//
//  Label.swift
//  KGNUserInterface
//
//  Created by David Keegan on 1/11/15.
//  Copyright © 2015 David Keegan. All rights reserved.
//

import UIKit
import KGNPreferredFontManager

/// Subclass of `PreferredFontLabel`. This implementation also allows
/// the text color to be set by `Label.appearance().textColor`.
open class Label: PreferredFontLabel {

    /// The intrinsic content width, if `nil` the super value is used,
    /// `UIViewNoIntrinsicMetric` can also be used used.
    open var intrinsicContentWidth: CGFloat?

    /// The intrinsic content height, if `nil` the super value is used,
    /// `UIViewNoIntrinsicMetric` can also be used used.
    open var intrinsicContentHeight: CGFloat?

    open override func setup() {
        super.setup()

        self.textColor = Label.appearance().textColor
    }

    open override var intrinsicContentSize: CGSize {
        // HACK: the wh > 0 check shouldn't be necessary,
        // but the values are not nil for some reason...
        var intrinsicContentSize = super.intrinsicContentSize
        if let width = self.intrinsicContentWidth, width > 0 {
            intrinsicContentSize.width = width
        }
        if let height = self.intrinsicContentHeight, height > 0{
            intrinsicContentSize.height = height
        }
        return intrinsicContentSize
    }

}
