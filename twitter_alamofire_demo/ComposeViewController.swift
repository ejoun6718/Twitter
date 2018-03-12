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

class ComposeViewController: UIViewController, UITextViewDelegate {
    var delegate: ComposeViewControllerDelegate?
  
  @IBOutlet weak var charactersCountLabel: UILabel!
  
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
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textView.becomeFirstResponder()
    textView.delegate = self
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    // Set the max character limit
    let characterLimit = 140
    
    // Construct what the new text would be if we allowed the user's latest edit
    let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
    
    charactersCountLabel.text = String(characterLimit - newText.characters.count) + " characters remaining"
    
    // The new text should be allowed? True/False
    return newText.characters.count < characterLimit
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
}

