//
//  User.swift
//  Twitter App
//
//  Created by Alex  Oser on 2/16/16.
//  Copyright © 2016 Alex Oser. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: URL?
    var tagline: String?
    var dictionary: NSDictionary
    var followerCount: Int?
    var followingCount: Int?
    var tweetCount: Int?
    var coverImageUrl: URL?
    
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let imageUrl = dictionary["profile_image_url"] as? String
        if let imageUrl = imageUrl{
            profileImageUrl = URL(string: imageUrl)
        } else {
            coverImageUrl = nil
        }
        tagline = dictionary["description"] as? String
        let coverUrl = dictionary["profile_banner_url"] as? String
        if let coverUrl = coverUrl{
            coverImageUrl = URL(string: coverUrl)
        } else {
            coverImageUrl = nil
        }
        
        
        tagline = dictionary["description"] as? String
        followerCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        tweetCount = dictionary["statuses_count"] as? Int
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
        
                let userData = defaults.object(forKey: "currentUserData") as? Data
        
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.set(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
}
