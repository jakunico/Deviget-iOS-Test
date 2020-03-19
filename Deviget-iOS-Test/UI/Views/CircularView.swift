//
//  CircularView.swift
//  Deviget-iOS-Test
//
//  Created by Nicolas Jakubowski on 3/19/20.
//  Copyright © 2020 Nicolas Jakubowski. All rights reserved.
//

import Foundation
import UIKit

class CircularView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0.5 * bounds.size.width
    }
}
