//
//  NewChatViewController.swift
//  AuctionMe
//
//  Created by Ian Polidora on 4/21/21.
//

import UIKit
import Parse

class NewChatViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    let currentUser = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startChattingButton(_ sender: Any) {
        let conversation = PFObject(className: "Conversations")
        
        conversation["user1"] = currentUser.username!
        conversation["user2"] = usernameTextField.text!
        
        
        conversation.saveInBackground { (success, error) in
            if success{
                print("Saved!")
            }
            else {
                print("Error")
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
