//
//  InstagramViewController.swift
//  Instagram App
//
//  Created by Alex  Oser on 3/1/16.
//  Copyright © 2016 Alex Oser. All rights reserved.
//

import UIKit
import Parse

class InstagramViewController: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate  {

    var window: UIWindow?
    var posts: [AnyObject]!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func logoutButton(_ sender: AnyObject) {
        PFUser.logOut()
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func uploadButton(_ sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let data = posts {
                self.posts = data
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        
        self.tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let data = posts {
                self.posts = data
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstagramCell", for: indexPath) as! InstagramCellTableViewCell
        let post = self.posts![indexPath.row]
        let author: PFUser = post["author"] as! PFUser
        let description = post["caption"]
        let image = post["media"]
        
        cell.selectionStyle = .none
        
        cell.authorLabel.text = author.username
        cell.descriptionLabel.text = description as? String
        cell.photoView.file = image as? PFFile
        cell.photoView.loadInBackground()
    
        return cell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : Any]) {
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            dismiss(animated: true, completion: {Void in self.passImage(originalImage)})

    }
    
    func passImage(_ originalImage: UIImage) {
    
//        let vc = UploadViewController()
//        vc.originalImage = originalImage
//        self.presentViewController(vc, animated: true, completion: nil)
        
        let vc : UploadViewController! = self.storyboard!.instantiateViewController(withIdentifier: "UploadViewController") as! UploadViewController
        vc.originalImage = originalImage
        self.present(vc as UploadViewController, animated: true, completion: nil)
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
