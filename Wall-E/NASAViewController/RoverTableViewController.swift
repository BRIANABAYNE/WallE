//
//  RoverTableViewController.swift
//  Wall-E
//
//  Created by Briana Bayne on 6/30/23.
//

import UIKit

class RoverTableViewController: UITableViewController   {
    
    // MARK: - Outlets
    @IBOutlet weak var earthDateSearchBar: UISearchBar!
    
    // MARK: - Properties
    var placeHolderRovers: [Rover]? = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        earthDateSearchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeHolderRovers?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "roverCell", for: indexPath) as?  RoverTableViewCell else { return UITableViewCell() }
        guard let rover = placeHolderRovers?[indexPath.row] else { return UITableViewCell() }
        cell.rover = rover
        cell.updateView()
        return cell
    }
}
// MARK: - Extension
extension RoverTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        NetworkController().fetchRover(with: searchText) { roverArray in
            self.placeHolderRovers = roverArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
