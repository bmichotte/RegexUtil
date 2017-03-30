//
//  RegexUtilMacTests.swift
//  RegexUtilMacTests
//
//  Created by Benjamin Michotte on 30/03/17.
//
//

import XCTest
@testable import RegexUtil

class RegexUtilMacTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRegexMatch() {
        let regex = Regex(expression: "^foo$")
        XCTAssert(regex.match("foo"), "^foo$ does not match foo")
        XCTAssertFalse(regex.match("bar"), "^foo$ match bar")
    }

    func testRegexMatches() {
        let regex = Regex(expression: "([A-Za-z0-9]+)")
        let matches = regex.matches("hello, it's me")
        XCTAssertEqual(matches.count, 4, "there are 4 results")
        XCTAssertEqual(matches[0].value, "hello", "hello")
        XCTAssertEqual(matches[1].value, "it", "it")
        XCTAssertEqual(matches[2].value, "s", "s")
        XCTAssertEqual(matches[3].value, "me", "me")
    }

    func testStringExtension() {
        XCTAssert("foo".match("^foo$"), "^foo$ does not match foo")
        XCTAssertFalse("bar".match("^foo$"), "^foo$ match bar")
        XCTAssert("hello_is_here".match("hello"), "hello is found")

        let matches = "hello, it's me".matches("([A-Za-z0-9]+)")
        XCTAssertEqual(matches.count, 4, "there are 4 results")
        XCTAssertEqual(matches[0].value, "hello", "hello")
        XCTAssertEqual(matches[1].value, "it", "it")
        XCTAssertEqual(matches[2].value, "s", "s")
        XCTAssertEqual(matches[3].value, "me", "me")
    }
}
