//
//  DeviceInput.swift
//  BeautyAndBeast
//
//  Created by 如昀李 on 2019/6/12.
//  Copyright © 2019年 李如昀. All rights reserved.
//

import Foundation
import AVFoundation


class DeviceInput: NSObject {
    var frontWildAngleCamera:AVCaptureDeviceInput?
    var backWildAngleCAmera:AVCaptureDeviceInput?
    var backTelephotoCamera:AVCaptureDeviceInput?
    var backDualCamera:AVCaptureDeviceInput?
    
    func getAllCamera(){
        
        
        let cameraDevice = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera, .builtInTelephotoCamera,
                          .builtInDualCamera],
            mediaType: .video,
            position: .unspecified
            ).devices
        
        for camera in cameraDevice {
            let inputDevice = try! AVCaptureDeviceInput(device: camera)
            
            if camera.deviceType == .builtInWideAngleCamera, camera.position == .front {
                frontWildAngleCamera = inputDevice
            }
            
            if camera.deviceType == .builtInWideAngleCamera, camera.position == .back {
                backWildAngleCAmera = inputDevice
            }
            
            if camera.deviceType == .builtInTelephotoCamera {
                backTelephotoCamera = inputDevice
            }
            
            if camera.deviceType == .builtInDualCamera {
                backDualCamera = inputDevice
            }
        }
    }
    
    override init() {
        super.init()
        getAllCamera()
    }
}


