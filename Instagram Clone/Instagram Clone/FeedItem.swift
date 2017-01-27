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
    var thumbnailUrl: String!
    var mediaUrl: String!
    var user: User!
    
    init(id: String, createdAt: Int, type: String, isLikedByUser: Bool, comments: Int, likes: Int, caption: String, thumbnailUrl: String, mediaUrl: String, user: User) {
        self.id = id
        self.createdAt = createdAt
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
        let createdAt = (json["created_time"] != nil) ? json["created_time"] as? Int : 0
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
            caption = (captionJsonNode?["text"] as? String)!
        }else{
            caption = ""
        }
        
        let thumbnailUrl = "https://scontent.cdninstagram.com/t51.2885-15/e15/16230801_1644932699134323_6205617681270308864_n.jpg?ig_cache_key=MTQzNjg3NDM3NTEyMjc3Mjg1NA%3D%3D.2"
        let mediaUrl = "https://scontent.cdninstagram.com/t51.2885-15/e15/16230801_1644932699134323_6205617681270308864_n.jpg?ig_cache_key=MTQzNjg3NDM3NTEyMjc3Mjg1NA%3D%3D.2"
        
        var user: User? = nil
        if json["user"] != nil{
            let userJsonNode = json["user"] as? [String: Any]
            user = User.fromJson(json: userJsonNode!)
        }else{
            user = nil
        }
        
        return FeedItem(id: id!, createdAt: createdAt!, type: type!, isLikedByUser: isLikedByUser!, comments: comments, likes: likes, caption: caption, thumbnailUrl: thumbnailUrl, mediaUrl: mediaUrl, user: user!)
        
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
