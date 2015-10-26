//
//  Style.swift
//  Vesting
//
//  Created by David Keegan on 1/11/15.
//  Copyright (c) 2015 David Keegan. All rights reserved.
//

import UIKit
import KGNColor
import KGNPreferredFontManager
import NSDateTimeAgo

/// CGFloat value for Pi
public let π = CGFloat(M_PI)

private let preferredFontManager: PreferredFontManager = {
    let preferredFontManager = PreferredFontManager()
    preferredFontManager.registerFontsForTextStyle(UIFontTextStyleHeadline, fontWeight: UIFontWeightUltraLight, baseFontSize: UIFont.systemFontSize()*4, increment: 1, decrement: 1)
    preferredFontManager.registerFontsForTextStyle(UIFontTextStyleSubheadline, fontWeight: UIFontWeightRegular, baseFontSize: UIFont.systemFontSize()*2, increment: 1, decrement: 1)
    preferredFontManager.registerFontsForTextStyle(UIFontTextStyleBody, fontWeight: UIFontWeightRegular, baseFontSize: UIFont.labelFontSize(), increment: 2, decrement: 1)
    preferredFontManager.registerFontsForTextStyle(UIFontTextStyleCaption1, fontWeight: UIFontWeightMedium, baseFontSize: UIFont.systemFontSize(), increment: 1, decrement: 1)
    preferredFontManager.registerFontsForTextStyle(UIFontTextStyleCaption2, fontWeight: UIFontWeightRegular, baseFontSize: UIFont.systemFontSize(), increment: 1, decrement: 1)
    preferredFontManager.registerFontsForTextStyle(UIFontTextStyleFootnote, fontWeight: UIFontWeightRegular, baseFontSize: UIFont.smallSystemFontSize(), increment: 1, decrement: 1)
    return preferredFontManager
}()

private let dateFormatter: NSDateFormatter = {
    let dateFormatter = NSDateFormatter()
    dateFormatter.timeStyle = .NoStyle
    dateFormatter.dateStyle = .LongStyle
    return dateFormatter
}()

private let timeFormatter: NSDateFormatter = {
    let dateFormatter = NSDateFormatter()
    dateFormatter.timeStyle = .ShortStyle
    dateFormatter.dateStyle = .NoStyle
    return dateFormatter
}()

private let numberFormatter: NSNumberFormatter = {
    let numberFormatter = NSNumberFormatter()
    numberFormatter.usesGroupingSeparator = true
    return numberFormatter
}()

/// Base style namespace
public struct Style {

    public static let PreferredFontManager = preferredFontManager
    public static let Calander = NSCalendar(identifier: NSCalendarIdentifierGregorian)!

    /// Color statics
    public struct Color {
        public static let Clear = UIColor.clearColor()
        public static let White = UIColor.whiteColor()
        public static let Black = UIColor.blackColor()
    }

    /// Size statics
    public struct Size {

        /// The scale of the main screen
        public static let ScreenScale: CGFloat = UIScreen.mainScreen().scale

        /// One point
        public static let OnePoint: CGFloat = 1

        /// Half of a point
        public static let HalfPoint: CGFloat = OnePoint/2

        /// One pixel
        public static let OnePixel: CGFloat = OnePoint/ScreenScale

        /// Base small padding size: 4 point
        public static let SmallPadding: CGFloat = 4

        /// Base padding size: 10 point
        public static let Padding: CGFloat = 10

        /// Base large padding size: 20 point
        public static let LargePadding: CGFloat = 20

        /// Standard iOS control size: 44 point
        public static let Control: CGFloat = 44

        /// Base label width: 300 point
        public static let LabelWidth: CGFloat = 300

        /// The width of an iPhone 5 screen in point
        public static let iPhone5Width: CGFloat = 320

        /// The width of an iPhone 6 screen in point
        public static let iPhone6Width: CGFloat = 375

        /// The width of an iPhone 6 Plus screen in point
        public static let iPhone6PlusWidth: CGFloat = 414

        // The native screen width in pixels
        public static let NativeScreenWidth = CGRectGetWidth(UIScreen.mainScreen().nativeBounds)/UIScreen.mainScreen().nativeScale

        // The native screen height in pixels
        public static let NativeScreenHeight = CGRectGetHeight(UIScreen.mainScreen().nativeBounds)/UIScreen.mainScreen().nativeScale

        // The height of the status bar in points
        public static let StatusBarHeight = CGRectGetHeight(UIApplication.sharedApplication().statusBarFrame)

        // The maximum width or height of an Instagram photo in pixels
        public static let MaxInstagramSize = 1080
    }

    /// Animation statics
    public struct Animation {

        /// Base animation duration: 0.25 seconds
        public static let Duration: NSTimeInterval = 0.25

        /// Base animation long duration: 0.5 seconds
        public static let LongDuration: NSTimeInterval = 0.5

        /// Base animation spring dampening: 0.4
        public static let Damping: CGFloat = 0.4

        /// Base animation spring velocity: 0.8
        public static let Velocity: CGFloat = 0.8
    }

    /// Shadow statics
    public struct Shadow {

        /// Base shadow color, defaults to `Style.Color.Black`
        public static let Color: UIColor = Style.Color.Black

        /// Base shadow offset: `{0, 1}`
        public static let Offset: CGSize = CGSizeMake(0, 1)

        /// Base shadow opacity: 0.5
        public static let Opacity: Float = 0.5

        /// Base shadow radius: 3
        public static let Radius: CGFloat = 3

        /**
         Apply the shadow to the view

         - parameter view: The view to apply the shadow to.
         */
        public static func Apply(view: UIView) {
            view.layer.shadowColor = Color.CGColor
            view.layer.shadowOffset = Offset
            view.layer.shadowOpacity = Opacity
            view.layer.shadowRadius = Radius
        }

    }

    /// Format statics
    public struct Format {

        /**
         Returns a formatted string for a date.

         - parameter date: The date object to format.
         - parameter includeTime: Defaults to false, 
         if true time is included in the resulting string object.
         
         - returns: A formatted string for the date.
         */
        public static func Date(date: NSDate, includeTime: Bool = false) -> String? {
            var dateString = date.timeAgo
            let components = Calander.components(.Month, fromDate: date)
            if components.month > 1 {
                dateString = dateFormatter.stringFromDate(date)
            }

            if includeTime {
                let timeString = timeFormatter.stringFromDate(date)
                return NSLocalizedString("\(dateString) at \(timeString)", comment: "Date time label")
            }
            return dateString
        }

        /**
         Returns a formatted string for the given number.

         - parameter number: The number object to format.

         - returns: A formatted string for the number.
         */
        public static func Number(number: NSNumber) -> String? {
            return numberFormatter.stringFromNumber(number)
        }
        
    }

}
