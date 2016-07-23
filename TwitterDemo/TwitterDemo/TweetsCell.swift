//
//  TweetsCell.swift
//  TwitterDemo
//
//  Created by sophie on 7/21/16.
//  Copyright © 2016 CorazonCreations. All rights reserved.
//

import UIKit

class TweetsCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
   
    @IBOutlet weak var likesCountLabel: UILabel!
    
    @IBOutlet weak var retweetsCountLabel: UILabel!
    
    
   // data
    var tweet:Tweet! {
        didSet {
            self.tweetTextLabel.text = self.tweet.text
            self.likesCountLabel.text = String(self.tweet.favoritesCount)
            self.retweetsCountLabel.text = String(self.tweet.retweetCount)
            
            if let user = self.tweet.user {
                self.inputUser(user)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileImageView.layer.masksToBounds = true
        self.profileImageView.layer.cornerRadius = 5
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func inputUser(user: User) {
        if let profileImgUrl = user.profileUrl {
            self.profileImageView.setImageWithURL(profileImgUrl)
        }
        
        if let name = user.name {
            self.nameLabel.text = name as String?
        }
        
        if let screenName = user.screenName {
            self.screenNameLabel.text = screenName as String?
        }
    }

}
