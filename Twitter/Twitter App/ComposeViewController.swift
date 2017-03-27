//
//  ComposeViewController.swift
//  Twitter App
//
//  Created by Alex  Oser on 3/1/16.
//  Copyright © 2016 Alex Oser. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    var sendTo: Tweet? = nil
    
    @IBAction func closeButton(_ sender: AnyObject) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func sendButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance.postStatus(tweetTextView.text)
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.delegate = self
        
        if let sendTo = sendTo {
            tweetTextView.text = "@\(sendTo.user!.screenname! as String)"
        } else {
            tweetTextView.text = "Enter Tweet"
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
