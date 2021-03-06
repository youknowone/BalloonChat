//
//  BalloonChatTextViewTests.swift
//  BalloonChatTextViewTests
//
//  Created by Jeong YunWon on 2016. 3. 12..
//  Copyright © 2016년 youknowone.org. All rights reserved.
//

import XCTest


class BalloonChatViewTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTextView() {
        let view = BCBalloonTextView(frame: NSRect(x: 0.0, y: 0.0, width: 60.0, height: 40.0))
        XCTAssert(!view.textView.horizontallyResizable)
        XCTAssert(!view.textView.verticallyResizable)
    }

    func testCalcContentSize() {
        let frame = NSRect(x: 0.0, y: 0.0, width: 60.0, height: 40.0)
        let view = BCBalloonTextView(frame: frame)

        view.string = "testable content"
        let originalSize = view.contentSizeThatFits(frame.size)

        XCTAssert(originalSize.width < 60.0)
        XCTAssert(originalSize.height > 0.0)
        XCTAssert(originalSize.height <= 40.0)

        view.string = "testable content with multi-lines"
        let longSize = view.contentSizeThatFits(frame.size)
        XCTAssert(longSize.width <= 60.0)  // respect boundary
        XCTAssert(longSize.height > originalSize.height + 1)

        view.string = "testable content\nsecond line"
        let multiSize = view.contentSizeThatFits(frame.size)
        XCTAssert(multiSize.width == originalSize.width)  // respect boundary
        XCTAssert(multiSize.height > originalSize.height + 1)

        XCTAssert(longSize.height == multiSize.height)  // height of 2-lines
    }

    func testSizeToFit() {
        let view = BCBalloonTextView(frame: NSRect(x: 0.0, y: 0.0, width: 60.0, height: 40.0))
        view.contentSize = NSSize(width: 30.0, height: 20.0)
        XCTAssert(view.contentSize == NSSize(width: 30.0, height: 20.0)) // content size must not be affected
        XCTAssert(view.textView.frame == NSRect(origin: NSZeroPoint, size: view.contentSize)) // without content insets
        XCTAssert(view.backgroundImageView.frame == NSRect(origin: NSZeroPoint, size: view.contentSize)) // without cap insets

        XCTAssert(view.contentSize == NSSize(width: 30.0, height: 20.0)) // content size must not be affected
        view.contentInsets = NSEdgeInsets(top: 2.0, left: 3.0, bottom: 5.0, right: 7.0)
        XCTAssert(view.textView.frame == NSRect(x: 3.0, y: 5.0, width: 30.0, height: 20.0)) // content insets affect origin only

        XCTAssert(view.backgroundImageView.frame.size == NSSize(width: view.contentInsets.left + view.contentSize.width + view.contentInsets.right, height: view.contentInsets.top + view.contentSize.height + view.contentInsets.bottom)) // without cap insets
        XCTAssert(view.textView.frame.size == view.contentSize)

        view.backgroundCapInsets = NSEdgeInsets(top: 7.0, left: 5.0, bottom: 3.0, right: 2.0)
        XCTAssert(view.contentSize == NSSize(width: 30.0, height: 20.0)) // content size must not be affected

        XCTAssert(view.backgroundImageView.frame.size == NSSize(width: view.contentInsets.left + view.contentSize.width + view.contentInsets.right, height: view.contentInsets.top + view.contentSize.height + view.contentInsets.bottom)) // without cap insets
        XCTAssert(view.textView.frame.size == view.contentSize)
    }

}