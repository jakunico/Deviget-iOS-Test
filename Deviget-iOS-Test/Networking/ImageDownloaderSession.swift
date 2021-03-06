//
//  ImageDownloaderSession.swift
//  Deviget-iOS-Test
//
//  Created by Nicolas Jakubowski on 3/19/20.
//  Copyright © 2020 Nicolas Jakubowski. All rights reserved.
//

import Foundation

class ImageDownloader {
    /// The session to be used to download images with strong caching policy.
    static let session = URLSession(configuration: {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return configuration
    }())
}
