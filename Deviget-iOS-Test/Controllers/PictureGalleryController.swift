//
//  PictureGalleryController.swift
//  Deviget-iOS-Test
//
//  Created by Nicolas Jakubowski on 3/20/20.
//  Copyright © 2020 Nicolas Jakubowski. All rights reserved.
//

import Foundation
import UIKit

class PictureGalleryController {
    static func save(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
