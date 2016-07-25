//
//  DetailsViewController.swift
//  TwitterDemo
//
//  Created by sophie on 7/24/16.
//  Copyright © 2016 CorazonCreations. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var heightSomeoneTweeted: NSLayoutConstraint!
    

    @IBOutlet weak var someoneRetweetView: UIView!
    
    @IBOutlet weak var someoneRetweetImage: UIImageView!
    
    @IBOutlet weak var someoneRetweetLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var tweetFieldLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    let composeSegueName = "composeSegue"
    
    var tweet: Tweet?
    
    func bindingValuesToView() {
        if let profileUrl = tweet?.user?.profileUrl {
            self.profileImageView?.setImageWithURL(profileUrl)
        } else {
            self.profileImageView.image = nil
        }
        self.nameLabel.text = tweet?.user?.name as? String
        self.screenNameLabel.text = tweet?.user?.screenName as? String
        
        if let retweetCount = tweet?.retweetCount {
            self.retweetCountLabel.text = "\(retweetCount) retweets"
        }
        
        if let favoritesCount = tweet?.favoritesCount {
            self.favoriteCountLabel.text = "\(favoritesCount) favorites"
        }
        
        if let timestamp = tweet?.formattedDateToStr {
            self.timestampLabel.text = String(timestamp)
        }
        self.tweetFieldLabel.text = self.tweet?.text
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem?.title = ""
        
        bindingValuesToView()
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 5
        
        heightSomeoneTweeted.constant = 0 
        
        // Do any additional setup after loading the view.
    }
    
    static func initFromStoryBoard() -> DetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier("DetailsViewController") as! DetailsViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReplyAction(sender: UIButton) {
    }
    
    @IBAction func onRetweetAction(sender: UIButton) {
        TwitterClient.sharedInstance.retweet((tweet?.idStr)!, success: { (tweet: Tweet) in
            print("retweet successfully")
            
            self.retweetCountLabel.text = "\(tweet.retweetCount) retweets"
            
        }) { (error: NSError) in
                print(error.localizedDescription)
        }
    }
    
    @IBAction func onFavoriteAction(sender: UIButton) {
        TwitterClient.sharedInstance.createFavorite((self.tweet?.idStr)!, success: { (tweet: Tweet) in
            print("liked")
            
            
            self.favoriteCountLabel.text = "\(tweet.favoritesCount) favorites"
            
        }) { (error: NSError) in
                print(error.localizedDescription)
        }
    }
    
    @IBAction func onBackAction(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == composeSegueName {
           let composeVC = segue.destinationViewController as! ComposeTweetsViewController
            composeVC.isReply = true
            composeVC.replyToStatusId = tweet?.idStr
            
            if let authorScreenName = tweet?.user?.screenName as? String {
                composeVC.screenNameToReply = authorScreenName
            }
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
