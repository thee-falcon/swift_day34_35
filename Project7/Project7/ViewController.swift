//
//  ViewController.swift
//  Project7
//
//  Created by Omar Makran on 4/1/24.
//  Copyright © 2024 Omar Makran. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {
    
    // Array of struct.
    var petitions = [Petition]()
    
    // Filtered petitions
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Credits button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        
        // Add Search bar
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search petitions"
        searchBar.delegate = self
        navigationItem.titleView = searchBar

        // URL string.
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        // Convert that string to URL safely using if let.
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url ) {
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "The data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading Error!", message: "There was a problem loading the feed; Please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()
        // Asks that decoder to convert its data to a single petitions object.
        if let jsonPetitons = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitons.results
            filteredPetitions = petitions
            tableView.reloadData()
        }
    }
    
    // Search bar delegate methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredPetitions = petitions
        } else {
            filteredPetitions = petitions.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
