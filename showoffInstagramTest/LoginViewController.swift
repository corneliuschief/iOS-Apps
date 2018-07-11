//
//  LoginViewController.swift
//  showoffTest
//
//  Created by Conor Forrest on 04/07/2018.
//  Copyright © 2018 ElaineCo. All rights reserved.
//  Displays the instagram authorization page in a WKWebView object
//  Returns the access_token

import Foundation
import WebKit
import SwiftKeychainWrapper

class LoginViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var loginView: WKWebView!
    
    private var constants = Constants()
    
//    struct API {
//
        //authURL format should be:
//        //https://api.instagram.com/oauth/authorize/?client_id=CLIENT-ID&redirect_uri=REDIRECT-URI&response_type=token
//        static let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize"
//        static let INSTAGRAM_CLIENT_ID = "5a93badaa6b84420823b1cee5610ca9b"
//        static let INSTAGRAM_CLIENTSECRET = "e8ba0a9135304898862be4ae833ec74e"
//        static let INSTAGRAM_REDIRECT_URI = "https://none.none"
        //    let INSTAGRAM_SCOPE = "public_content"
//    }
    
    override func loadView() {
        super.loadView()
        //        super.viewDidLoad()
        loginView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        view.self = loginView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loginView.uiDelegate = self
        loginView.navigationDelegate = self
//        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token", arguments: [API.INSTAGRAM_AUTHURL,API.INSTAGRAM_CLIENT_ID,API.INSTAGRAM_REDIRECT_URI])
        
        //        let urlRequest = URLRequest.init(url: URL.init(string: authURL)!)
        let authURL = constants.getAuthorizationUrl()
        loginView.load(URLRequest(url: URL(string: authURL)!))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    //    func webViewDidFinishLoad(_ webView: UIWebView) {
    //        if let text = loginView.url?.absoluteString{
    //            print(text)
    //        }
    //    }
    
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
        guard let redirectURL = loginView.url?.absoluteString
            else {
                return
        }
        guard redirectURL.contains("#access_token=")
            else {
                return
        }
        let range: Range<String.Index> = redirectURL.range(of: "#access_token=")!
//        let accessToken = redirectURL.//substring(to: range.upperBound)
        let accessToken = String(redirectURL[range.upperBound...])

        print("Access token is \(accessToken)")
        let accessTokenSaved: Bool = KeychainWrapper.standard.set(accessToken, forKey: "access_token")

        if accessTokenSaved == false {
            print("----- Access token could not be saved to the keychain..")
        }
        performSegue(withIdentifier: "UserPage", sender: self)
        
        // segue to new view controller with access key and get user data
    }
}


