//
//  TableViewController.swift
//  Game2D
//
//  Created by Andrei Bogoslovskii on 10.10.2023.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var playersTableView: UITableView!
    let manager = StorageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        playersTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        playersTableView.reloadData()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
}


extension TableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Score - \(manager.scores[indexPath.row])"
        return cell
    }
    
}
