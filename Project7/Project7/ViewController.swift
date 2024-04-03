//
//  ViewController.swift
//  Project7
//
//  Created by Omar Makran on 4/1/24.
//  Copyright © 2024 Omar Makran. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // array of struct.
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // URL string.
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        // convert that string to URL safely using if let.
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url ) {
                parse(json: data)
                return
            }
        }
        showError()
    }

    func    showError() {
        let ac = UIAlertController(title: "Loading Error!", message: "There was a problem loading the feed; Please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    func    parse(json: Data) {
        let decoder = JSONDecoder()
        // asks that decoder to convert its data to a single petitions object.
        if let jsonPetitons = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitons.results
            tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem  = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

