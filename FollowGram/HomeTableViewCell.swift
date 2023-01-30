//
//  HomeTableViewCell.swift
//  FollowGram
//
//  Created by shoeb on 30/01/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameCell: UILabel!
    @IBOutlet weak var subtitleCell: UILabel!
    @IBOutlet weak var postImageCell: UIImageView!
    @IBOutlet weak var likeTapCell: UILabel!
    @IBOutlet weak var likeNumCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
