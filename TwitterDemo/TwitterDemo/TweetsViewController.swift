//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by sophie on 7/21/16.
//  Copyright © 2016 CorazonCreations. All rights reserved.
//

import UIKit
import MBProgressHUD

class TweetsViewController: UIViewController {

    var tweets:[Tweet]! = []
    let refreshControl = UIRefreshControl()
    let detailsSegueName = "detailsSegue"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160
        
        TwitterClient.sharedInstance.homeTimeLine({(tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
//            for tweet in tweets {
//                print(tweet.retweetCount)
//                print(tweet.timestamp)
//            }
        }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }
        
        self.pullToRefresh()
        tableView.dataSource = self
        tableView.reloadData()
        self.loadTweets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogoutButton(sender: UIBarButtonItem) {
        
        TwitterClient.sharedInstance.logout()
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == detailsSegueName {
            let nextVC = segue.destinationViewController as! DetailsViewController
            let selectedTweet = tweets[tableView.indexPathForSelectedRow!.row]
            nextVC.tweet = selectedTweet
        }
    }
  
    // pull to refresh method
    
    func pullToRefresh() {
        self.refreshControl.addTarget(self, action: #selector(TweetsViewController.loadTweets), forControlEvents: .ValueChanged)
        self.tableView.insertSubview(self.refreshControl, atIndex: 0)
    }
    
    // MARK: - load data methods 
    
    func loadTweets() {
        self.loadingTweets()
        TwitterClient.sharedInstance.homeTimeLine({ (tweet: [Tweet]) in
            self.tweets = tweet
            self.loadTweetsSuccessful()
        }) { (error: NSError) in
                self.loadTweetsFailed()
        }
    }
    
    func loadingTweets() {
        let loadingView = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingView.mode = MBProgressHUDMode.Indeterminate
    }
    
    func loadTweetsSuccessful() {
        self.refreshControl.endRefreshing()
        self.tableView.reloadData()
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
    
    func loadTweetsFailed() {
        self.refreshControl.endRefreshing()
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
 }

extension TweetsViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetsCell", forIndexPath: indexPath) as! TweetsCell
        cell.tweet = self.tweets[indexPath.row]

        return cell
    }
}

//
//extension TweetsViewController: UITableViewDelegate {
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let selectedTweet = tweets[indexPath.row]
//        let detailsVC = DetailsViewController.initFromStoryBoard()
//        detailsVC.tweet = selectedTweet
//        navigationController?.pushViewController(detailsVC, animated: true)
//    }
//}
