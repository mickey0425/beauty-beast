//
//  HomeViewController.swift
//  BeautyAndBeast
//
//  Created by 如昀李 on 2019/6/11.
//  Copyright © 2019年 李如昀. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var forPreview: UIView!
    let session = AVCaptureSession()
    let deviceInput = DeviceInput()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationItem.setHidesBackButton(true, animated: true)
//
//        self.navigationItem.hidesBackButton = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self,action: #selector(backViewBtnFnc))


        
        // Do any additional setup after loading the view.
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("能拍照")
            
            if UIImagePickerController.isCameraDeviceAvailable(.front){
                print("有前鏡頭")
            }
            
            if UIImagePickerController.isCameraDeviceAvailable(.rear){
                print("有後鏡頭")
            }
            
            if UIImagePickerController.isFlashAvailable(for: .front){
                print("有前閃光燈")
            }
            
            if UIImagePickerController.isFlashAvailable(for: .rear){
                print("有後閃光燈")
            }
            
        }
        
        settingPreviewLayer()
        session.addInput(deviceInput.backWildAngleCAmera!)
        
        session.sessionPreset = .photo
        session.addOutput(AVCapturePhotoOutput())
        
        session.startRunning()
        
    }
    
    @IBAction func FrontBackBtn(_ sender: UISwitch) {
        
        session.beginConfiguration()
        
        session.removeInput(session.inputs.last!)
        
        if sender.isOn {
            session.addInput(deviceInput.backWildAngleCAmera!)
        }else {
            session.addInput(deviceInput.frontWildAngleCamera!)
        }
        
        session.commitConfiguration()
        
    }
    
    @IBAction func takeBtn(_ sender: UIButton) {
        
        let setting = AVCapturePhotoSettings()
        setting.flashMode = .off
        
        let output = session.outputs.first! as! AVCapturePhotoOutput
        output.capturePhoto(with: setting, delegate: self)
    }
    
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        let image = UIImage(data: photo.fileDataRepresentation()!)
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        dismiss(animated: true, completion: nil)
    }
    
    func settingPreviewLayer(){
        
        let previewlayer = AVCaptureVideoPreviewLayer()
        previewlayer.frame = forPreview.bounds
        previewlayer.session = session
        previewlayer.videoGravity = .resizeAspectFill
        forPreview.layer.addSublayer(previewlayer)
    }
    
    @objc func backViewBtnFnc(){
        self.navigationController?.popViewController(animated: true)
    }
   
}
