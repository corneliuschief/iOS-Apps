//
//  TableViewCell.swift
//  showoffTest
//
//  Created by Elaine Breen on 09/07/2018.
//  Copyright © 2018 ElaineCo. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class TableViewCell: UITableViewCell {
    
    //MARK: Proporties
    @IBOutlet weak var instaImage: UIImageView!
    @IBOutlet weak var instaLabel: UILabel!
    
//    var entry: Alamofire.JSON? {
//        didSet {
//            self.setupEntry()
//        }
//    }
    
    func setupEntry() {
//        self.instaLabel.text = self.entry?["caption"]["text"].string
//        if let urlString = self.entry?["images"]["standard_resolution"]["url"] {
//            let url = NSURL(string: urlString.stringValue)
//            self.instaImage.hnk_setImageFromURL(url!)
//        }
    }
    
//    override func prepareForReuse() {
//        self.instaImage.image = nil
//    }
}
