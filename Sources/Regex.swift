//
//  Regex.swift
//  RegexUtil
//
//  Created by Benjamin Michotte on 30/03/17.
//
//

import Foundation

public struct Match {
    var range: Range<String.Index>
    var value: String
}

public struct Regex {
    let expression: String

    init(expression: String) {
        self.expression = expression
    }

    public func match(_ someString: String) -> Bool {
        do {
            let regularExpression = try NSRegularExpression(pattern: expression, options: [])
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
            let regularExpression = try NSRegularExpression(pattern: expression, options: [])
            let range = NSRange(location: 0, length: someString.characters.count)
            let results = regularExpression.matches(in: someString,
                                                    options: [],
                                                    range: range)
            for result in results {
                for index in 1 ..< result.numberOfRanges {
                    let resultRange = result.rangeAt(index)
                    let startPos = someString.characters
                        .index(someString.startIndex, offsetBy: resultRange.location)
                    let end = resultRange.location + resultRange.length
                    let endPos = someString.characters.index(someString.startIndex, offsetBy: end)
                    let range = startPos ..< endPos

                    let value = someString.substring(with: range)
                    let match = Match(range: range, value: value)
                    matches.append(match)
                }
            }
        } catch { }
        return matches
    }
}

public extension String {
    public func match(_ pattern: String) -> Bool {
        return Regex(expression: pattern).match(self)
    }

    public func matches(_ pattern: String) -> [Match] {
        return Regex(expression: pattern).matches(self)
    }

    public func replace(_ pattern: String, with: String) -> String {
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(location: 0, length: self.characters.count)
            return regularExpression.stringByReplacingMatches(in: self,
                                                              options: [],
                                                              range: range,
                                                              withTemplate: with)
        } catch { }
        return self
    }

    public func replace(_ pattern: String, using: (String, [Match]) -> String) -> String {
        let matches = self.matches(pattern)
        return using(self, matches)
    }
}
