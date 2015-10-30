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
        XCTAssertEqual(label1.textColor, UIColor.blackColor())

        Label.appearance().textColor = UIColor.redColor()
        let label2 = Label()
        XCTAssertEqual(label2.textColor, UIColor.redColor())
    }

}

class KGNUserInterfaceTextFieldTests: XCTestCase {

    func testAppearanceTextColor() {
        let textField1 = TextField()
        XCTAssertEqual(textField1.textColor, UIColor.blackColor())

        TextField.appearance().textColor = UIColor.redColor()
        let textField2 = TextField()
        XCTAssertEqual(textField2.textColor, UIColor.redColor())
    }
    
}
