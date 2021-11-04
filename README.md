# week-05_HW_PhotosLibrary_Cam_Caching

## In this repository , you have application that will let you choose your favourite photos from the library , or capture the photo using the camera ! The image is then handled using cache and persisted to the disk . 

### Modify the application to achieve the desired result. 

### The application has the following views :
- Label : Your Favorite  Image
- Image View to display your chosen / taken image
- Button to choose photo from library
- Button to Open Camera

### In the View Controller
- Connect the @IBOutlet for the image view 
- Connect the @IBAction for  OpenPhotosLibrary . *hint inside the function call  presentPhotoPicker() to open the photo picker
- Connect the @IBAction for  OpenCam . *hint inside the function call  presentImagePicker() to open the camera
- Inside viewDidLoad , Set the myImageView.image to imageToDisplay
- Modify imagePickerController(_ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])  To display the image
- Modify func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil) To display the image
        
- Rmemeber to add the following keys (for asking permission to use the camera and photo picker) to your project target info :
- - Privacy - Photo Library Usage Description 
- - Privacy - Camera Usage Description

## After you choose or take a photo, it should be persisted to the disk using the class ImgStore . So that when you close and open the application , the image is fetched again from the disk .

### Resources for you 
- The whole project is prepared for you. You need to modify it to include all the views, IBOutlest and IBAction . And to modify areas of the code to achieve the end result. 


#### The final application should look similar to this :
![alt text](https://github.com/T1000-Swift-Hail/week-05_HW_PhotosLibrary_Cam_Caching/blob/main/Screen%20Shot%202021-11-04%20at%2012.56.05%20PM.png?raw=true)


