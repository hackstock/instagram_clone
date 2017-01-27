//
//  ResponseMetaData.swift
//  Instagram Clone
//
//  Created by Edward Pie on 27/01/2017.
//  Copyright © 2017 Hubtel. All rights reserved.
//

import Foundation

struct ResponseMetaData{
    var code: Int!
    var errorType: String!
    var errorMessage: String!
    
    init(code: Int, errorType: String, errorMessage: String) {
        self.code = code
        self.errorType = errorType
        self.errorMessage = errorMessage
    }
    
    static func newInstance(code: Int, errorType: String, errorMessage: String) -> ResponseMetaData{
        return ResponseMetaData(code: code, errorType: errorType, errorMessage: errorMessage)
    }
    
    static func fromJson(json: [String: Any]) -> ResponseMetaData{
        let code = (json["code"] != nil) ? json["code"] as? Int : 0
        let errorType = (json["error_type"] != nil) ? json["error_type"] as? String : ""
        let errorMessage = (json["error_message"] != nil) ? json[""] as? String : ""
        
        return ResponseMetaData.newInstance(code: code!, errorType: errorType!, errorMessage: errorMessage!)
    }
}

struct PaginationInfo{
    var nextUrl: String!
    var nextMaxId: String!
    
    init(nextUrl: String, nextMaxId: String) {
        self.nextUrl = nextUrl
        self.nextMaxId = nextMaxId
    }
    
    static func newInstance(nextUrl: String, nextMaxId: String) -> PaginationInfo{
        return PaginationInfo(nextUrl: nextUrl, nextMaxId: nextMaxId)
    }
    
    static func fromJson(json: [String: Any]) -> PaginationInfo{
        let nextUrl = json[""] as? String
        let nextMaxId = json[""] as? String
        
        return PaginationInfo.newInstance(nextUrl: nextUrl!, nextMaxId: nextMaxId!)
    }
}

struct FeedItem {

}

struct Response{
    var metaData: ResponseMetaData!
    var paginationInfo: PaginationInfo!
    
    init(metaData: ResponseMetaData, paginationInfo: PaginationInfo) {
        self.metaData = metaData
        self.paginationInfo = paginationInfo
    }
}


