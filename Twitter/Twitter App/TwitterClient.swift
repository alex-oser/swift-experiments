//
//  TwitterClient.swift
//  Twitter App
//
//  Created by Alex  Oser on 2/15/16.
//  Copyright © 2016 Alex Oser. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworking


let twitterConsumerKey = "g26OhrDrARJ7q1JtNm7TpuyTs"
let twitterConsumerSecret = "OR3lAJ1CsiPw9q4kvkWHIlBA0OH0hrCMi7jpY1sXtB2zqQzvCm"
let twitterBaseURL = URL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
        
    static let sharedInstance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)

    
    func login(_ success: @escaping () -> (), failure: @escaping (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        // Fetch request token and redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: URL(string:  "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                self.loginFailure?(error)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UserDidLogout"), object: nil)
    }
    
    func currentAccount(_ success: @escaping (User) -> (), failure: @escaping (NSError) -> ()) {
        TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (operation: URLSessionDataTask, response: AnyObject?) -> Void in
                let userDictionary = response as! NSDictionary
                let user = User(dictionary: userDictionary)
            
                success(user)

            }, failure: { (operation: URLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func homeTimeline(_ success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()) {
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (operation: URLSessionDataTask, response: AnyObject?) -> Void in
                let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                success(tweets)
                
                
            }, failure: { (operation: URLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func openURL(_ url: URL) {
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential (queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            
            self.loginSuccess?()
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
                })
            
            
            print("Received access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken) 
            
            }) { (error: NSError!) -> Void in
                print("Failed to recieve access token")
                self.loginFailure?(error)
        }
           
    }
    
    func retweet(_ tweet: Tweet){
        
        POST("https://api.twitter.com/1.1/statuses/retweet/\(tweet.id!).json", parameters: nil, progress: { (NSProgress) -> Void in
            }, success: { (data: URLSessionDataTask, object: AnyObject?) -> Void in
                print("Retweeted")
            }) { (data: URLSessionDataTask?, error: NSError) -> Void in
                print("Failed to retweet")
                print(error)
        }
        
    }
    
    func detweet(_ tweet: Tweet){
        POST("https://api.twitter.com/1.1/statuses/unretweet/\(tweet.id!).json", parameters: nil, progress: { (NSProgress) -> Void in
            }, success: { (data: URLSessionDataTask, object: AnyObject?) -> Void in
                print("Unretweeted")
            }) { (data: URLSessionDataTask?, error: NSError) -> Void in
                print("Failed to unretweet")
                print(error)
        }
    }
    
    func fav(_ tweet: Tweet){
        POST("https://api.twitter.com/1.1/favorites/create.json?id=\(tweet.id!)", parameters: nil, progress: {
            (NSProgress) -> Void in
            print("hih")
            }, success: { (data: URLSessionDataTask, object: AnyObject?) -> Void in
                print("Favorited")
            }) { (data: URLSessionDataTask?, error: NSError) -> Void in
                print("Failed to favorite")
                print(error)
        }
    }
    
    func unfav(_ tweet: Tweet){
        POST("https://api.twitter.com/1.1/favorites/destroy.json?id=\(tweet.id!)", parameters: nil, progress: {
            (NSProgress) -> Void in
            print("progress!")
            }, success: { (data: URLSessionDataTask, object: AnyObject?) -> Void in
                print("Unfavorited")
            }) { (data: URLSessionDataTask?, error: NSError) -> Void in
                print("Failed to unfavorite")
                print(error)
        }
    }
    
    func postStatus(_ text: String){
        POST("https://api.twitter.com/1.1/statuses/update.json?status=\(text)", parameters: nil, progress: { (NSProgress) -> Void in
            print("getting there")
            }, success: { (data: URLSessionDataTask, object: AnyObject?) -> Void in
                print("success")
            }) { (data: URLSessionDataTask?, error: NSError) -> Void in
                print("failed to post tweet")
        }
    }
    
    func postReply(_ text: String, sendTo: Tweet){
        
                let parameters = [
                    "status": text,
                    "in_reply_to_status_id": sendTo.id
                ]
        
                POST("https://api.twitter.com/1.1/statuses/update.json", parameters: parameters as? AnyObject, progress: { (NSProgress) -> Void in
                    }, success: { (data: URLSessionDataTask, objects: AnyObject?) -> Void in
                    }) { (data: URLSessionDataTask?, error: NSError) -> Void in
                        print(error)
                }
            }

}

