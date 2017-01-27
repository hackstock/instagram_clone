//
//  FeedItem.swift
//  Instagram Clone
//
//  Created by Edward Pie on 27/01/2017.
//  Copyright © 2017 Hubtel. All rights reserved.
//

struct FeedItem {
    var id: String!
    var type: String!
    var isLikedByUser: Bool!
    var comments: Int!
    var likes: Int!
    var caption: String!
    var thumbnailUrl: String!
    var mediaUrl: String!
    var user: User!
    
    init(id: String, type: String, isLikedByUser: Bool, comments: Int, likes: Int, caption: String, thumbnailUrl: String, mediaUrl: String, user: User) {
        self.id = id
        self.type = type
        self.isLikedByUser = isLikedByUser
        self.comments = comments
        self.likes = likes
        self.caption = caption
        self.thumbnailUrl = thumbnailUrl
        self.mediaUrl = mediaUrl
        self.user = user
    }
    
    static func fromJson(json: [String: Any]) -> FeedItem{
        let id = (json["id"] != nil) ? json["id"] as? String : ""
        let type = (json["type"] != nil) ? json["type"] as? String : ""
        let isLikedByUser = (json["user_has_liked"] != nil) ? json["user_has_liked"] as? Bool : false
        var likes = 0
        if json["likes"] != nil{
            let likesJsonNode = json["likes"] as? [String: Any]
            likes = (likesJsonNode?["count"] as? Int)!
        }else{
            likes = 0
        }
        
        var comments = 0
        if json["comments"] != nil{
            let commentsJsonNode = json["comments"] as? [String: Any]
            likes = (commentsJsonNode?["count"] as? Int)!
        }else{
            comments = 0
        }
        
        var caption = ""
        if json["caption"] != nil{
            let captionJsonNode = json["caption"] as? [String: Any]
            caption = (captionJsonNode?["text"] != nil) ? (captionJsonNode?["text"] as? String)! : ""
        }else{
            caption = ""
        }
        
        var thumbnailUrl = ""
        if json["images"] != nil{
            let imagesJsonNode = json["images"] as? [String: Any]
            let standardResolutionNode = imagesJsonNode?["standard_resolution"] as? [String: Any]
            thumbnailUrl = (standardResolutionNode?["url"] as? String)!
        }else{
            thumbnailUrl = ""
        }
        
        let mediaUrl = ""
        
        
        var user: User? = nil
        if json["user"] != nil{
            let userJsonNode = json["user"] as? [String: Any]
            user = User.fromJson(json: userJsonNode!)
        }else{
            user = nil
        }
        
        return FeedItem(id: id!, type: type!, isLikedByUser: isLikedByUser!, comments: comments, likes: likes, caption: caption, thumbnailUrl: thumbnailUrl, mediaUrl: mediaUrl, user: user!)
        
    }
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
