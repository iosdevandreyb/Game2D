//
//  ProfileViewController.swift
//  Game2D
//
//  Created by Andrei Bogoslovskii on 08.10.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    let manager = StorageManager()
    var imageName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        
        
        if let savedName = UserDefaults.standard.string(forKey: "SavedName") {
            profileNameLabel.text = savedName
        }
        
        if let savedImage = UserDefaults.standard.string(forKey: "SavedImage") {
            profileImageView.image = manager.loadImage(name: savedImage)
        }
        
    }
    
    
    
    @IBAction func uploadButtonPressed(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(
            title: "Choose photo",
            message: "",
            preferredStyle: .actionSheet
        )
        
        actionSheet.addAction(
            UIAlertAction(
                title: "Camera",
                style: .default,
                handler: { (action:UIAlertAction) in
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        imagePickerController.sourceType = .camera
                        self.present(
                            imagePickerController,
                            animated: true,
                            completion: nil
                        )
                    } else {
                        print("Camera is not available")
                    }
                }
            )
        )
        
        actionSheet.addAction(
            UIAlertAction(
                title: "Library",
                style: .default,
                handler: { (action:UIAlertAction) in
                    imagePickerController.sourceType = .photoLibrary
                    self.present(
                        imagePickerController,
                        animated: true,
                        completion: nil)
                }
            )
        )
        
        
        actionSheet.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil)
        )
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    @IBAction func nameButtonPressed(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Write your name", message: nil, preferredStyle: .alert)
        alertController.addTextField() { textField in
            textField.placeholder = "Name"
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let okAction = UIAlertAction(title: "Done", style: .default) { _ in
                if let text = alertController.textFields?.first?.text {
                    self.profileNameLabel.text = text
                    self.manager.saveName(text: text)
                }
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
}







extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageName = manager.saveImage(image: image) ?? "error saving image"
        profileImageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
