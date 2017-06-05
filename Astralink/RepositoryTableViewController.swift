//
//  RepositoryTableViewController.swift
//  Astralink
//
//  Created by Asaf Inbar on 29/05/2017.
//  Copyright © 2017 Asaf Inbar. All rights reserved.
//

import UIKit

class RepositoryTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var repoArrayDataSource:Array<RepositoryModel> = Array()
    var pageIndex = 0
    var isNewDataLoading = false
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        tableView.estimatedRowHeight = 70

        isNewDataLoading = true
        NetworkManager.sharedInstance.getRepositoryList(listType: segmentedControl.selectedSegmentIndex, pageCount: pageIndex, completionHandler: handleResponse)
        
    }
    
    func handleResponse(repoArray:Array<RepositoryModel>, error:Error? ) {
        isNewDataLoading = false
        repoArrayDataSource += repoArray
        tableView.reloadData()
    }
    
    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        repoArrayDataSource.removeAll()
        tableView.reloadData()
        pageIndex = 0
        NetworkManager.sharedInstance.getRepositoryList(listType: segmentedControl.selectedSegmentIndex, pageCount: pageIndex, completionHandler: handleResponse)
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
        return repoArrayDataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as! RepoTableViewCell

        let item:RepositoryModel = repoArrayDataSource[indexPath.row]
        cell.initCell(with: item)
        

        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) + 100 >= scrollView.contentSize.height)
        {
            if !isNewDataLoading{

                isNewDataLoading = true
                pageIndex += 1
                NetworkManager.sharedInstance.getRepositoryList(listType: segmentedControl.selectedSegmentIndex, pageCount: pageIndex, completionHandler: handleResponse)

            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
            let item:RepositoryModel = repoArrayDataSource[tableView.indexPathForSelectedRow!.row]
            let dest:RepositoryDetailsViewController = segue.destination as! RepositoryDetailsViewController
            dest.item = item
        }
    }

}
