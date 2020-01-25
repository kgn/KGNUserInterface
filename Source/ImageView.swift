//
//  UIImageView+Extension.swift
//  KGNUserInterface
//
//  Created by David Keegan on 11/12/15.
//  Copyright © 2015 David Keegan. All rights reserved.
//

import UIKit

open class ImageView: UIImageView {

    /// The intrinsic width, if `nil` the super value is used,
    /// `UIViewNoIntrinsicMetric` can also be used used.
    open var intrinsicContentWidth: CGFloat?

    /// The intrinsic height, if `nil` the super value is used,
    /// `UIViewNoIntrinsicMetric` can also be used used.
    open var intrinsicContentHeight: CGFloat?

    open override var intrinsicContentSize: CGSize {
        return CGSize(
            width: self.intrinsicContentWidth ?? super.intrinsicContentSize.width,
            height: self.intrinsicContentHeight ?? super.intrinsicContentSize.height
        )
    }
}

extension UIImageView {

    /**
    Create an image view object with an image name and optional content mode.

    - parameter imageNamed: The name of the image file.
    - parameter contentMode: The content mode for the image view.
     Defaults to `nil` which uses the default content mode of the image view.

    - returns: The image view object.
    */
    public convenience init(imageNamed: String, contentMode: UIView.ContentMode? = nil) {
        self.init(image: UIImage(named: imageNamed))
        if contentMode != nil {
            self.contentMode = contentMode!
        }
    }

}
