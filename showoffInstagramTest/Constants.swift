//
//  Constants.swift
//  showoffTest
//
//  Created by Conor Forrest on 06/07/2018.
//  Copyright © 2018 ElaineCo. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class Constants {
    
    private var accessToken = ""
    private var logOutURL = "https://instagram.com/accounts/logout/"
    private struct API {
        
        //authURL format should be:
        //https://api.instagram.com/oauth/authorize/?client_id=CLIENT-ID&redirect_uri=REDIRECT-URI&response_type=token
        static let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize"
        static let INSTAGRAM_CLIENT_ID = "5a93badaa6b84420823b1cee5610ca9b"
        static let INSTAGRAM_CLIENTSECRET = "e8ba0a9135304898862be4ae833ec74e"
        static let INSTAGRAM_REDIRECT_URI = "https://none.none"
        //    let INSTAGRAM_SCOPE = "public_content"
    }
    
    public func getAuthorizationUrl() -> String {
        
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token", arguments: [API.INSTAGRAM_AUTHURL,API.INSTAGRAM_CLIENT_ID,API.INSTAGRAM_REDIRECT_URI])
        return authURL
    }
    
    public func getUsersSelfUrl() -> String {
        
        if let retrievedString: String = KeychainWrapper.standard.string(forKey: "access_token") {
            accessToken = retrievedString
        }
        
        let INSTAGRAM_USERS_SELF = "https://api.instagram.com/v1/users/self/?access_token="
        let usersSelfURL = String(format: "%@%@", arguments: [INSTAGRAM_USERS_SELF, accessToken])
        return usersSelfURL
        
    }
    
    public func getMediaRecent() -> String {
        
        if let retrievedString: String = KeychainWrapper.standard.string(forKey: "access_token") {
            accessToken = retrievedString
        }
        
        let INSTAGRAM_MEDIA_RECENT = "https://api.instagram.com/v1/users/self/media/recent/?access_token="
        let usersSelfURL = String(format: "%@%@", arguments: [INSTAGRAM_MEDIA_RECENT, accessToken])
        return usersSelfURL
    }
    
    public func getLogoutUrl() -> String {
        return logOutURL
    }
}


