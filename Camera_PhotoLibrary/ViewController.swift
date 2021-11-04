//
//  ViewController.swift
//  Camera_PhotoLibrary
//
//  Created by Akeel Al-Ead on 04/11/2021.
//

import UIKit
import PhotosUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var myImageView: UIImageView!
     //let caching = CachingManager()
    
    let imgStore = ImgStore()
    let myFavImage = "myImageKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let imageToDisplay = imgStore.image(forKey: myFavImage)
        myImageView.image = imageToDisplay
        //Set the myImageView.image to imageToDisplay
    }

    @IBAction func OpenPhotosLibrary(_ sender: Any) {
        presentPhotoPicker()
        // your code here
       
    }
    
    @IBAction func OpenCam(_ sender: Any) {
        presentImagePicker()
        //your code here
       
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
    
    
    func imagePickerController(_ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    
        // Take image picker off the screen - you must call this dismiss method
       // dismiss(animated: true, completion: nil)

        // Get picked image from info dictionary
       let image = info[.originalImage] as! UIImage
        self.imgStore.setImage(image, forKey: "url")
        self.myImageView.image = image
        imgStore.setImage(image, forKey: myFavImage)


    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)

        if let result = results.first, result.itemProvider.canLoadObject(ofClass: UIImage.self) {
            result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                if let image = image as? UIImage {
                    // Store the image in the ImageStore for the item's key
                    self.imgStore.setImage(image, forKey: self.myFavImage)

                    
                    DispatchQueue.main.async {
                        // Put the image in the imageview
                       
                            self.myImageView.image = image
                    }
                }
            }
        }
    }
    
    
    
    
}





