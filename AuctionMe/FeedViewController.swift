//
//  FeedViewController.swift
//  AuctionMe
//
//  Created by Alex Mierzejewski on 3/30/21.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var feedTableView: UITableView!
    
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedTableView.dataSource = self
        feedTableView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.feedTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedViewCell", for: indexPath) as! FeedViewCell
        
        let post = posts[indexPath.row]
        cell.nameLabel.text = post["name"] as! String
        cell.ageLabel.text = post["age"] as! String
        cell.locationLabel.text = post["location"] as! String
        cell.interestsLabel.text = "Interests: \(post["interests"] as! String)"
        cell.prosConsLabel.text = "Pros/Cons: \(post["prosCons"] as! String)"
        cell.post = post
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.setLiked(post["liked"] as! Bool)
        cell.setDisliked(!(post["liked"] as! Bool))
        
        cell.photoView.af.setImage(withURL: url)
        
        return cell
    }

}
