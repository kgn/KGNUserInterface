# KGNUserInterface

`KGNUserInterface` is a collection of the core user interface resources.

[![iOS 8.0+](http://img.shields.io/badge/iOS-8.0%2B-blue.svg)]()
[![watchOS 1.0+](http://img.shields.io/badge/watchOS-1.0%2B-blue.svg)]()
[![Xcode 7.1](http://img.shields.io/badge/Xcode-7.0-blue.svg)]()
[![Swift 2.0](http://img.shields.io/badge/Swift-2.0-blue.svg)]()
[![Release](https://img.shields.io/github/release/kgn/KGNUserInterface.svg)](/releases)
[![Build Status](http://img.shields.io/badge/License-MIT-lightgrey.svg)](/LICENSE)

[![Build Status](https://travis-ci.org/kgn/KGNUserInterface.svg)](https://travis-ci.org/kgn/KGNUserInterface)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-Compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)
[![CocoaPods Version](https://img.shields.io/cocoapods/v/KGNUserInterface.svg)](https://cocoapods.org/pods/KGNUserInterface)
[![CocoaPods Platforms](https://img.shields.io/cocoapods/p/KGNUserInterface.svg)](https://cocoapods.org/pods/KGNUserInterface)

[![Twitter](https://img.shields.io/badge/Twitter-@iamkgn-55ACEE.svg)](http://twitter.com/iamkgn)
[![Star](https://img.shields.io/github/followers/kgn.svg?style=social&label=Follow%20%40kgn)](https://github.com/kgn)
[![Star](https://img.shields.io/github/stars/kgn/KGNUserInterface.svg?style=social&label=Star)](https://github.com/kgn/KGNUserInterface)

## Installing

### Carthage
```
github "kgn/KGNUserInterface"
```

## Includes

- [KGNColor](https://github.com/kgn/KGNColor)
- [KGNAutoLayout](https://github.com/kgn/KGNAutoLayout)
- [KGNGradientView](https://github.com/kgn/KGNGradientView)
- [KGNPreferredFontManager](https://github.com/kgn/KGNPreferredFontManager)
- [NSDate-TimeAgo](https://github.com/kgn/NSDate-TimeAgo)

## Additions

In addition to including the above frameworks KGNUserInterface also includes several helper methods, classes, and structs build on-top of these frameworks.

### π

`KGNUserInterface` defines a `π` constant that represents a `CGFloat` value for pi.

### UIViewController Extension

`addSubViewController` is a helper method that encapsulates all of the logic to properly add a view controller as a child view controller.

``` Swift
self.addSubViewController(launchScreenViewController)
```

### Style

The `Style` struct is a collection of useful structs. There are several namespaces beneath the `Style` struct including.

#### Style.PreferredFontManager

This top level static defines a default `PreferredFontManager`. You can also provide your own `PreferredFontManager` in order to customize the fonts used throughout your app.

#### Style.Calander

This top level static defines a default Gregorian calendar. You can also provide your own calendar in order to customize the dates used throughout your app.

#### Style.Color

This struct includes color statics like `Style.Color.White`. You can extend this struct to add your own colors for use throughout your app.

``` Swift
extension Style.Color {

    static let Black = UIColor(hex: 0x1A1A1A)

    public static let ButtonGradientTop = UIColor(hex: 0x4DC4FF)
    public static let ButtonGradientBottom = UIColor(hex: 0xA147FF)

    public static let BlackGradientTop = Style.Color.Black.colorWithAlphaComponent(0)
    public static let BlackGradientBottom = Style.Color.Black.colorWithAlphaComponent(0.5)

}
```

#### Style.Size

This struct includes size statics like `Style.Size.OnePixel`. You can extend this struct to add your own sizes for use throughout your app.

``` Swift
extension Style.Size {

    public static let CircleProgressStroke: CGFloat = 1
    public static let CircleProgressSize: CGFloat = 64
    public static let CircleProgressStartAngle: CGFloat = -π*0.25

}
```

#### Style.Animation

This struct includes animation value statics like `Style.Animation.Duration`. You can extend this struct to add your own animation values for use throughout your app.

#### Style.Shadow

This struct includes shadow value statics like `Style.Shadow.Opacity`. You can extend this struct to add your own shadow values for use throughout your app.

This struct also as an `Apply` method to apply the shadow to a view.

``` Swift
Style.Shadow.Apply(view)
```

#### Style.Format

This struct includes formatter methods `Style.Format.Date`. You can extend this struct to add your own formatting methods for use throughout your app.

``` Swift
cell.dateLabel.text = Style.Format.Date(creationDate, includeTime: true)
```
### Label & Button

`KGNUserInterface` defines a `Label` subclass of `PreferredFontLabel` as well as a `Button` subclass of `PreferredFontButton`. Both subclasses set the `preferredFontManager` property to `Style.PreferredFontManager`.

`Label` also exposes properties to control the width and height intrinsic content size without having to subclass the label through `allowIntrinsicWidth` and `allowIntrinsicHeight`.

## Progress
- [ ] Badges
- [ ] Tests
- [ ] Travis
- [X] Carthage
- [X] Description
- [X] Documentation
