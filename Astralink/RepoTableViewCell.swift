//
//  RepoTableViewCell.swift
//  Astralink
//
//  Created by Asaf Inbar on 04/06/2017.
//  Copyright © 2017 Asaf Inbar. All rights reserved.
//

import UIKit
import SDWebImage


class RepoTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var starsCount: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    
    func initCell(with item:RepositoryModel){
        name.text = item.ownerName
        repoDescription.text = item.repoDescription
        starsCount.text = "number of stars: " + (item.stars?.stringValue)!
        avatar.sd_setImage(with: URL(string: item.ownerAvatar!), placeholderImage: UIImage(named: "avatar_placeholder.png"))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
