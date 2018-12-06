//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var Sname: String
    var imageURL:String
    var backimageURL: String
    var followersCount: Int
    var followingCount: Int
    
    var dictionary: [String: Any]?
    
    private static var _current: User?
    
    
    init(dictionary: [String: Any]) {
        
        name = dictionary["name"] as! String
        Sname = dictionary["screen_name"] as! String
        let image = dictionary["profile_image_url_https"] as! String
        let backimage = dictionary["profile_background_image_url_https"] as! String
        imageURL = String((image.dropLast(11))) + ".jpg"
        backimageURL = String((backimage.dropLast(11))) + ".jpg"
        followersCount = dictionary["followers_count"] as! Int
        followingCount = dictionary["friends_count"] as! Int
        
        self.dictionary = dictionary;
    }
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            
            return _current
        }
        
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    
    
}
