//
//  ViewController.swift
//  Project7
//
//  Created by Omar Makran on 4/1/24.
//  Copyright © 2024 Omar Makran. All rights reserved.
//

import UIKit

// UISearchBarDelegate: protocol to handle the changes, typing or clears...
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
        // self: the view controller.
        // will be notified of any changes made to the search bar, such as when the user starts typing or clears the text.
        searchBar.delegate = self
        // by doing this, the search bar will appear at the top of the view controller's navigation bar.
        navigationItem.titleView = searchBar

        // URL string.
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        // Create a URL object
        if let url = URL(string: urlString) {
            // Create a URLSession, make network requests.
            let session = URLSession(configuration: .default)
            
            // Create a data task, is responsible for fetching the data from the provided URL
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    self?.showError()
                    print("Error fetching data: \(error)")
                    return
                }
                
                // Check if data is available
                if let data = data {
                    self?.parse(json: data)
                } else {
                    self?.showError()
                }
            }
            
            // Start the data task
            task.resume()
        } else {
            showError()
        }
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
            // Update UI on the main thread
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    // Search bar delegate methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // when the search bar is empty, the table view will display all the petitions.
        if searchText.isEmpty {
            filteredPetitions = petitions
        } else {
            // this line filters the petitions array based on whether each petition's title contains the search text (case-insensitive).
            filteredPetitions = petitions.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        // to reflect the changes made to the filteredPetitions array.
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
    
    // tableView(_:didSelectRowAt:) method, which is part of the UITableViewDelegate protocol. It gets called when a user taps on a table view cell.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // displays detailed information about a selected petition.
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        // pushing the Detail View Controller onto the Navigation Stack
        // this means that the DetailViewController will be displayed, and the user can navigate back to the previous view controller using the navigation bar's back button.
        navigationController?.pushViewController(vc, animated: true)
    }
}
