//
//  TweetViewController.swift
//  Twitter
//
//  Created by Tanaka Muchemwa on 7/26/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

class TweetViewController: UIViewController,UITextViewDelegate{
    
    
    @IBOutlet weak var userProfile: UIImageView!
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    
    
    @IBOutlet weak var textCountDown: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProfile.layer.cornerRadius = userProfile.frame.size.width / 2
        
        userProfile.clipsToBounds = true
        
        self.tweetTextView.delegate = self
        
        tweetTextView.becomeFirstResponder()
        tweetTextView.layer.borderWidth = 3.0
        tweetTextView.layer.borderColor = UIColor.black.cgColor
        tweetTextView.layer.cornerRadius = 10.0
        tweetTextView.clipsToBounds = true
        
        
        tweetButton.isEnabled = false
        
        let button = UIButton()
        button.layer.cornerRadius = 20.0
        button.clipsToBounds = true
        button.layer.shadowRadius = 15.0
        button.layer.shadowOpacity = 0.2
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        
        
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Set the max character limit
        let characterLimit = 280

        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)
        
        if (newText.count == 0) {
            tweetButton.isEnabled = false
        } else {
            tweetButton.isEnabled = true
        }

        // TODO: Update Character Count Label
        textCountDown.text = String(characterLimit - newText.count)
        
        // The new text should be allowed? True/False
        
        
        return newText.count < characterLimit
        
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
