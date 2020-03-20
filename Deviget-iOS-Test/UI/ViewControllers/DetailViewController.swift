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
            configure(with: viewModel)
        }
    }
    
    // MARK: - Private
    
    @IBOutlet private weak var subredditLabel: UILabel!
    @IBOutlet private weak var timeAgoLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var postImageView: RemoteImageView!
    @IBOutlet private weak var userLabel: UILabel!
    @IBOutlet private weak var commentsLabel: UILabel!
    @IBOutlet private weak var noPostLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: viewModel)
        
        postImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionImageTap)))
        postImageView.isUserInteractionEnabled = true // otherwise gesture is not detected
    }
    
    @objc private func actionImageTap() {
        if let image = postImageView.image {
            PictureGalleryController.save(image: image)
        }
    }
    
    private func configure(with viewModel: PostViewModel?) {
        guard isViewLoaded else { return }
        
        subredditLabel.text = viewModel?.subreddit
        timeAgoLabel.text = viewModel?.timeAgo
        titleLabel.text = viewModel?.title
        userLabel.text = viewModel?.user
        commentsLabel.text = viewModel?.comments
        
        [subredditLabel, timeAgoLabel, titleLabel, userLabel, commentsLabel, postImageView].forEach {
            $0?.isHidden = viewModel == nil
        }
        
        postImageView.url = viewModel?.image
        postImageView.isHidden = viewModel?.image == nil
        
        noPostLabel.isHidden = viewModel != nil
        
    }
}

