//
//  LikedPostsViewController.swift
//  AuctionMe
//
//  Created by Ian Polidora on 4/25/21.
//

import UIKit
import Parse
import AlamofireImage

class LikedPostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var likedPostsTableView: UITableView!
    
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        likedPostsTableView.dataSource = self
        likedPostsTableView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.whereKey("liked", equalTo: true)
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.likedPostsTableView.reloadData()
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
