//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate {

  var tweets: [Tweet] = []

  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 50
    }
  }
  @IBAction func onLogOut(_ sender: Any) {
    APIManager.logout()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100
    
    APIManager.shared.getHomeTimeLine { (tweets, error) in
      if let tweets = tweets {
        self.tweets = tweets
        self.tableView.reloadData()
      } else if let error = error {
        print("Error getting home timeline: " + error.localizedDescription)
      }
    }
    
    // Initialize a UIRefreshControl
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
    // add refresh control to table view
    tableView.insertSubview(refreshControl, at: 0)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
    
    cell.tweet = tweets[indexPath.row]
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // Makes a network request to get updated data
  // Updates the tableView with the new data
  // Hides the RefreshControl
  func refreshControlAction(_ refreshControl: UIRefreshControl) {
    refresh()
      
    // Tell the refreshControl to stop spinning
    refreshControl.endRefreshing()
  }
  
  func refresh() {
    APIManager.shared.getHomeTimeLine { (tweets, error) in
      if let tweets = tweets {
        self.tweets = tweets
        self.tableView.reloadData()
      } else if let error = error {
        print("Error getting home timeline: " + error.localizedDescription)
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let cell = sender as? UITableViewCell {
      // Get the index path from the cell that was tapped
      if let indexPath = tableView.indexPath(for: cell) {
        let tweet = tweets[indexPath.row]
        let detailViewController = segue.destination as! TweetDetailViewController
        
        // Pass on the data to the Detail ViewController
        detailViewController.tweet = tweet
      }
    }
    else {
      let composeViewController = segue.destination as! ComposeViewController
      composeViewController.delegate = self;
    }
  }
  
  func did(post: Tweet) {
    refresh()
  }
}
