//
//  FeedItem.swift
//  Instagram Clone
//
//  Created by Edward Pie on 27/01/2017.
//  Copyright © 2017 Hubtel. All rights reserved.
//

struct FeedItem {
    var id: String!
    var createdAt: Int!
    var type: String!
    var isLikedByUser: Bool!
    var comments: Int!
    var likes: Int!
    var caption: String!
}

struct User {
    var id: String!
    var username: String!
    var fullname: String!
    var avatarUrl: String!
    
    init(id: String, username: String, fullname: String,avatarUrl: String) {
        self.id = id
        self.username = username
        self.fullname = fullname
        self.avatarUrl = avatarUrl
    }
    
    static func fromJson(json: [String: Any]) -> User{
        let id = (json["id"] != nil) ? json["id"] as? String : ""
        let username = (json["username"] != nil) ? json["username"] as? String : ""
        let fullname = (json["full_name"] != nil) ? json["full_name"] as? String : ""
        let avatarUrl = (json["profile_picture"] != nil) ? json["profile_picture"] as? String : ""
        
        return User(id: id!, username: username!, fullname: fullname!, avatarUrl: avatarUrl!)
    }
}
