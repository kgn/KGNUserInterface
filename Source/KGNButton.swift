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
/// Note: named KGNButton to not conflict with other libraries named Button...
open class KGNButton: PreferredFontButton {

    /// The intrinsic content width, if `nil` the super value is used,
    /// `UIViewNoIntrinsicMetric` can also be used used.
    open var intrinsicContentWidth: CGFloat?
    
    /// The intrinsic content height, if `nil` the super value is used,
    /// `UIViewNoIntrinsicMetric` can also be used used.
    open var intrinsicContentHeight: CGFloat?

    /// Helper property that sets the button title for the `Normal` state
    open var title: String? {
        get {
            return self.title(for: [])
        }

        set(title) {
            self.setTitle(title, for: [])
        }
    }

    /// Helper property that sets the button image for the `Normal` state
    open var image: UIImage? {
        get {
            return self.image(for: [])
        }

        set(image) {
            self.setImage(image, for: [])
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
    open class func systemButton(withTitle title: String, target: AnyObject?, action: Selector, forControlEvents events: UIControlEvents = .touchUpInside) -> Self {
        let button = self.init(type: .system)
        button.title = title
        button.addTarget(target, action: action, for: events)
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
    open class func systemButton(imageNamed name: String, target: AnyObject?, action: Selector, forControlEvents events: UIControlEvents = .touchUpInside) -> Self {
        let button = self.init(type: .system)
        button.image = UIImage(named: name)
        button.addTarget(target, action: action, for: events)
        return button
    }

    open override func setup() {
        super.setup()
    }
    
    open override var intrinsicContentSize: CGSize {
        var intrinsicContentSize = super.intrinsicContentSize
        if let width = self.intrinsicContentWidth {
            intrinsicContentSize.width = width
        }
        if let height = self.intrinsicContentHeight {
            intrinsicContentSize.height = height
        }
        return intrinsicContentSize
    }

}
