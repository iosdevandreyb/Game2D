//
//  MenuViewController.swift
//  Game2D
//
//  Created by Andrei Bogoslovskii on 08.10.2023.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    
    @IBAction func playButtonPressed(_ sender: UIButton) {

    }
    
    
    
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
