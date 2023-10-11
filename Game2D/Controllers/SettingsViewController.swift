//
//  SettingsViewController.swift
//  Game2D
//
//  Created by Andrei Bogoslovskii on 10.10.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let texture = TextureManager()
    let manager = StorageManager()
    
    @IBOutlet weak var asteroidSegmentView: UISegmentedControl!
    @IBOutlet weak var spaceshipSegmentView: UISegmentedControl!
    @IBOutlet weak var difficultySegmentView: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        asteroidSegmentView.selectedSegmentIndex = UserDefaults
            .standard
            .integer(forKey: "asteroidIndex")
        spaceshipSegmentView.selectedSegmentIndex = UserDefaults
            .standard
            .integer(forKey: "spaceshipIndex")
        difficultySegmentView.selectedSegmentIndex = UserDefaults
            .standard
            .integer(forKey: "difficultyIndex")
    }
    
    @IBAction func difficultySegmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            manager.setDifficulty(difficulty: 3)
            
        case 1:
            manager.setDifficulty(difficulty: 6)
        default:
            break
        }
        UserDefaults.standard.set(sender.selectedSegmentIndex,forKey: "difficultyIndex")
    }
    
    
    @IBAction func asteroidSegmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            texture.setStone(stoneName: "asteroid1")
        case 1:
            texture.setStone(stoneName: "asteroid2")
        default:
            break
        }
        UserDefaults.standard.set(sender.selectedSegmentIndex,forKey: "asteroidIndex")
    }
    
    
    
    @IBAction func spaceshipSegmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            texture.setShip(shipName: "spaceship1")
            
        case 1:
            texture.setShip(shipName: "spaceship2")
        default:
            break
        }
        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: "spaceshipIndex")
    }
    
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
