//
//  DetailViewController.swift
//  Deviget-iOS-Test
//
//  Created by Nicolas Jakubowski on 3/19/20.
//  Copyright © 2020 Nicolas Jakubowski. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var viewModel: PostViewModel? {
        didSet {
            subredditLabel.text = viewModel?.subreddit
            timeAgoLabel.text = viewModel?.timeAgo
            titleLabel.text = viewModel?.title
            userLabel.text = viewModel?.user
            commentsLabel.text = viewModel?.comments
            
            // TODO: Set image
        }
    }
    
    // MARK: - Private
    
    @IBOutlet private weak var subredditLabel: UILabel!
    @IBOutlet private weak var timeAgoLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var userLabel: UILabel!
    @IBOutlet private weak var commentsLabel: UILabel!
    
}

