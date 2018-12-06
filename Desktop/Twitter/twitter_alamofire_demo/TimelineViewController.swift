//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Trustin Harris on 4/13/18.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ProfileButton: UIBarButtonItem!
    @IBOutlet weak var TweetButton: UIBarButtonItem!
    var tweets: [Tweet] = []
    
    @IBOutlet weak var tableView: UITableView!
    var refreshController: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 128
        
        getTimeLine()
        
        refreshController = UIRefreshControl();
        refreshController.addTarget(self, action: #selector(TimelineViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshController, at: 0)
        
        
    }
    
    func getTimeLine() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    func didPullToRefresh(_ refreshController: UIRefreshControl) {
        getTimeLine()
        self.refreshController.endRefreshing()
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
    
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ProfileSegue" {
            
        }
        else if segue.identifier == "SegueB" {
            
        }else {
        
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let tweet = tweets[indexPath.row]
            let detailVC = segue.destination as! DetailViewViewController
            detailVC.tweet = tweet
        }
        }
    }
    

    
     @IBAction func ProfileButton(_ sender: UIButton) {
     performSegue(withIdentifier: "Profile", sender: nil)
     }
    
    @IBAction func Composing(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueB", sender: nil)
    }
    
 
}
