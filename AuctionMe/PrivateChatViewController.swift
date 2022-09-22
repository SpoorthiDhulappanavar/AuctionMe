//
//  PrivateChatViewController.swift
//  AuctionMe
//
//  Created by Ian Polidora on 4/21/21.
//

import UIKit
import MessageKit
import Parse
import InputBarAccessoryView

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

class PrivateChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, InputBarAccessoryViewDelegate {
    
    var messageID = 1
    var currentUser = PFUser.current()!
    var messageObjects = [PFObject]()
    var messages = [MessageType]()
    public var otherUser = PFUser()
    var updateTimer = Timer()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        updateTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageInputBar.inputTextView.becomeFirstResponder()
    }
    
    @objc func update() {
        let toCurrentUserQuery = PFQuery(className: "Messages")
        toCurrentUserQuery.whereKey("to", equalTo: currentUser.username!)
        toCurrentUserQuery.whereKey("from", equalTo: otherUser.username)
        
        let toOtherUserQuery = PFQuery(className: "Messages")
        toOtherUserQuery.whereKey("to", equalTo: otherUser.username)
        toOtherUserQuery.whereKey("from", equalTo: currentUser.username!)
        
        let query = PFQuery.orQuery(withSubqueries: [toCurrentUserQuery, toOtherUserQuery])
        
        query.findObjectsInBackground { (results, error) in
            if results != nil {
                self.messageObjects = results!
                self.messagesCollectionView.reloadData()
            }
        }
        
        for object in messageObjects{
            let sender = Sender(senderId: object["senderID"] as! String, displayName: object["from"] as! String)
            
            messages.append(Message(sender: sender,
                                    messageId: object["messageID"] as! String,
                                    sentDate: object["sendTime"] as! Date,
                                    kind: .text(object["content"] as! String)))
        }
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
        
        let message = PFObject(className: "Messages")
        
        message["to"] = otherUser.username
        message["from"] = currentUser.username
        message["senderID"] = currentUser.objectId
        message["messageID"] = self.messageID
        message["content"] = text
        message["sendTime"] = Date()
        
        message.saveInBackground { (success, error) in
            if success{
                print("Saved!!")
                self.messageID += 1
            }
            else {
                print("Error!!")
            }
        }
    }

    func currentSender() -> SenderType {
        return Sender(senderId: currentUser.objectId!, displayName: currentUser.username!)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
}
