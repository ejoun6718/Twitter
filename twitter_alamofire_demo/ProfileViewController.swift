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
    
    let user = User.current
    if let userProfileURL = user?.profileImageURL{
      let url = URL(string: userProfileURL)
      profileImageView.af_setImage(withURL: url!)
    }
      
    followerCountLabel.text = String(describing: (user?.followersCount)!)
    tweetsCountLabel.text = String(describing: (user?.statusesCount)!)
    followingCountLabel.text = String(describing: (user?.followingCount)!)
    taglineLabel.text = String(describing: (user?.screenName)!)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
