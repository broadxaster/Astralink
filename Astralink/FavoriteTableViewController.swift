//
//  FavoriteTableViewController.swift
//  Astralink
//
//  Created by Asaf Inbar on 05/06/2017.
//  Copyright © 2017 Asaf Inbar. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        tableView.estimatedRowHeight = 70
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaultsUtils.sharedInstance.favArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as! RepoTableViewCell
        
        let item:RepositoryModel = UserDefaultsUtils.sharedInstance.favArray[indexPath.row]
        cell.initCell(with: item)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let item:RepositoryModel = UserDefaultsUtils.sharedInstance.favArray[tableView.indexPathForSelectedRow!.row]
            let dest:RepositoryDetailsViewController = segue.destination as! RepositoryDetailsViewController
            dest.item = item
        }
    }

}
