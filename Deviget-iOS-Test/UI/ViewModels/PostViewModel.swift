//
//  PostViewModel.swift
//  Deviget-iOS-Test
//
//  Created by Nicolas Jakubowski on 3/19/20.
//  Copyright © 2020 Nicolas Jakubowski. All rights reserved.
//

import Foundation

struct PostViewModel {
    
    /// A unique identifier of the post that generated this view model.
    let postIdentifier: String
    
    /// Indicates whether this post has been read or not.
    let isRead: Bool
    
    /// The subreddit, i.e. "r/gaming".
    let subreddit: String
    
    /// Relative time when this post was created, i.e. "2 hours ago".
    let timeAgo: String
    
    /// Title of the post.
    let title: String
    
    /// The URL to the image or `nil` if this post does not have an image associated with it.
    let image: URL?
    
    /// The OP, i.e. "u/nicolas".
    let user: String
    
    /// The number of comments, i.e. "3215 comments".
    let comments: String
    
    func asRead() -> PostViewModel {
        return PostViewModel(postIdentifier: postIdentifier,
                             isRead: true,
                             subreddit: subreddit,
                             timeAgo: timeAgo,
                             title: title,
                             image: image,
                             user: user,
                             comments: comments)
    }
    
}
