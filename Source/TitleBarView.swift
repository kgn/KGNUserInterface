//
//  TitleBarView.swift
//  KGNUserInterface
//
//  Created by David Keegan on 10/30/15.
//  Copyright © 2015 David Keegan. All rights reserved.
//

import UIKit

private class ContentView: UIView {
    override private func intrinsicContentSize() -> CGSize {
        let minWidth = Style.Size.Control
        var intrinsicContentSize = super.intrinsicContentSize()

        if let subview = self.subviews.first {
            let subviewIntrinsicContentSize = subview.intrinsicContentSize()
            intrinsicContentSize.width = subviewIntrinsicContentSize.width
            if intrinsicContentSize.width < minWidth {
                intrinsicContentSize.width = minWidth
            }
        } else {
            intrinsicContentSize.width = 0
        }

        return intrinsicContentSize
    }
}

/// Custom title bar view, similar to UINavigationBar
/// but intended for custom interfaces.
public class TitleBarViewTest: UIView {

    /// The title to display in the center of the bar
    public var title: String? {
        didSet {
            self.titleLabel.text = self.title
        }
    }

    /// The left view item
    public var leftView: UIView? {
        didSet {
            for subview in self.leftContainerView.subviews {
                subview.removeFromSuperview()
            }
            if let leftView = self.leftView {
                self.leftContainerView.addSubview(leftView)
                leftView.pinToEdgesOfSuperview()
            }
        }
    }

    /// The right view item
    public var rightView: UIView? {
        didSet {
            for subview in self.rightContainerView.subviews {
                subview.removeFromSuperview()
            }
            if let rightView = self.rightView {
                self.rightContainerView.addSubview(rightView)
                rightView.pinToEdgesOfSuperview()
            }
        }
    }

    private lazy var titleLabel: Label = {
        let label = Label(textStyle: UIFontTextStyleSubheadline)
        return label
    }()

    private lazy var leftContainerView: ContentView = {
        return ContentView()
    }()

    private lazy var rightContainerView: ContentView = {
        return ContentView()
    }()

    /// Set the title, if `animated` is `true` then a cross dissolve animation is used.
    public func setTitle(title: String?, animated: Bool) {
        defer {
            self.title = title
        }

        if !animated{
            return
        }

        guard let snapshot = self.titleLabel.snapshot() else {
            return
        }

        let titleLabelImageView = UIImageView(image: snapshot)
        self.addSubview(titleLabelImageView)
        titleLabelImageView.centerInSuperview()

        self.titleLabel.alpha = 0
        UIView.animateWithDuration(Style.Animation.Duration, animations: {
            self.titleLabel.alpha = 1
            titleLabelImageView.alpha = 0
            }) { _ in
                titleLabelImageView.removeFromSuperview()
        }
    }

    override public func intrinsicContentSize() -> CGSize {
        if self.traitCollection.userInterfaceIdiom == .Phone {
            if self.traitCollection.verticalSizeClass == .Compact {
                return CGSizeMake(UIViewNoIntrinsicMetric, Style.Size.NavigationBarHeightCompact)
            }
        }
        return CGSizeMake(UIViewNoIntrinsicMetric, Style.Size.NavigationBarHeight)
    }

    override public func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.invalidateIntrinsicContentSize()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup() {
        self.addSubview(self.leftContainerView)
        self.leftContainerView.sizeToMaxWidth(Style.Size.TitleBarItemMaxWidth)
        self.leftContainerView.pinToTopAndBottomEdgesOfSuperview()
        self.leftContainerView.pinToLeftEdgeOfSuperview(offset: Style.Size.SmallPadding)

        self.addSubview(self.rightContainerView)
        self.rightContainerView.sizeToMaxWidth(Style.Size.TitleBarItemMaxWidth)
        self.rightContainerView.pinToTopAndBottomEdgesOfSuperview()
        self.rightContainerView.pinToRightEdgeOfSuperview(offset: Style.Size.SmallPadding)

        self.addSubview(self.titleLabel)
        self.titleLabel.centerInSuperview()
        self.constrain(
            self.titleLabel, attribute: .Left,
            relatedBy: .GreaterThanOrEqual,
            toItem: self.leftContainerView, attribute: .Right,
            offset: Style.Size.Padding
        )
        self.constrain(
            self.titleLabel, attribute: .Right,
            relatedBy: .LessThanOrEqual,
            toItem: self.rightContainerView, attribute: .Left,
            offset: -Style.Size.Padding
        )
    }

}
