//
//  ViewController.swift
//  SeafoodML
//
//  Created by Midas on 10/02/20.
//  Copyright © 2020 Midas. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = imageOriginal
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cameraButtonClicked(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}

