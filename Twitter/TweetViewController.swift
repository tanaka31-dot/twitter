//
//  TweetViewController.swift
//  Twitter
//
//  Created by Tanaka Muchemwa on 7/26/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.becomeFirstResponder()
        tweetTextView.layer.borderWidth = 3.0
        tweetTextView.layer.borderColor = UIColor.black.cgColor
        tweetTextView.layer.cornerRadius = 10.0
        tweetTextView.clipsToBounds = true
        tweetButton.isEnabled = false

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textViewDidBeginEditing(tweetTextView)
    }
    
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tweet(_ sender: Any) {
        
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { Error in
                print("Error posting tweet \(Error)")
                self.dismiss(animated: true, completion: nil)
                
            })
        } else {
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tweetButton.isEnabled = true
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
