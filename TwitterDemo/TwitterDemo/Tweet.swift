//
//  Tweet.swift
//  TwitterDemo
//
//  Created by sophie on 7/20/16.
//  Copyright © 2016 CorazonCreations. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var idStr: String?
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var user: User?
    
    var formattedDateToStr: String? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "M/d/yy, H:mm"
        return formatter.stringFromDate(timestamp!)
    }
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        
       
        if let timestampString = dictionary["created_at"] as? String {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
        
        if let idStr = dictionary["id_str"] as? String {
            self.idStr = idStr
        }
        
        let userDict = dictionary["user"] as? Dictionary<String, AnyObject>
        if let userDict = userDict  {
            user = User(dictionary: userDict)
        }
    }
    

    class func tweetsWithArray (dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
    
}
