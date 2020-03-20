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

extension PostViewModel {
    init(post: Post) {
        postIdentifier = post.id
        isRead = post.visited
        subreddit = "r/" + post.subreddit
        timeAgo = {
            let date = Date(timeIntervalSince1970: post.createdAt)
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            return formatter.localizedString(for: date, relativeTo: Date())
        }()
        title = post.title
        
        // Need to control a special case where value "default" is sent by the API in the `thumbnail` attribute
        // And, believe it or not, `URL(string: "default")` returns an `URL` instance instead of `nil`....
        if let thumbnail = post.thumbnail, thumbnail.starts(with: "http") {
            image = URL(string: thumbnail)
        } else {
            image = nil
        }

        user = "u/" + post.author
        comments = "\(post.comments) comments"
        
    }
}
