//
//  UserPageViewController.swift
//  showoffTest
//
//  Created by ConorForrest on 06/07/2018.
//  Copyright © 2018 ElaineCo. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import os.log
import SwiftKeychainWrapper
import SwiftyJSON
import Alamofire
import SDWebImage

class UserPageViewController: UIViewController, UICollectionViewDataSource, WKUIDelegate, WKNavigationDelegate {
    
    //Mark: Proporties
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var logOut: UIBarButtonItem!
    
    var results:[JSON]? = []
    
    private var constants = Constants()
    
    override func loadView() {
        super.loadView()
    }
    override func viewDidLoad() {
        self.loadInstaData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectioniewCell
                var dict = self.results![indexPath.row]
                cell.textView?.text = dict["caption"]["text"].string
                let imageURL = dict["images"]["thumbnail"]["url"].string
                print(dict["caption"]["text"].string)
                print(imageURL)
                cell.imageView.sd_setImage(with: URL(string: imageURL!), placeholderImage: UIImage(named: "placeholder.png"))
                return cell
    }
        
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
//        var dict = self.results![indexPath.row]
//        cell.instaLabel?.text = dict["caption"]["text"].string
//        let imageURL = dict["images"]["thumbnail"]["url"].string
//        print(dict["caption"]["text"].string)
//        print(imageURL)
//        cell.instaImage.sd_setImage(with: URL(string: imageURL!), placeholderImage: UIImage(named: "placeholder.png"))
//        cell.instaImage?.image = dict["image"] as? String
//        return cell
//        return cell
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.results?.count)!
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.results?.count ?? 0
//    }
    
    func loadInstaData() {
        let url = constants.getMediaRecent()

        Alamofire.request(url, method: .get, parameters: ["":""], encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                
 //               if let data = response.result.value{
 //                   print(data)
 //               }
                var jsonObj = JSON(response.result.value!)
                if let data = jsonObj["data"].arrayValue as [JSON]? {
                    print(data)
                    self.results = data
                    self.collectionView.reloadData()
                }
                break
                
            case .failure(_):
                print(response.result.error!)
                break
                
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //Configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === logOut else {
            os_log("The Log Out button was not pressed, cancelling..", log: OSLog.default, type:.debug)
            return
        }
        let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: "access_token")
        if removeSuccessful == true {
            print("Access token removed from keychain")
            
            //clear cookies
            let cookieJar : HTTPCookieStorage = HTTPCookieStorage.shared
            for cookie in cookieJar.cookies! as [HTTPCookie]{
                NSLog("cookie.domain = %@", cookie.domain)
                
//                if cookie.domain == "www.instagram.com" ||
//                    cookie.domain == "api.instagram.com"{
                if cookie.domain.contains(".instagram.com") ||
                    cookie.domain.contains(".api,instagram.com") {
                    cookieJar.deleteCookie(cookie)
                    print("..and cookies deleted")
                }
            }
        }
    }
}
