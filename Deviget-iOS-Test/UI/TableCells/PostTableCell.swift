//
//  PostTableCell.swift
//  Deviget-iOS-Test
//
//  Created by Nicolas Jakubowski on 3/19/20.
//  Copyright © 2020 Nicolas Jakubowski. All rights reserved.
//

import Foundation
import UIKit

class PostTableCell: UITableViewCell {
    
    // MARK: - Internal

    /// The viewModel currently set on the cell.
    /// Readonly, to set use `setViewModel(_:animated:)`.
    fileprivate(set) var viewModel: PostViewModel?
    
    /// Sets the viewModel.
    /// Use the animated property if you want to animate the change of content.
    func setViewModel(_ viewModel: PostViewModel, animated: Bool) {
        self.viewModel = viewModel
        
        if animated {
            UIViewPropertyAnimator.runningPropertyAnimator(
                withDuration: 0.3,
                delay: 0,
                options: [],
                animations: { self.configure(with: viewModel) },
                completion: nil)
        } else {
            configure(with: viewModel)
        }
    }
    
    // MARK: - Private
    
    @IBOutlet private weak var unreadIndicationView: UIView!
    @IBOutlet private weak var subredditLabel: UILabel!
    @IBOutlet private weak var timeAgoLabel: UILabel!
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var userLabel: UILabel!
    @IBOutlet private weak var commentsLabel: UILabel!
    @IBOutlet private weak var dismissButton: UIButton!
    
    private func configure(with viewModel: PostViewModel) {
        unreadIndicationView.isHidden = viewModel.isRead
        subredditLabel.text = viewModel.subreddit
        timeAgoLabel.text = viewModel.timeAgo
        titleLabel.text = viewModel.title
        userLabel.text = viewModel.user
        commentsLabel.text = viewModel.comments
        
        // TODO: set image
    }
}
