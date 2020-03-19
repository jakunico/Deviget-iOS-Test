//
//  RemoteImageView.swift
//  Deviget-iOS-Test
//
//  Created by Nicolas Jakubowski on 3/19/20.
//  Copyright © 2020 Nicolas Jakubowski. All rights reserved.
//

import Foundation
import UIKit

class RemoteImageView: UIImageView {

    var url: URL? {
        didSet {
            if let url = url {
                loadImage(fromUrl: url)
            } else {
                image = nil
            }
        }
    }
    
    func loadImage(fromUrl url: URL) {
        task?.cancel()
        task = ImageDownloader.session.dataTask(with: url) { data, response, error in
            guard self.url == url else { return } // no longer needed by this image view
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                    self.setNeedsLayout()
                    self.layoutIfNeeded()
                }
            }
        }
        task?.resume()
    }
    
    // MARK: - Private
    
    private var task: URLSessionDataTask?
    
}
