//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by sophie on 7/19/16.
//  Copyright © 2016 CorazonCreations. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogginButton(sender: UIButton) {
        let client = TwitterClient.sharedInstance
        
        client.login({ () -> () in
            //self.performSegueWithIdentifier("loginSegue", sender: nil)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.openTweetsViewController()
        }) { (error: NSError) in
            print("Error: \(error.localizedDescription)")
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
