//
//  TableViewController.swift
//  Game2D
//
//  Created by Andrei Bogoslovskii on 10.10.2023.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var playersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

}
