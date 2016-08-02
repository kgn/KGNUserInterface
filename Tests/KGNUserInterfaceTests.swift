//
//  KGNUserInterfaceTests.swift
//  KGNUserInterfaceTests
//
//  Created by David Keegan on 10/12/15.
//  Copyright © 2015 David Keegan. All rights reserved.
//

import XCTest
@testable import KGNUserInterface

class KGNUserInterfaceLabelTests: XCTestCase {

    func testAppearanceTextColor() {
        let label1 = Label()
        XCTAssertEqual(label1.textColor, UIColor.black)

        Label.appearance().textColor = UIColor.red
        let label2 = Label()
        XCTAssertEqual(label2.textColor, UIColor.red)
    }

}

class KGNUserInterfaceTextFieldTests: XCTestCase {

    func testAppearanceTextColor() {
        let textField1 = TextField()
        XCTAssertEqual(textField1.textColor, UIColor.black)

        TextField.appearance().textColor = UIColor.red
        let textField2 = TextField()
        XCTAssertEqual(textField2.textColor, UIColor.red)
    }

    func testAutoCompleteEmail() {
        let textField = TextField()
        textField.autoCompleteValues = [
            "@aol.com",
            "@me.com",
            "@mac.com",
            "@gmail.com",
            "@yahoo.com"
        ]

        XCTAssertEqual(textField.autoCompleteValue, nil)

        textField.text = "test"
        XCTAssertEqual(textField.autoCompleteValue, nil)

        textField.text = "test@"
        XCTAssertEqual(textField.autoCompleteValue, "test@aol.com")

        textField.text = "test@g"
        XCTAssertEqual(textField.autoCompleteValue, "test@gmail.com")

        textField.text = "test@m"
        XCTAssertEqual(textField.autoCompleteValue, "test@me.com")

        textField.text = "test@ma"
        XCTAssertEqual(textField.autoCompleteValue, "test@mac.com")

        textField.text = "test@yahoo.com"
        XCTAssertEqual(textField.autoCompleteValue, "test@yahoo.com")
    }

    func testAutoCompleteNames() {
        let textField = TextField()
        textField.autoCompleteValues = [
            "Frank Sinatra",
            "Dean Martin",
            "Sammy Davis",
            "Peter Lawford",
            "Joey Bishop",

            "Franklyn Smith"
        ]

        XCTAssertEqual(textField.autoCompleteValue, nil)

        textField.text = "f"
        XCTAssertEqual(textField.autoCompleteValue, "frank Sinatra")

        textField.text = "frank"
        XCTAssertEqual(textField.autoCompleteValue, "frank Sinatra")

        textField.text = "frank"
        XCTAssertEqual(textField.autoCompleteValue, "frank Sinatra")

        textField.text = "Frank"
        XCTAssertEqual(textField.autoCompleteValue, "Frank Sinatra")

        textField.text = "Frank s"
        XCTAssertEqual(textField.autoCompleteValue, "Frank sinatra")

        textField.text = "frankl"
        XCTAssertEqual(textField.autoCompleteValue, "franklyn Smith")

        textField.text = "Frankl"
        XCTAssertEqual(textField.autoCompleteValue, "Franklyn Smith")

        // TODO: get this to pass
//        textField.text = "DFrank"
//        XCTAssertNotEqual(textField.autoCompleteValue, "DFrank Sinatra")
    }

    func testAutoCompleteCaseSensitive() {
        let textField = TextField()
        textField.autoCompleteIgnoreCase = false
        textField.autoCompleteValues = [
            "Fj714",
            "26314",
            "c6h41",
            "f3582",
            "C6b21"
        ]

        XCTAssertEqual(textField.autoCompleteValue, nil)

        textField.text = "f"
        XCTAssertEqual(textField.autoCompleteValue, "f3582")

        textField.text = "F"
        XCTAssertEqual(textField.autoCompleteValue, "Fj714")

        textField.text = "c6"
        XCTAssertEqual(textField.autoCompleteValue, "c6h41")

        textField.text = "C6"
        XCTAssertEqual(textField.autoCompleteValue, "C6b21")
    }
    
}
