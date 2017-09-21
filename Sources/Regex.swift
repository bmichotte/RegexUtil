//
//  Regex.swift
//  RegexUtil
//
//  Created by Benjamin Michotte on 30/03/17.
//
//

import Foundation

public struct RegexPattern: ExpressibleByStringLiteral {
    public let rawValue: String

    public init(stringLiteral value: String) {
        self.rawValue = value
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self.rawValue = value
    }

    public init(unicodeScalarLiteral value: String) {
        self.rawValue = value
    }
}

public struct Match {
    public var range: Range<String.Index>
    public var value: String
}

public struct Regex {
    let expression: RegexPattern

    init(expression: RegexPattern) {
        self.expression = expression
    }

    public func match(_ someString: String) -> Bool {
        do {
            let regularExpression = try NSRegularExpression(pattern: expression.rawValue,
                                                            options: [])
            let range = NSRange(location: 0, length: someString.characters.count)
            let matches = regularExpression.numberOfMatches(in: someString,
                                                            options: [],
                                                            range: range)
            return matches > 0
        } catch { return false }
    }

    public func matches(_ someString: String) -> [Match] {
        var matches = [Match]()
        do {
            let regularExpression = try NSRegularExpression(pattern: expression.rawValue,
                                                            options: [])
            let range = NSRange(location: 0, length: someString.characters.count)
            let results = regularExpression.matches(in: someString,
                                                    options: [],
                                                    range: range)
            for result in results {
                for index in 1 ..< result.numberOfRanges {
                    let resultRange = result.range(at: index)
                    let startPos = someString.characters
                        .index(someString.startIndex, offsetBy: resultRange.location)
                    let end = resultRange.location + resultRange.length
                    let endPos = someString.characters.index(someString.startIndex, offsetBy: end)
                    let range = startPos ..< endPos

                    let value = String(someString[range])
                    let match = Match(range: range, value: value)
                    matches.append(match)
                }
            }
        } catch { }
        return matches
    }
}

public extension String {
    @discardableResult
    public func match(_ pattern: RegexPattern) -> Bool {
        return Regex(expression: pattern).match(self)
    }

    @discardableResult
    public func matches(_ pattern: RegexPattern) -> [Match] {
        return Regex(expression: pattern).matches(self)
    }

    @discardableResult
    public func replace(_ pattern: RegexPattern, with: String) -> String {
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern.rawValue, options: [])
            let range = NSRange(location: 0, length: self.characters.count)
            return regularExpression.stringByReplacingMatches(in: self,
                                                              options: [],
                                                              range: range,
                                                              withTemplate: with)
        } catch { }
        return self
    }

    @discardableResult
    public func replace(_ pattern: RegexPattern, using: (String, [Match]) -> String) -> String {
        let matches = self.matches(pattern)
        return using(self, matches)
    }

    @discardableResult
    public func replace(_ patterns: [RegexPattern], with string: String) -> String {
        return replace(patterns, with: [String](repeating: string, count: patterns.count))
    }

    @discardableResult
    public func replace(_ patterns: [RegexPattern], with strings: [String]) -> String {
        let merged = Array(zip(patterns, strings))
        var str = self
        for (pattern, string) in merged {
            str = str.replace(pattern, with: string)
        }
        return str
    }
}
