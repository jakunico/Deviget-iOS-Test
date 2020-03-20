//
//  Requests.swift
//  Deviget-iOS-Test
//
//  Created by Nicolas Jakubowski on 3/19/20.
//  Copyright © 2020 Nicolas Jakubowski. All rights reserved.
//

import Foundation

struct TopRequest {
    enum Time: String {
        case hour
        case day
        case week
        case month
        case year
        case all
    }
    
    let time: Time
    let after: String? // What page to load, if `nil` means first page.
    let limit: Int // How many items to load
}
