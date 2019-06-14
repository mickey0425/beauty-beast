//
//  PhotoViewController.swift
//  BeautyAndBeast
//
//  Created by 莊閔期 on 2019/6/12.
//  Copyright © 2019年 莊閔期. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseMLCommon

class PhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var faceLabel: UILabel!

    @IBOutlet weak var chosePhoto: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chosePhoto.layer.cornerRadius = 20
       
        guard let manifestPath = Bundle.main.path(forResource: "manifest",
                                                  ofType: "json",
                                                  inDirectory: "my_model") else { return }
        let localModel = LocalModel(
            name: "beautyModel",
            path: manifestPath
        )
        print(localModel)
        ModelManager.modelManager().register(localModel)
    }
    
    @IBAction func choseButton(_ sender: UIButton) {
        print("click")
        
        let imagePickerVC = UIImagePickerController()
        
        // 設定來源：手機相簿
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        
        imagePickerVC.modalPresentationStyle = .popover
        let popover = imagePickerVC.popoverPresentationController
        popover?.sourceView = sender
        
        popover?.sourceRect = sender.bounds
        popover?.permittedArrowDirections = .any
        
        show(imagePickerVC,sender:self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as!  UIImage
        imageView.image = image
        dismiss(animated: true, completion: nil)
        
        let visionImage = VisionImage(image: image)
        print(visionImage)
        
        DispatchQueue.global().async {
            self.beautyImg(visionImage: visionImage)
        }
    }
    
    func beautyImg(visionImage: VisionImage){
        
        
        let labelerOptions = VisionOnDeviceAutoMLImageLabelerOptions(
            remoteModelName: nil,  // Or nil to not use a remote model
            localModelName: "beautyModel"     // Or nil to not use a bundled model
        )
        labelerOptions.confidenceThreshold = 0  // Evaluate your model in the Firebase console
        // to determine an appropriate value.
        let labeler = Vision.vision().onDeviceAutoMLImageLabeler(options: labelerOptions)
        
        labeler.process(visionImage) { labels, error in
            guard error == nil, let labels = labels else { return }
            print(labels[0].text)
            print(labels[0].confidence!)
            DispatchQueue.main.async {
                self.faceLabel.text = labels[0].text
            }
        }
    }
    
   
    
  
}


