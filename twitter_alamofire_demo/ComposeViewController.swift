//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Hye Lim Joun on 3/11/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate {
  func did(post: Tweet)
}

class ComposeViewController: UIViewController {
  
  var delegate: ComposeViewControllerDelegate?
  
  @IBOutlet weak var textView: UITextView!
  @IBAction func didTapPost(_ sender: Any) {
    APIManager.shared.composeTweet(with: textView.text) { (tweet, error) in
      if let error = error {
        print("Error composing Tweet: \(error.localizedDescription)")
      } else if let tweet = tweet {
        self.delegate?.did(post: tweet)
        print("Compose Tweet Success!")
      }
    }
  }
}
