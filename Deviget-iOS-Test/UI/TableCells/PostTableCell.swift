//
//  PostTableCell.swift
//  Deviget-iOS-Test
//
//  Created by Nicolas Jakubowski on 3/19/20.
//  Copyright © 2020 Nicolas Jakubowski. All rights reserved.
//

import Foundation
import UIKit

protocol PostTableCellDelegate: class {
    func postTableCellDidTapDismiss(cell: PostTableCell)
}

class PostTableCell: UITableViewCell {
    
    // MARK: - Internal
    weak var delegate: PostTableCellDelegate?

    /// The viewModel currently set on the cell.
    /// Readonly, to set use `setViewModel(_:animated:)`.
    var viewModel: PostViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            [unreadIndicationView, unreadIndicationView.superview].forEach { $0?.isHidden = viewModel.isRead }
            subredditLabel.text = viewModel.subreddit
            timeAgoLabel.text = viewModel.timeAgo
            titleLabel.text = viewModel.title
            userLabel.text = viewModel.user
            commentsLabel.text = viewModel.comments
            postImageView.isHidden = viewModel.image == nil
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
    
    @IBAction func actionDismiss() {
        delegate?.postTableCellDidTapDismiss(cell: self)
    }
}
