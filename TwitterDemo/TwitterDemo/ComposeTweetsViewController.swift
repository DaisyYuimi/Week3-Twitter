//
//  ComposeTweetsViewController.swift
//  TwitterDemo
//
//  Created by sophie on 7/24/16.
//  Copyright © 2016 CorazonCreations. All rights reserved.
//

import UIKit

class ComposeTweetsViewController: UIViewController  {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var remainCharactersLAbel: UILabel!
    
    @IBOutlet weak var tweetField: UITextView!
    
    let maximumStatusCharCount = 140
    
    var isReply = false
    
    var replyToStatusId: String?
    var screenNameToReply: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImageView.layer.masksToBounds = true
        self.profileImageView.layer.cornerRadius = 5
        self.tweetField.becomeFirstResponder()
        
        self.tweetField.delegate = self
        
        self.inputUser()
        
        
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweetCompose(sender: UIBarButtonItem) {
        
        let tweetStatus = tweetField.text
        var params = [ "status": tweetStatus ]
        
        if isReply {
            params["in_reply_to_status_id"] = replyToStatusId
        }
        
        TwitterClient.sharedInstance.postTweet(params, success: { (tweet: Tweet) in
            print("Update tweet successfully")
            self.navigationController?.popViewControllerAnimated(true)
        }) { (error: NSError) in
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func onCancel(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func inputUser() {
        let user = User.currentUser!
        
        if let profileImgUrl = user.profileUrl {
            self.profileImageView.setImageWithURL(profileImgUrl)
        }
        
        if let name = user.name {
            self.nameLabel.text = name as String?
        }
        
        if let screenName = user.screenName {
            self.screenNameLabel.text = screenName as String?
        }
        
        if isReply {
            if let screenNameToReply = screenNameToReply {
                tweetField.text = screenNameToReply
            }
            
            navigationItem.rightBarButtonItem?.title = "Reply"
        }
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

extension ComposeTweetsViewController: UITextViewDelegate {
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let currentTextCount = textView.text.characters.count
        let remainingCount = maximumStatusCharCount - currentTextCount
        remainCharactersLAbel.text = "\(remainingCount)"
        
        return remainingCount > 0 || text.characters.count == 0
    }
}
