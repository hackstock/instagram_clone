//
//  AppConfig.swift
//  Instagram Clone
//
//  Created by Edward Pie on 26/01/2017.
//  Copyright © 2017 Hubtel. All rights reserved.
//

import Foundation
class AppConfig{
    
    static let ACCESS_TOKEN_KEY = "ACCESS_TOKEN_KEY"
    
    static let TargetApiEnvironment = InstagramEnvironment.SANDBOX
    
    static func storeAccessToken(token: String){
        UserDefaults.standard.set(token, forKey: AppConfig.ACCESS_TOKEN_KEY)
    }
    
    static func getAccessToken() -> String?{
        return UserDefaults.standard.value(forKey: AppConfig.ACCESS_TOKEN_KEY) as? String
    }
    
    enum InstagramEnvironment{
        case SANDBOX
        case PRODUCTION
        
        func getEnvironmentConfiguration() -> (clientID: String, clientSecret: String, redirectUrl: String){
            var configuration = ("","","")
            
            switch self {
            case .SANDBOX:
                configuration = ("a8cb1757cdb0408086804f078c7a2d30","519315f81aa44584a05f78bdbe1d391b","http://edwardpie.herokuapp.com/")
            case .PRODUCTION:
                configuration = ("","","")
            }
            
            return configuration
        }
    }
}
