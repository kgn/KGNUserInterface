//
//  Style.swift
//  Vesting
//
//  Created by David Keegan on 1/11/15.
//  Copyright (c) 2015 David Keegan. All rights reserved.
//

import UIKit
import KGNColor
import NSDateTimeAgo
import KGNGradientView

/// CGFloat value for Pi
public let π = CGFloat(M_PI)

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

    /// Color statics
    public struct Color {

        /// Pure white color
        public static let White = UIColor.whiteColor()

        /// Pure black color
        public static let Black = UIColor.blackColor()

        /// Clear white color with 0 alpha
        public static let ClearWhite = White.colorWithAlphaComponent(0)

        /// Clear black color with 0 alpha
        public static let ClearBlack = Black.colorWithAlphaComponent(0)

    }

    /// Gradient statics
    public struct Gradient {

        /// Gradient going from black to white
        public static let BlackAndWhite = KGNGradientView.Gradient(startColor: Color.Black, endColor: Color.White)

        /// Gradient going from clear white to opaque white
        public static let ClearWhite = KGNGradientView.Gradient(startColor: Color.ClearWhite, endColor: Color.White)

        /// Gradient going from clear black to opaque black
        public static let ClearBlack = KGNGradientView.Gradient(startColor: Color.ClearBlack, endColor: Color.Black)

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
        /// Based on the iOS 7 4px grid
        public static let SmallPadding: CGFloat = 4

        /// Base padding size: 10 point
        /// Based on the iOS 7 4px grid
        public static let Padding: CGFloat = 8

        /// Base large padding size: 20 point
        /// Based on the iOS 7 4px grid
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
        public static let MaxInstagramSize: CGFloat = 1080
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
        public static func Date(date: NSDate, includeTime: Bool = false, calanderIdentifier: String = NSCalendarIdentifierGregorian) -> String? {
            var dateString = date.timeAgo

            guard let calander = NSCalendar(identifier: calanderIdentifier) else {
                return nil
            }

            let components = calander.components(.Month, fromDate: date)
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
