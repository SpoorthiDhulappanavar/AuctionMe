//
//  ChatViewController.swift
//  AuctionMe
//
//  Created by Ian Polidora on 4/20/21.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageTableView: UITableView!
    
    var conversations = [PFObject]()
    var receiver = PFUser()
    let currentUser = PFUser.current()!
    var conversationNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        messageTableView.delegate = self
        messageTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let user1Query = PFQuery(className: "Conversations")
        user1Query.whereKey("user1", contains: currentUser.username)
        let user2Query = PFQuery(className: "Conversations")
        user2Query.whereKey("user2", contains: currentUser.username)
        let query = PFQuery.orQuery(withSubqueries: [user1Query, user2Query])
        query.findObjectsInBackground { (results: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                self.conversations = results!
                self.messageTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messageTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let conversation = conversations[indexPath.row]
        
        if (conversation["user1"] as! String == currentUser.username!){
            cell.textLabel?.text = conversation["user2"] as? String
            conversationNames.append(conversation["user2"] as! String)
        } else {
            cell.textLabel?.text = conversation["user1"] as? String
            conversationNames.append(conversation["user1"] as! String)
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        messageTableView.deselectRow(at: indexPath, animated: true)
        
        //Show chat messages.
        let vc = PrivateChatViewController()
        vc.title = conversationNames[indexPath.row]
        vc.otherUser = findUser(withUsername: vc.title!)
        navigationController?.pushViewController(vc, animated:true)
    }
    
    func findUser(withUsername username:String) -> PFUser {
        var user = PFUser()
        
        let query = PFQuery(className: "User")
        query.whereKey("username", equalTo: username)
        query.findObjectsInBackground { (results, error) in
            if results == nil {
                for result in results! {
                    user = result as! PFUser
                }
            }
        }
        
        return user
    }
        
}
