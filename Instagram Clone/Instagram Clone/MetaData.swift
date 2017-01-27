//
//  MetaData.swift
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
