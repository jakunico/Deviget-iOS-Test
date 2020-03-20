//
//  Swift+Deviget.swift
//  Deviget-iOS-Test
//
//  Created by Nicolas Jakubowski on 3/20/20.
//  Copyright © 2020 Nicolas Jakubowski. All rights reserved.
//

import Foundation

// Syntaxis sugar for configuration code
// Taken from https://twitter.com/jegnux/status/1233035706639036416

prefix operator ..
infix operator .. : MultiplicationPrecedence

@discardableResult
func .. <T>(object: T, configuration: (inout T) -> Void) -> T {
    var object = object
    configuration(&object)
    return object
}
