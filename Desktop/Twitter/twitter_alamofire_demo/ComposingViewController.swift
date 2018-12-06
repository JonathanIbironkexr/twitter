//
//  ComposingViewController.swift
//  twitter_alamofire_demo
//
//  Created by Trustin Harris on 4/24/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}


class ComposingViewController: UIViewController {
    weak var delegate: ComposeViewControllerDelegate?
    
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var TweetButton: UIButton!
    @IBOutlet weak var Tweet: UITextView!
    @IBOutlet weak var ProfilePic: UIImageView!
    let user = User.current!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfilePic.layer.masksToBounds = true;
        ProfilePic.af_setImage(withURL: URL(string: user.imageURL)!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShows), name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHides), name: NSNotification.Name.UIKeyboardWillHide, object: nil);
        
    }
    
    @objc func handleKeyboardHides(notification: NSNotification) {
        
        if Tweet.text == "" {
            Tweet.text = "What's happening?"
        }
        
    }
    
    @objc func handleKeyboardShows(notification: NSNotification) {
        
        if (Tweet.text == "") || (Tweet.text == "What's happening?") {
            Tweet.text = ""
        }
        
    }
    @IBAction func CancelButton(_ sender: Any) {
        Tweet.text = "What's happening?";
        
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func TweetButton(_ sender: Any) {
        
        APIManager.shared.composeTweet(with: Tweet.text) { (tweet, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Tweet Successful!")
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
