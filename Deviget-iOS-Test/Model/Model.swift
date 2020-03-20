//
//  Model.swift
//  Deviget-iOS-Test
//
//  Created by Nicolas Jakubowski on 3/19/20.
//  Copyright © 2020 Nicolas Jakubowski. All rights reserved.
//

import Foundation

struct ListingRoot: Decodable {
    let data: Listing
    
    enum Keys: String, CodingKey {
        case data
    }
}

struct Listing: Decodable {
    let children: [Post]
    let after: String?
    
    enum Keys: String, CodingKey {
        case children
        case after
    }
}

struct Post: Decodable {
    let id: String // i.e. "fliybz"
    let title: String // i.e. "Kim Jong-un's bodyguards protecting his limo"
    let subreddit: String // i.e. "ThatsInsane"
    let author: String // i.e. "Monster133768"
    let createdAt: Double // i.e. 1584655854
    let thumbnail: String? // i.e. "https://b.thumbs.redditmedia.com/361muuMNyzAa9KfdO7RYDQYo13UPH10UzjjZ3AYsjlA.jpg"
    let comments: Int // i.e. 321
    let visited: Bool // i.e. false
    
    enum TopKeys: String, CodingKey {
        case data
    }
    
    enum PostKeys: String, CodingKey {
        case id
        case title
        case subreddit
        case author
        case createdAt = "created_utc"
        case thumbnail
        case comments = "num_comments"
        case visited
    }
    
    init(from decoder: Decoder) throws {
        /*
         Here we will receive something with the following form:
         {
         "kind": "t3",
         "data": { (actual post data) }
         }
         
         We don't care about the "kind" parameter, just about the "data"
         We cannot achieve this with synthesized decoder so we need to use a custom one here
         */
        
        let base = try decoder.container(keyedBy: TopKeys.self)
        let data = try base.nestedContainer(keyedBy: PostKeys.self, forKey: .data)
        
        id = try data.decode(String.self, forKey: .id)
        title = try data.decode(String.self, forKey: .title)
        subreddit = try data.decode(String.self, forKey: .subreddit)
        author = try data.decode(String.self, forKey: .author)
        createdAt = try data.decode(Double.self, forKey: .createdAt)
        thumbnail = try data.decodeIfPresent(String.self, forKey: .thumbnail)
        comments = try data.decode(Int.self, forKey: .comments)
        visited = try data.decode(Bool.self, forKey: .visited)
    }
    
}


