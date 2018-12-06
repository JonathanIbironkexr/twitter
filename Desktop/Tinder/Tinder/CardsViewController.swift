//
//  CardsViewController.swift
//  Tinder
//
//  Created by Trustin Harris on 4/29/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var FirstIV: UIImageView!
    var cardInitialCenter: CGPoint!
    var newPic: UIImageView!
    var newPicOriginalCenter: CGPoint!
    @IBOutlet weak var pictureView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func DraggingPicture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: pictureView)
        
        if sender.state == .began {
            cardInitialCenter = FirstIV.center
            let IV = sender.view as! UIImageView
            newPic = UIImageView(image: IV.image)
            pictureView.addSubview(newPic)
            FirstIV.alpha = 1
            newPic.alpha = 0
            newPic.isUserInteractionEnabled = true
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(newViews(sender:)))
            newPic.addGestureRecognizer(panGestureRecognizer)
        }
        
        if sender.state == .changed {
            //*********** Swiping Right
            FirstIV.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
            if translation.x > 0 {
                FirstIV.transform = CGAffineTransform(rotationAngle:CGFloat(7 * M_PI/180))
                if translation.x > 65 {
                    UIView.animate(withDuration: 2) {
                        self.FirstIV.removeFromSuperview()
                        self.newPic.alpha = 1
                    }
                }
            }
            if translation.x < 0 {
                //******** Swiping Left
                FirstIV.transform = CGAffineTransform(rotationAngle:CGFloat(-7 * M_PI/180))
                if translation.x < -65 {
                    UIView.animate(withDuration: 2) {
                        self.FirstIV.removeFromSuperview()
                        self.newPic.alpha = 1
                    }
                }
            }
        }
        if sender.state == .ended {
            if FirstIV == FirstIV {
                FirstIV.center = cardInitialCenter
                FirstIV.transform = CGAffineTransform.identity
            } else {
                newPic.center = cardInitialCenter
                newPic.transform = CGAffineTransform.identity
            }
        }
    }
    
    @objc func newViews(sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: pictureView)
        
        if sender.state == .began {
            newPic = sender.view as! UIImageView
            cardInitialCenter = newPic.center
        }
        if sender.state == .changed {
            if translation.x > 0 {
                newPic.transform = CGAffineTransform(rotationAngle:CGFloat(7 * M_PI/180))
                newPic.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                if translation.x > 65 {
                    UIView.animate(withDuration: 2) {
                        self.newPic.removeFromSuperview()
                    }
                }
                if translation.x < 0 {
                    newPic.transform = CGAffineTransform(rotationAngle:CGFloat(-7 * M_PI/180))
                    newPic.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                    if translation.x < -65 {
                        UIView.animate(withDuration: 2) {
                            self.newPic.removeFromSuperview()
                        }}}}}}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let ProfileViewController = segue.destination as! ProfileViewController
        
    }
    
    
}
