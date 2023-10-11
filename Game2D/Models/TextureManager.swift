//
//  TextureManager.swift
//  Game2D
//
//  Created by Andrei Bogoslovskii on 11.10.2023.
//

import UIKit

class TextureManager {
    
    func setShip(shipName: String) {
        UserDefaults.standard.set(shipName, forKey: "SavedShip")
    }
    
    func setStone(stoneName: String) {
        UserDefaults.standard.set(stoneName, forKey: "SavedStone")
    }
    
    func loadShip() -> String? {
        UserDefaults.standard.string(forKey: "SavedShip")
    }
    
    func loadStone() -> String? {
        UserDefaults.standard.string(forKey: "SavedStone")
    }
    
}
