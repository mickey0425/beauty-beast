//
//  CameraViewController.swift
//  BeautyAndBeast
//
//  Created by 如昀李 on 2019/6/12.
//  Copyright © 2019年 李如昀. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var forPreview: UIView!
    let session = AVCaptureSession()
    let deviceInput = DeviceInput()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        settingPreviewLayer()
        session.addInput(deviceInput.backWildAngleCAmera!)
        
        session.sessionPreset = .photo
        session.addOutput(AVCapturePhotoOutput())
        
        session.startRunning()
        
    }
    
    func settingPreviewLayer(){
        
        let previewlayer = AVCaptureVideoPreviewLayer()
        previewlayer.frame = forPreview.bounds
        previewlayer.session = session
        previewlayer.videoGravity = .resizeAspectFill
        forPreview.layer.addSublayer(previewlayer)
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
    
    @IBAction func takeBtn(_ sender: Any) {
        let setting = AVCapturePhotoSettings()
        setting.flashMode = .off
        
        let output = session.outputs.first! as! AVCapturePhotoOutput
        output.capturePhoto(with: setting, delegate: self)
    }
    

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        let image = UIImage(data: photo.fileDataRepresentation()!)
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
}

