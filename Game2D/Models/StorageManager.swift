//
//  StorageManager.swift
//  Game2D
//
//  Created by Andrei Bogoslovskii on 10.10.2023.
//

import UIKit

class StorageManager {
    
    var scores = UserDefaults.standard.array(forKey: "scores") as? [Int] ?? [Int]()
    
    func saveImage(image: UIImage) -> String? {
        guard let documentsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return nil }
        
        let fileName = UUID().uuidString
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        guard let data = image.jpegData(
            compressionQuality: 1.0
        ) else { return nil}
        
        do {
            try data.write(to: fileURL)
            UserDefaults.standard.set(fileName, forKey: "SavedImage")
            return fileName
            
        } catch {
            return nil
        }
    }
    
    func saveName(text: String) {
        UserDefaults.standard.set(text, forKey: "SavedName")
    }
    
    func loadImage(name: String) -> UIImage? {
        guard let documntsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return nil }
        
        let fileURL = documntsDirectory.appendingPathComponent(name)
        let image = UIImage(contentsOfFile: fileURL.path)
        return image
    }
    
    func updateTable(score: Int) {
        scores.append(score)
        UserDefaults.standard.set(scores, forKey: "scores")
    }
    
    func setDifficulty(difficulty: CGFloat) {
        UserDefaults.standard.set(difficulty, forKey: "difficultyPoint")
    }
    
    func checkDifficulty()  -> CGFloat? {
        guard let difficulty = UserDefaults.standard.object(forKey: "difficultyPoint") as? CGFloat else { return 2 }
        return difficulty
    }
    
}
