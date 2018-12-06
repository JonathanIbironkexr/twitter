//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Trustin Harris on 4/25/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var BackIV: UIImageView!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var UserChoice: UISegmentedControl!
    @IBOutlet weak var FollowersLabel: UILabel!
    @IBOutlet weak var FollowingLabel: UILabel!
    @IBOutlet weak var AtName: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var ProfilePic: UIImageView!
    
   
    var CurrentUser = User.current!
    var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        AtName.text = CurrentUser.Sname
        Name.text = CurrentUser.name
        ProfilePic.af_setImage(withURL: URL(string: (CurrentUser.imageURL))!)
        BackIV.af_setImage(withURL: URL(string: (CurrentUser.backimageURL))!)
        FollowersLabel.text = String((CurrentUser.followersCount))
        FollowingLabel.text = String((CurrentUser.followingCount))
        
        TableView.dataSource = self
        TableView.delegate = self
        getTimeLine()
        TableView.rowHeight = 115
        TableView.estimatedRowHeight = 115
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func getTimeLine() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.TableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

    
}

