//
//  LogoutViewController.swift
//  showoffTest
//
//  Created by Elaine Breen on 10/07/2018.
//  Copyright © 2018 ElaineCo. All rights reserved.
//

import Foundation
import WebKit
import SwiftKeychainWrapper

class LogoutViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
 
    @IBOutlet weak var logoutView: WKWebView!
    private var constants = Constants()
    
    override func loadView() {
        super.loadView()
        //        super.viewDidLoad()
        logoutView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        view.self = logoutView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        logoutView.uiDelegate = self
        logoutView.navigationDelegate = self
        let logoutURL = constants.getLogoutUrl()
        logoutView.load(URLRequest(url: URL(string: logoutURL)!))
    }
    
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
        performSegue(withIdentifier: "loginScreen", sender: self)
        
        // segue to initial login screen
    }
    
    // following functions set navigation bar invisible
    // in this view and make it reappear for other views
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //show the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        //hide the navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
