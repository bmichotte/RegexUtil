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
        let pattern = RegexPattern(stringLiteral: "^foo$")
        let regex = Regex(expression: pattern)
        XCTAssert(regex.match("foo"), "^foo$ does not match foo")
        XCTAssertFalse(regex.match("bar"), "^foo$ match bar")
    }

    func testRegexMatchUsingString() {
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

    func testStringMatch() {
        XCTAssert("foo".match("^foo$"), "^foo$ does not match foo")
        XCTAssertFalse("bar".match("^foo$"), "^foo$ match bar")
        XCTAssert("hello_is_here".match("hello"), "hello is found")
    }

    func testStringMatches() {
        let matches = "hello, it's me".matches("([A-Za-z0-9]+)")
        XCTAssertEqual(matches.count, 4, "there are 4 results")
        XCTAssertEqual(matches[0].value, "hello", "hello")
        XCTAssertEqual(matches[1].value, "it", "it")
        XCTAssertEqual(matches[2].value, "s", "s")
        XCTAssertEqual(matches[3].value, "me", "me")
    }

    func testReplace() {
        let string = "hello, it's me"
        let replaced = string.replace("me", with: "you")
        XCTAssertEqual(replaced, "hello, it's you")
    }

    func testReplaceWithClosure() {
        let string = "hello, it's me"
        let replaced = string.replace("(me)") { (string, matches) in
            XCTAssertEqual(matches.count, 1, "there is one result")
            return string.replacingCharacters(in: matches.first!.range, with: "you")
        }
        XCTAssertEqual(replaced, "hello, it's you")
    }

    func testReplaceWithString() {
        let string = "hello, it's me"
        let patterns: [RegexPattern] = ["hello"]
        let replaced = string.replace(patterns, with: "good morning")
        XCTAssertEqual(replaced, "good morning, it's me")
    }

    func testReplaceWithStrings() {
        let string = "hello, it's me"
        let patterns: [RegexPattern] = ["e", "o", "i"]
        let replaced = string.replace(patterns, with: ["3", "0", "1"])
        XCTAssertEqual(replaced, "h3ll0, 1t's m3")
    }
}
