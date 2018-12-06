//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var ScreenName: UILabel!
    @IBOutlet weak var AtName: UILabel!
    @IBOutlet weak var RTButton: UIButton!
    @IBOutlet weak var TimeStamp: UILabel!
    @IBOutlet weak var RTLabel: UILabel!
    @IBOutlet weak var FavLabel: UILabel!
    @IBOutlet weak var FavButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            AtName.text = tweet.user.name
            ScreenName.text = tweet.user.Sname
            TimeStamp.text = tweet.createdAtString
            ProfilePic.af_setImage(withURL: URL(string: tweet.user.imageURL)!)
            
            if tweet.retweetCount == 0 {
                RTLabel.text = " "
            } else {
                RTLabel.text = String(tweet.retweetCount)
            }
            
            if tweet.favoriteCount == 0 {
                FavLabel.text = " "
            } else {
                FavLabel.text = String(tweet.favoriteCount)
            }
            
            if (tweet.retweeted == true)
            {
                RTButton.isSelected = true
            } else {
                RTButton.isSelected = false
            }
            
            
            if (tweet.favorited == true)
            {
                FavButton.isSelected = true
            } else {
                FavButton.isSelected = false
            }
            }
        }
    
    
    @IBAction func didTapRT(_ sender: Any) {
        
        if (RTButton.isSelected != true) {
            
            RTButton.isSelected = true
            tweet.retweeted = true
            tweet.retweetCount += 1
            self.RTLabel.text = String(tweet.retweetCount)
            
            //APIManager Request from Cell
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error Retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the Tweet")
                }
            }
        } else if (RTButton.isSelected == true) {
            RTButton.isSelected = false
            tweet.retweeted = false
            tweet.retweetCount -= 1
            self.RTLabel.text = String(tweet.retweetCount)
            
            //APIManager Request from Cell
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error UnRetweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Unretweet succesful")
                }
            }
        }
    }
    
    @IBAction func didTapFav(_ sender: Any) {
        
        if (FavButton.isSelected != true) {
            
            FavButton.isSelected = true
            tweet.favorited = true
            tweet.favoriteCount += 1
            self.FavLabel.text = String(tweet.favoriteCount)
            
            //APIManager Request from Cell
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the tweet")
                }
            }
        } else if (FavButton.isSelected == true) {
            FavButton.isSelected = false
            tweet.favorited = false
            tweet.favoriteCount -= 1
            self.FavLabel.text = String(tweet.favoriteCount)
            
            //APIManager Request from Cell
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the tweet")
                }
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
