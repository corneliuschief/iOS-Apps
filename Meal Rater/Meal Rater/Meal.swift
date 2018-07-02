//
//  Meal.swift
//  Food Tracker
//
//  Created by Elaine Breen on 24/08/2017.
//  Copyright © 2017 ElaineCo. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //Mark: Proporties
    
    var name: String
    var rating: Int
    var photo: UIImage?
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let rating = "rating"
        static let photo = "photo"
        
    }
    
    //Mark: Initialization
    
    init?(name: String, rating: Int, photo: UIImage?) {
        
        guard !name.isEmpty else {
            return nil
        }
        
        guard (rating >= 0) && (rating < 6) else {
            return nil
        }
        
        //Initialize stored properties
        self.name = name
        self.rating = rating
        self.photo = photo
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(photo, forKey: PropertyKey.photo)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
            else{
                os_log("Unable to decode the name for a meal object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        //Because phot is optional property of Meal, just use conditional cast
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        //Must call designatedinitializer
        self.init(name: name, rating: rating, photo: photo)
    }
}
