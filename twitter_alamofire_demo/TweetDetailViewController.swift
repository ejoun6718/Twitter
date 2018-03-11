//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Hye Lim Joun on 3/6/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var screennameLabel: UILabel!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var timestampLabel: UILabel!
  @IBOutlet weak var favoriteCountLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var retweetButton: UIButton!
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var replyButton: UIButton!
  
  var tweet: Tweet!
  
  @IBAction func onFavorite(_ sender: UIButton) {
    tweet.favorited = !tweet.favorited!
    sender.isSelected = !sender.isSelected
    
    if tweet.favorited! {
      tweet.favoriteCount = tweet.favoriteCount! + 1
      APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
        if let  error = error {
          print("Error favoriting tweet: \(error.localizedDescription)")
        } else if let tweet = tweet {
          print("Successfully favorited the following Tweet: \n\(tweet.text)")
        }
      }
    }
    else {
      tweet.favoriteCount = tweet.favoriteCount! - 1
      APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
        if let  error = error {
          print("Error unfavoriting tweet: \(error.localizedDescription)")
        } else if let tweet = tweet {
          print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
        }
      }
    }
    refreshData()
  }
  
  @IBAction func onRetweet(_ sender: UIButton) {
    tweet.retweeted = !tweet.retweeted
    sender.isSelected = !sender.isSelected
    
    if tweet.retweeted {
      tweet.retweetCount = tweet.retweetCount + 1
      APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
        if let  error = error {
          print("Error retweeting tweet: \(error.localizedDescription)")
        } else if let tweet = tweet {
          print("Successfully retweeted the following Tweet: \n\(tweet.text)")
        }
      }
    }
    else {
      tweet.retweetCount = tweet.retweetCount - 1
      APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
        if let  error = error {
          print("Error unretweeting tweet: \(error.localizedDescription)")
        } else if let tweet = tweet {
          print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
        }
      }
    }
    refreshData()
  }
  @IBAction func onReply(_ sender: Any) {
  }
  
  func refreshData() {
    favoriteCountLabel.text = String(tweet.favoriteCount!)
    retweetCountLabel.text = String(tweet.retweetCount)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    tweetTextLabel.text = tweet.text
    tweetTextLabel.text = tweet.text
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
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
