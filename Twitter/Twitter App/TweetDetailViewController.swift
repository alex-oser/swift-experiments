//
//  TweetDetailViewController.swift
//  Twitter App
//
//  Created by Alex  Oser on 2/29/16.
//  Copyright © 2016 Alex Oser. All rights reserved.
//

import UIKit
import AFNetworking

class TweetDetailViewController: UIViewController {
    
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
    
    @IBAction func replyButton(_ sender: AnyObject) {
    }
    
    @IBAction func retweetButton(_ sender: AnyObject) {
        if(tweet.retweeted){
            
            TwitterClient.sharedInstance.detweet(tweet)
            tweet.retweetCount = tweet.retweetCount - 1
            tweet.retweeted = false
            
        } else{
            TwitterClient.sharedInstance.retweet(tweet)
            tweet.retweetCount = tweet.retweetCount + 1
            tweet.retweeted = true
        }
        retweetsLabel.text = "Retweets: \(tweet.retweetCount)"
    }
    
    @IBAction func favoriteButton(_ sender: AnyObject) {
        if(tweet.favorited){
            TwitterClient.sharedInstance.unfav(tweet)
            tweet.favoritesCount = tweet.favoritesCount - 1
            tweet.favorited = false
        } else{
            TwitterClient.sharedInstance.fav(tweet)
            tweet.favoritesCount = tweet.favoritesCount + 1
            tweet.favorited = true
        }
        favoritesLabel.text = "Favorites: \(tweet.favoritesCount)"
    }
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let username = tweet.user?.name
        let tweetText = tweet.text!
        let profileImageUrl = tweet.user?.profileImageUrl
        let timestamp = tweet.createdAt!
        
        usernameLabel.text = username
        tweetLabel.text = tweetText
        profileView.setImageWithURL(profileImageUrl!)
        timeLabel.text = "\(timestamp)"
        favoritesLabel.text = "Favorites \(tweet.favoritesCount)"
        retweetsLabel.text = "Retweets \(tweet.retweetCount)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let replyViewController = segue.destination as! ComposeViewController
        replyViewController.sendTo = tweet
    }
    

}
