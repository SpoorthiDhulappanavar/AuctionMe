//
//  FeedViewCell.swift
//  AuctionMe
//
//  Created by Ian Polidora on 4/10/21.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var interestsLabel: UILabel!
    @IBOutlet weak var prosConsLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    
    public var post = PFObject.init(className: "Posts")
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var disliked:Bool = false
    
    func setDisliked(_ isDisliked:Bool){
        disliked = isDisliked
        if(disliked){
            dislikeButton.setImage(UIImage(named:"dislike_red"), for: UIControl.State.normal)
        }else{
            dislikeButton.setImage(UIImage(named:"dislike"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func dislike(_ sender: Any) {
        let toBeDisliked = !disliked
        if(toBeDisliked){
            self.setDisliked(true)
            self.setLiked(false)
            post["liked"] = false
        }else{
            setDisliked(false)
        }
    }
    
    var liked:Bool = false
    
    func setLiked(_ isLiked:Bool){
        liked = isLiked
        if(liked){
            likeButton.setImage(UIImage(named:"like_green"), for: UIControl.State.normal)
        }else{
            likeButton.setImage(UIImage(named:"like"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func like(_ sender: Any) {
        let toBeLiked = !liked
        if(toBeLiked){
            self.setLiked(true)
            self.setDisliked(false)
            post["liked"] = true
        }else{
            setLiked(false)
        }
    }
}
