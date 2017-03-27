//
//  BusinessCell.swift
//  Yelp
//
//  Created by Alex  Oser on 2/14/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    var business: Business! {
        didSet {
            restaurantLabel.text = business.name
            thumbnailView.setImageWithURL(business.imageURL!)
            infoLabel.text = business.categories
            reviewsLabel.text = "\(business.reviewCount!) Reviews"
            addressLabel.text = business.address
            distanceLabel.text = business.distance
            ratingsImageView.setImageWithURL(business.ratingImageURL!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailView.layer.cornerRadius = 4
        thumbnailView.clipsToBounds = true
        
//        restaurantLabel.preferredMaxLayoutWidth = restaurantLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        restaurantLabel.preferredMaxLayoutWidth = restaurantLabel.frame.size.width
    }
}
