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
            
            guard let ciImage = CIImage(image: imageOriginal) else {
                fatalError("Cannot convert to CI Image")
            }
            
            imageDetect(image: ciImage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imageDetect(image: CIImage){
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Error modeling CoreML")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let result = request.results as? [VNClassificationObservation] else {
                fatalError("Cannot process the image")
            }
            
            print(result)
            
            if let firstResult = result.first{
                if firstResult.identifier.contains("hotdog"){
                    self.navigationController?.title = "Hotdog!!"
                } else {
                    self.navigationController?.title = "Not hotdog!!"
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do{
            try handler.perform([request])
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func cameraButtonClicked(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}

