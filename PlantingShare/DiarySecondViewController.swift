//
//  DiarySecondViewController.swift
//  PlantingShare
//
//  Created by cscoi024 on 2019. 8. 23..
//  Copyright © 2019년 lim. All rights reserved.
//

import UIKit
import Photos
import LocalAuthentication

class DiarySecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet var imageView: UIImageView!
//    @IBOutlet var myCollectionView: UICollectionView!
    
//    @IBOutlet var nextButton: UIBarButtonItem!
    var imageArray=[UIImage]()
    
    var posts: [Post] = []
    
    
    lazy var picker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        return picker
    }()
    
//    let picker = UIImagePickerController()
    
    @IBAction func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
//    @IBAction func toggleTouchIDButton(_ sender: UIButton) {
//        // LAContext Instance creation
//        let authContext = LAContext()
//
//        // Error store variable
//        var error: NSError?
//
//        // Check if the device has finger print sensor
//        guard authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
//            return
//        }
//
//        authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "홈 버튼에 손가락을 올려주세요.", reply: { success, error in
//            if success {
//                // Fingerprint recognized
//                print("성공")
//                let alert =  UIAlertController(title: "사진 선택", message: "", preferredStyle: .actionSheet)
//                let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
//
//                }
//
//
//                let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
//                    self.openCamera()
//                }
//
//
//                let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//
//                alert.addAction(library)
//                alert.addAction(camera)
//                alert.addAction(cancel)
//                self.present(alert, animated: true, completion: nil)
//            } else {
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//            }
//        })
//        
//    }
    @IBAction func addAction(_ sender: UIButton) {
        
        
        let alert =  UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
            
        }
        
        
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            
            self.openCamera()
            
        }
        
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        
        alert.addAction(library)
        
        alert.addAction(camera)
        
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
//    @IBAction func touchUpSelectImageButton(_ sender: UITapGestureRecognizer) {
//        print("tapped")
//        self.present(self.imagePicker, animated: true, completion: nil)
//    }
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, sholudReceive touch: UITouch) -> Bool {
//        return true
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
    
    
//    func determineButtonState() {
//        if let id: String = idField.text, id.count > 0,
//            let password: String = passwordField.text, password.count > 0,
//            let confirmPassword: String = confirmPasswordField.text, confirmPassword == password,
//            let introduce: String = introduceField.text, introduce.count > 0,
//            UserInformation.shared.profileImage != nil {
//            nextButton.isEnabled = true }   else {
//            nextButton.isEnabled = false
//        }
//    }
    func openLibrary() {
        
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
        
    }
    
    func openCamera(){
        
        picker.sourceType = .camera
        present(picker, animated: false, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageView.image = editedImage
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
//        let layout = UICollectionViewFlowLayout()
        
//        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//        myCollectionView.delegate=self
//        myCollectionView.dataSource=self
        
        
//        myCollectionView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
        
//        grabPhotos()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: CollectionView
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imageArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoItemCell
//        cell.img.image=imageArray[indexPath.item]
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath)
//
//        self.imageView.image = imageArray[indexPath.item]
//
//        let vc=ImagePreviewVC()
//        vc.imgArray = self.imageArray
//        vc.passedContentOffset = indexPath
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width
        //        if UIDevice.current.orientation.isPortrait {
        //            return CGSize(width: width/4 - 1, height: width/4 - 1)
        //        } else {
        //            return CGSize(width: width/6 - 1, height: width/6 - 1)
        //        }
//        if DeviceInfo.Orientation.isPortrait {
//            return CGSize(width: width/4 - 1, height: width/4 - 1)
//        } else {
//            return CGSize(width: width/6 - 1, height: width/6 - 1)
//        }
//    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        myCollectionView.collectionViewLayout.invalidateLayout()
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
    
//    func grabPhotos(){
//        imageArray = []
//
//        DispatchQueue.global(qos: .background).async {
//            print("This is run on the background queue")
//            let imgManager=PHImageManager.default()
//
//            let requestOptions=PHImageRequestOptions()
//            requestOptions.isSynchronous=true
//            requestOptions.deliveryMode = .highQualityFormat
//
//            let fetchOptions=PHFetchOptions()
//            fetchOptions.sortDescriptors=[NSSortDescriptor(key:"creationDate", ascending: false)]
//
//            let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
//            print(fetchResult)
//            print(fetchResult.count)
//            if fetchResult.count > 0 {
//                for i in 0...11{
//                    imgManager.requestImage(for: fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width:500, height: 500),contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, error) in
//                        self.imageArray.append(image!)
//                    })
//                }
//            } else {
//                print("You got no photos.")
//            }
//            print("imageArray count: \(self.imageArray.count)")
//            self.imageView.reloadInputViews()
//
//            DispatchQueue.main.async {
//                print("This is run on the main queue, after the previous code in outer block")
//                self.myCollectionView.reloadData()
//            }
//        }
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: DiaryThirdViewController =
            segue.destination as? DiaryThirdViewController else {
                return
        }
        nextViewController.selectedImage = self.imageView.image
        nextViewController.posts = self.posts
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

struct DeviceInfo {
    struct Orientation {
        // indicate current device is in the LandScape orientation
        static var isLandscape: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isLandscape
                    : UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
        // indicate current device is in the Portrait orientation
        static var isPortrait: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isPortrait
                    : UIApplication.shared.statusBarOrientation.isPortrait
            }
        }
    }
}

