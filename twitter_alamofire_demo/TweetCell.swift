//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class TweetCell: UITableViewCell {
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var screennameLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var timestampLabel: UILabel!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var favoriteCountLabel: UILabel!
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var retweetButton: UIButton!
  
  var tweet: Tweet! {
    didSet {
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
  }
  
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
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func refreshData() {
    favoriteCountLabel.text = String(tweet.favoriteCount!)
  }
}
