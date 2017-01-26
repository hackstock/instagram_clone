//
//  AppConfig.swift
//  Instagram Clone
//
//  Created by Edward Pie on 26/01/2017.
//  Copyright © 2017 Hubtel. All rights reserved.
//

import Foundation
class AppConfig{
    static let TargetApiEnvironment = InstagramEnvironment.SANDBOX
    static let baseUrl = ""
    static let redirectUrl = ""
    
    enum InstagramEnvironment{
        case SANDBOX
        case PRODUCTION
        
        func getEnvironmentConfiguration() -> (clientID: String, clientSecret: String){
            var configuration = ("","")
            
            switch self {
            case .SANDBOX:
                configuration = ("a8cb1757cdb0408086804f078c7a2d30","")
            case .PRODUCTION:
                configuration = ("","")
            }
            
            return configuration
        }
    }
}
