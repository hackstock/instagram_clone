//
//  PaginationInfo.swift
//  Instagram Clone
//
//  Created by Edward Pie on 27/01/2017.
//  Copyright © 2017 Hubtel. All rights reserved.
//


struct PaginationInfo{
    var nextUrl: String!
    var nextMaxId: Int!
    
    init(nextUrl: String, nextMaxId: Int) {
        self.nextUrl = nextUrl
        self.nextMaxId = nextMaxId
    }
    
    static func newInstance(nextUrl: String, nextMaxId: Int) -> PaginationInfo{
        return PaginationInfo(nextUrl: nextUrl, nextMaxId: nextMaxId)
    }
    
    static func fromJson(json: [String: Any]) -> PaginationInfo{
        let nextUrl = (json["next_url"] != nil) ? json[""] as? String : ""
        let nextMaxId = (json["next_max_id"] != nil) ? json[""] as? Int : 0
        
        return PaginationInfo.newInstance(nextUrl: nextUrl!, nextMaxId: nextMaxId!)
    }
}
