//
//  RepositoryDetailsViewController.swift
//  Astralink
//
//  Created by Asaf Inbar on 04/06/2017.
//  Copyright © 2017 Asaf Inbar. All rights reserved.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var repoDescription: UITextView!
    @IBOutlet weak var starsCount: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var forksCount: UILabel!
    @IBOutlet weak var creationDate: UILabel!

    @IBOutlet weak var gitHubPageButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    var item:RepositoryModel = RepositoryModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = item.ownerName
        repoDescription.text = item.repoDescription
        starsCount.text = "number of stars: " + (item.stars?.stringValue)!
        avatar.sd_setImage(with: URL(string: item.ownerAvatar!), placeholderImage: UIImage(named: "avatar_placeholder.png"))

        language.text = "Language: " + item.language!
        forksCount.text = "Number of forks: " + (item.forks?.stringValue)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        creationDate.text = "Creation date: " + dateFormatter.string(from: item.created_at!)
        updateFavoriteButtonUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToGitHubPage(_ sender: Any) {
        let url = NSURL(string: item.htmlUrl!)!
        UIApplication.shared.open(url as URL, options: [:]) { (Bool) in
            
        }
        
    }
    @IBAction func favButtonTapped(_ sender: UIButton) {
        item.isFavorite = !item.isFavorite
        updateFavoriteButtonUI()
        UserDefaultsUtils.sharedInstance.setFavorite(item: item)
    }
    
    func updateFavoriteButtonUI() {
        if item.isFavorite {
            let image = UIImage(named: "heart_icon_selected.png")
            favButton.setImage(image, for: .normal)
        } else {
            let image = UIImage(named: "Heart_icon.png")
            favButton.setImage(image, for: .normal)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
