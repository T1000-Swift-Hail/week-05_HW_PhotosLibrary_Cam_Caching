//
//  ViewController.swift
//  PhotosLibrary_Cam_Caching
//
//  Created by Dalal AlSaidi on 29/03/1443 AH.
//
//

import UIKit
import PhotosUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {

    @IBOutlet weak var myImageView: UIImageView!
    
    let imagStore = ImageStore()
    let myFavImage = "myImageKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myImageView.layer.cornerRadius = 12
        myImageView.clipsToBounds = true
        myImageView.contentMode = .scaleToFill
        myImageView.layer.borderColor = UIColor.gray.cgColor
        myImageView.layer.borderWidth = 2
        let imageToDisplay = imagStore.image(forKey: myFavImage)
        
        //Set the myImageView.image to imageToDisplay
        self.myImageView.image = imageToDisplay
        
        
        
    }

    @IBAction func OpenPhotosLibrary(_ sender: Any) {
        // your code here
     presentPhotoPicker()
    }
    
    @IBAction func OpenCam(_ sender: Any) {
        //your code here
       presentImagePicker()
    }
    
    
    func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    func presentPhotoPicker() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images

        let photoPicker = PHPickerViewController(configuration: configuration)
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        // Take image picker off the screen - you must call this dismiss method
        dismiss(animated: true, completion: nil)

        // Get picked image from info dictionary
        let image = info[.originalImage] as! UIImage

        // Put that image in the imageView
        self.myImageView.image = image

        // Store the image in the ImageStore for the item's key
        imagStore.setImage(image, forKey: myFavImage)

    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)

        if let result = results.first, result.itemProvider.canLoadObject(ofClass: UIImage.self) {
            result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                if let image = image as? UIImage {
                    // Store the image in the ImageStore for the item's key
                    DispatchQueue.main.async {
                        self.imagStore.setImage(image, forKey: self.myFavImage)
                        self.myImageView.image = image
                        
                    }
                }
            }
        }
    }
    
    
    
    
}


