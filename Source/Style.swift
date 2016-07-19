//
//  Style.swift
//  KGNUserInterface
//
//  Created by David Keegan on 1/11/15.
//  Copyright © 2015 David Keegan. All rights reserved.
//

import UIKit
import KGNColor
import NSDateTimeAgo
import KGNGradientView

/// CGFloat value for Pi
public let π = CGFloat(M_PI)

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .none
    dateFormatter.dateStyle = .long
    return dateFormatter
}()

private let timeFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .short
    dateFormatter.dateStyle = .none
    return dateFormatter
}()

private let numberFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.usesGroupingSeparator = true
    return numberFormatter
}()

private let currencyFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    return numberFormatter
}()

/// Base style namespace
public struct Style {

    /// Color statics
    public struct Color {

        /// Pure white color
        public static let White = UIColor.white()

        /// Pure black color
        public static let Black = UIColor.black()

        /// Clear white color with 0 alpha
        public static let ClearWhite = White.withAlphaComponent(0)

        /// Clear black color with 0 alpha
        public static let ClearBlack = Black.withAlphaComponent(0)

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
        public static let ScreenScale: CGFloat = UIScreen.main().scale

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

        /// Standard iOS navigation bar height: 44 point
        public static let NavigationBarHeight: CGFloat = 44

        /// Standard iOS navigation bar height, in landscape: 32 point
        public static let NavigationBarHeightCompact: CGFloat = 32

        /// The max width of an item set to
        /// the left or right views of a `TitleBarView`
        public static let TitleBarItemMaxWidth: CGFloat = 200

        /// Base label width: 300 point
        public static let LabelWidth: CGFloat = 300

        /// The width of an iPhone 5 screen in point
        public static let iPhone5Width: CGFloat = 320

        /// The width of an iPhone 6 screen in point
        public static let iPhone6Width: CGFloat = 375

        /// The width of an iPhone 6 Plus screen in point
        public static let iPhone6PlusWidth: CGFloat = 414

        // The native screen width in pixels
        public static let NativeScreenWidth = UIScreen.main().nativeBounds.width/UIScreen.main().nativeScale

        // The native screen height in pixels
        public static let NativeScreenHeight = UIScreen.main().nativeBounds.height/UIScreen.main().nativeScale

        // The height of the status bar in points
        public static let StatusBarHeight = UIApplication.shared().statusBarFrame.height

        // The maximum width or height of an Instagram photo in pixels
        public static let MaxInstagramSize: CGFloat = 1080
    }

    /// Animation statics
    public struct Animation {

        /// Base animation short duration: 0.1 seconds
        public static let ShortDuration: TimeInterval = 0.1

        /// Base animation duration: 0.25 seconds
        public static let Duration: TimeInterval = 0.25

        /// Base animation long duration: 0.5 seconds
        public static let LongDuration: TimeInterval = 0.5

        /// Base animation very long duration: 1.5 seconds
        public static let VeryLongDuration: TimeInterval = 1.5

        /// Base animation very very long duration: 3 seconds
        public static let VeryVeryLongDuration: TimeInterval = 3

        /// Base animation spring dampening: 0.4
        public static let Damping: CGFloat = 0.4

        /// Base animation spring velocity: 0.8
        public static let Velocity: CGFloat = 0.8

        /**
         Shake the view, useful for showing something as invalid.

         - parameter view: The view object to shake.
         - parameter duration: The duration of the animation, defaults to `Animation.Duration`.
         - parameter offset: The offset amount to transform the view by, defaults to `Size.Padding`.
         - parameter completionBlock: The completion block to call once the animation has finished.
         */
        public static func Shake(view: UIView, duration: TimeInterval = Duration, offset: CGFloat = Size.Padding, completionBlock: (() -> Void)? = nil) {
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.duration = duration
            animation.values = [
                -offset, offset,
                -offset, offset,
                -offset*0.6, offset*0.6,
                -offset*0.3, offset*0.3,
                0
            ]

            CATransaction.begin()
            view.layer.add(animation, forKey: "shake")
            CATransaction.setCompletionBlock(completionBlock)
            CATransaction.commit()
        }

        /**
         Pop the view, useful for brinning attention to something.

         - parameter view: The view object to pop.
         - parameter duration: The duration of the animation, defaults to `Animation.ShortDuration`.
         - parameter scale: The offset amount to scale the view by, defaults to `1.5`.
         - parameter completionBlock: The completion block to call once the animation has finished.
         */
        public static func Pop(view: UIView, duration: TimeInterval = ShortDuration, scale: CGFloat = 1.5, completionBlock: (() -> Void)? = nil) {
            UIView.animate(withDuration: duration*0.5, delay: 0, options: .beginFromCurrentState, animations: {
                view.layer.transform = CATransform3DMakeScale(scale, scale, scale)
                }) { _ in
                    UIView.animate(withDuration: duration) {
                        view.layer.transform = CATransform3DIdentity
                    }
            }
        }
    }

    /// Shadow statics
    public struct Shadow {

        /// Base shadow color, defaults to `Style.Color.Black`
        public static let Color = Style.Color.Black

        /// Base shadow offset: `{0, 1}`
        public static let Offset = CGSize(width: 0, height: 1)

        /// Base shadow opacity: 0.5
        public static let Opacity: Float = 0.5

        /// Base shadow radius: 3
        public static let Radius: CGFloat = 3

        /**
         Apply the shadow to the view

         - parameter view: The view to apply the shadow to.
         */
        public static func Apply(toView view: UIView) {
            view.layer.shadowColor = Color.cgColor
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
        public static func Date(from date: Foundation.Date, includeTime: Bool = false, calanderIdentifier: String = Calendar.Identifier.gregorian.rawValue) -> String? {
            var dateString = date.timeAgo

            guard let calander = Calendar(identifier: Calendar.Identifier(rawValue: calanderIdentifier)) else {
                return nil
            }

            let components = calander.components([.month, .year], from: date, to: Foundation.Date(), options: [])
            if components.year >= 1 || components.month > 1 {
                dateString = dateFormatter.string(from: date)
            }

            if includeTime {
                let timeString = timeFormatter.string(from: date)
                return String(format: NSLocalizedString("%@ at %@", comment: "Date time label"), dateString, timeString)
            }

            return dateString
        }

        /**
         Returns a formatted currency string for the given number.
         Trims trailing zeros: i.e. '$5.00' > '$5'.

         - parameter number: The number object to format.

         - returns: A formatted currency string for the number.
         */
        public static func Currency(from number: Double) -> String? {
            let format = currencyFormatter.string(from: number)
            if format?.hasSuffix(".00") == true { // TODO: localize '.'
                return format?.replacingOccurrences(of: ".00", with: "")
            }

            return format
        }

        /**
         Returns a formatted percentage string for the given number.
         Rounds to two decimal places, but trims trailing zeros: i.e. '5.00%' > '5%'.

         - parameter number: The number object to format.

         - returns: A formatted percentage string for the number.
         */
        public static func Percentage(from number: Double) -> String? {
            let format = NSString(format: "%.2f", number)
            if format.hasSuffix(".00") == true { // TODO: localize '.'
                return format.replacingOccurrences(of: ".00", with: "")
            }
            return "\(format)%"
        }
        
        /**
         Returns a formatted string for the given number.
         
         - parameter number: The number object to format.
         
         - returns: A formatted string for the number.
         */
        public static func Number(from number: Int) -> String? {
            return numberFormatter.string(from: number)
        }
        
    }
    
}
