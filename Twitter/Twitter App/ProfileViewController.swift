//
//  ProfileViewController.swift
//  Twitter App
//
//  Created by Alex  Oser on 3/1/16.
//  Copyright © 2016 Alex Oser. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user: User!

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = user.name
        descriptionLabel.text = user.tagline
        tweetsLabel.text = "\(user.tweetCount!)"
        followingLabel.text = "\(user.followingCount!)"
        followersLabel.text = "\(user.followerCount!)"
        
        profileImageView.setImageWithURL(user.profileImageUrl!)
        if let coverImageUrl = user.coverImageUrl {
            coverImageView.setImageWithURL(coverImageUrl)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
