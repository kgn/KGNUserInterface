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

public struct Style {

    public static let PreferredFontManager = preferredFontManager
    public static let Calander = NSCalendar(identifier: NSCalendarIdentifierGregorian)!

    public struct Color {
        public static let Clear = UIColor.clearColor()
        public static let White = UIColor.whiteColor()
        public static let Black = UIColor.blackColor()
        public static let DimWhite = White.colorWithAlphaComponent(0.5)
    }

    public struct Size {
        public static let ScreenScale: CGFloat = UIScreen.mainScreen().scale

        public static let OnePoint: CGFloat = 1
        public static let HalfPoint: CGFloat = OnePoint/2
        public static let OnePixel: CGFloat = OnePoint/ScreenScale

        public static let SmallPadding: CGFloat = 4
        public static let Padding: CGFloat = 10
        public static let LargePadding: CGFloat = 20
        public static let Control: CGFloat = 44

        public static let LabelWidth: CGFloat = 300
    }

    public struct Animation {
        public static let Duration: NSTimeInterval = 0.25
        public static let LongDuration: NSTimeInterval = 0.5
        public static let Damping: CGFloat = 0.4
        public static let Velocity: CGFloat = 0.8
    }

    public struct Shadow {

        public static let Color: UIColor = Style.Color.Black
        public static let Offset: CGSize = CGSizeMake(0, 1)
        public static let Opacity: Float = 0.5
        public static let Radius: CGFloat = 3

        public static func Apply(view: UIView) {
            view.layer.shadowColor = Color.CGColor
            view.layer.shadowOffset = Offset
            view.layer.shadowOpacity = Opacity
            view.layer.shadowRadius = Radius
        }

    }

    public struct Format {

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

        public static func Number(number: NSNumber) -> String? {
            return numberFormatter.stringFromNumber(number)
        }
        
    }

}
