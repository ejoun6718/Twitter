//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Hye Lim Joun on 3/11/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
  @IBOutlet weak var profileImageView: UIImageView!
  
  @IBOutlet weak var taglineLabel: UILabel!
  @IBOutlet weak var tweetsCountLabel: UILabel!
  @IBOutlet weak var followingCountLabel: UILabel!
  @IBOutlet weak var followerCountLabel: UILabel!
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*tweetTextLabel.text = tweet.text
        screennameLabel.text = "@" +  tweet.user.screenName!
        usernameLabel.text =  tweet.user.name
        retweetCountLabel.text = String(tweet.retweetCount)
        timestampLabel.text = tweet.createdAtString
        favoriteCountLabel.text = String(tweet.favoriteCount!)
    
        if tweet.favorited! {
          favoriteButton.isSelected = true
        } else {
          favoriteButton.isSelected = false
        }
    
        if tweet.retweeted {
          retweetButton.isSelected = true
        } else {
          retweetButton.isSelected = false
        }
    
        if let userProfileURL = self.tweet.user.profileImageURL{
          let url = URL(string: userProfileURL)
          profileImageView.af_setImage(withURL: url!)
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
