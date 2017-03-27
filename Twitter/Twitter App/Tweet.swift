//
//  Tweet.swift
//  Twitter App
//
//  Created by Alex  Oser on 2/16/16.
//  Copyright © 2016 Alex Oser. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: Date?
    var favoritesCount: Int = 0
    var retweetCount: Int = 0
    var favorited: Bool = false
    var retweeted: Bool = false
    var id: String?
    
    init(dictionary: NSDictionary) {
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        favorited = ((dictionary["favorited"]) as? Bool)!
        retweeted = ((dictionary["retweeted"]) as? Bool)!
        id = dictionary["id_str"] as? String
        

        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.date(from: createdAtString!)
    }
    
    class func tweetsWithArray(_ array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}
