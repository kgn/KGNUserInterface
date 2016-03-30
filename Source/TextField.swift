//
//  TextField.swift
//  KGNUserInterface
//
//  Created by David Keegan on 10/29/15.
//  Copyright © 2015 David Keegan. All rights reserved.
//

import UIKit
import KGNPreferredFontManager

private extension Selector {
    static let textDidChange = #selector(UITextInputDelegate.textDidChange(_:))
}

/// Subclass of `PreferredFontTextField`. This implementation also allows
/// the text color to be set by `Label.appearance().textColor` and adds
/// a property for setting the color of the placeholder text.
public class TextField: PreferredFontTextField {

    /// The intrinsic width, if `nil` the super value is used,
    /// `UIViewNoIntrinsicMetric` can also be used used.
    public var intrinsicWidth: CGFloat?

    /// The intrinsic height, if `nil` the super value is used,
    /// `UIViewNoIntrinsicMetric` can also be used used.
    public var intrinsicHeight: CGFloat?

    /// Suffix values to use for auto complete
    /// Useful for auto completing email addresses and other common text inputs
    public var autoCompleteValues: [String]?

    /// Determins if the auto complete match should ignore case
    /// Defaults to `true`
    public var autoCompleteIgnoreCase = true

    /// The current auto complete value
    public var autoCompleteValue: String? {
        get {
            return self.autoCompleteMatch()
        }
    }

    override public var text: String? {
        get {
            return super.text
        }

        set {
            super.text = newValue
            self.updatePlaceholderAndAutoComplete()
        }
    }

    override public var font: UIFont? {
        get {
            return super.font
        }

        set {
            super.font = newValue
            self.updatePlaceholderAndAutoComplete()
        }
    }

    override public var textStyle: String {
        didSet {
            self.placeholderLabel.textStyle = self.textStyle
            self.autoCompleteLabel.textStyle = self.textStyle
        }
    }

    override public var preferredFontManager: PreferredFontManager? {
        didSet {
            self.placeholderLabel.preferredFontManager = self.preferredFontManager
            self.autoCompleteLabel.preferredFontManager = self.preferredFontManager
        }
    }

    private var privatePlaceholder: String? {
        didSet {
            self.placeholderLabel.text = self.privatePlaceholder
        }
    }

    override public var placeholder: String? {
        get {
            return self.privatePlaceholder
        }

        set(newValue) {
            self.privatePlaceholder = newValue
        }
    }

    /// The color of the placeholder text.
    public var placeholderColor: UIColor? {
        didSet {
            self.placeholderLabel.textColor = self.placeholderColor
        }
    }

    /// The color of the auto complete text.
    public var autoCompleteColor: UIColor? {
        didSet {
            self.autoCompleteLabel.textColor = self.autoCompleteColor
        }
    }

    private lazy var placeholderLabel: Label = {
        let label = Label(textStyle: self.textStyle)
        label.textColor = self.placeholderColor
        label.text = self.placeholder
        return label
    }()

    private var autoCompleteLabelConstraint: NSLayoutConstraint!
    private lazy var autoCompleteLabel: Label = {
        let label = Label(textStyle: self.textStyle)
        label.textColor = self.placeholderColor
        label.text = self.placeholder
        return label
    }()

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

    override public func setup() {
        super.setup()

        self.textColor = TextField.appearance().textColor

        self.addSubview(self.placeholderLabel)
        self.placeholderLabel.centerVerticallyInSuperview()
        self.placeholderLabel.pinToLeftEdgeOfSuperview()

        self.addSubview(self.autoCompleteLabel)
        self.autoCompleteLabel.centerVerticallyInSuperview()
        self.autoCompleteLabelConstraint = self.autoCompleteLabel.pinToLeftEdgeOfSuperview()

        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: .textDidChange,
            name: UITextFieldTextDidChangeNotification,
            object: self
        )
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    @objc private func textDidChange(notification: NSNotification) {
        self.updatePlaceholderAndAutoComplete()
    }

    private func updatePlaceholderAndAutoComplete() {
        self.placeholderLabel.hidden = self.text?.isEmpty == false

        if let autoCompleteValue = self.autoCompleteValue {
            if let text = self.text, font = self.font {
                let textLength = (text as NSString).boundingRectWithSize(
                    self.bounds.size, options: [],
                    attributes: [NSFontAttributeName: font], context: nil
                )
                self.autoCompleteLabelConstraint.constant = textLength.width
                let startIndex = autoCompleteValue.startIndex.advancedBy(text.characters.count)
                self.autoCompleteLabel.text = autoCompleteValue.substringFromIndex(startIndex)
            } else {
                self.autoCompleteLabelConstraint.constant = 0
                self.autoCompleteLabel.text = autoCompleteValue
            }
            self.autoCompleteLabel.hidden = false
        } else {
            self.autoCompleteLabel.hidden = true
        }
    }

    internal func autoCompleteMatch() -> String? {
        guard let autoCompleteValues = self.autoCompleteValues where autoCompleteValues.count > 0 else {
            return nil
        }
        guard let text = self.text where !text.isEmpty else {
            return nil
        }

        var compareText = text
        if self.autoCompleteIgnoreCase {
            compareText = compareText.lowercaseString
        }

        // Loop through all the auto complete values to find a match
        for suffix in autoCompleteValues {
            var compareSuffix = suffix
            if self.autoCompleteIgnoreCase {
                compareSuffix = suffix.lowercaseString
            }

            guard let firstSuffixCharacter = compareSuffix.characters.first else {
                continue
            }

            // Find the location of the first character from the suffix in the text,
            // if it exists...
            var textLocation: Int?
            for (t, textCharacter) in compareText.characters.enumerate() {
                if firstSuffixCharacter == textCharacter {
                    textLocation = t
                    break
                }
            }

            guard let location = textLocation else {
                continue
            }

            // Find all the following matching characters
            var length = 1
            var suffixArray = Array(compareSuffix.characters)
            var textArray = Array(compareText.characters)

            if length+location < textArray.count {
                while suffixArray[length] == textArray[length+location] {
                    length += 1

                    if length >= suffixArray.count {
                        break
                    }

                    if length+location >= textArray.count {
                        break
                    }
                }
            }
            
            if textArray.count > location+length {
                continue
            }
            
            // Return the full text with the complete suffix,
            // this cuases the function to early exit when the
            // first match is found
            let index = suffix.startIndex.advancedBy(length)
            return text+suffix.substringFromIndex(index)
            
        }

        return nil
    }

}
