//
//  InstagramCellTableViewCell.swift
//  Instagram App
//
//  Created by Alex  Oser on 3/6/16.
//  Copyright © 2016 Alex Oser. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class InstagramCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoView: PFImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var instagramPost: PFObject! {
        didSet {
            self.photoView.file = instagramPost["image"] as? PFFile
            self.photoView.loadInBackground()
        }
    }

}
