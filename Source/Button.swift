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

    /// The intrinsic width, if `nil` the super value is used,
    /// `UIViewNoIntrinsicMetric` can also be used used.
    public var intrinsicWidth: CGFloat?

    /// The intrinsic height, if `nil` the super value is used,
    /// `UIViewNoIntrinsicMetric` can also be used used.
    public var intrinsicHeight: CGFloat?

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

    /**
     Create a button object with a title of type `System`.

     - parameter title: The title of the button.
     - parameter target: The target for the button action.
     - parameter action: The selector on the target for the button action.
     - parameter forControlEvents: The control events to trigger the button action.
     Defaults to `TouchUpInside`.

     - returns: The button object.
     */
    public class func systemButton(title title: String, target: AnyObject?, action: Selector, forControlEvents events: UIControlEvents = .TouchUpInside) -> Self {
        let button = self.init(type: .System)
        button.title = title
        button.addTarget(target, action: action, forControlEvents: events)
        return button
    }

    /**
     Create a button object with a title of type `System`.

     - parameter imageNamed: The name of the image file.
     - parameter target: The target for the button action.
     - parameter action: The selector on the target for the button action.
     - parameter forControlEvents: The control events to trigger the button action.
     Defaults to `TouchUpInside`.

     - returns: The button object.
     */
    public class func systemButton(imageNamed imageNamed: String, target: AnyObject?, action: Selector, forControlEvents events: UIControlEvents = .TouchUpInside) -> Self {
        let button = self.init(type: .System)
        button.image = UIImage(named: imageNamed)
        button.addTarget(target, action: action, forControlEvents: events)
        return button
    }

    override public func setup() {
        super.setup()
    }

    override public func intrinsicContentSize() -> CGSize {
        var intrinsicContentSize = super.intrinsicContentSize()
        if let intrinsicWidth = self.intrinsicWidth {
            intrinsicContentSize.width = intrinsicWidth
        }
        if let intrinsicHeight = self.intrinsicHeight {
            intrinsicContentSize.height = intrinsicHeight
        }
        return intrinsicContentSize
    }

}
