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
  
  var tweet: Tweet! {
    didSet {
      tweetTextLabel.text = tweet.text
      screennameLabel.text = "@" +  tweet.user.screenName!
      usernameLabel.text =  tweet.user.name
      retweetCountLabel.text = "Retweets: " + String(tweet.retweetCount)
      timestampLabel.text = tweet.createdAtString
      favoriteCountLabel.text = String(tweet.favoriteCount!)
      
      if tweet.favorited! {
        favoriteButton.isSelected = true
        favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
      }
      else {
        favoriteButton.isSelected = false
        favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
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
