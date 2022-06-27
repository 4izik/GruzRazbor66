//
//  PhotoAuthCenter.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 27.06.2022.
//

import UIKit
import Photos

class PhotoAuthCenter {
    
    static func checkLibraryAuthentication(in controller: UIViewController, completion: (() -> ())?) {
        let status: PHAuthorizationStatus
        
        if #available(iOS 14, *) {
            status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        } else {
            status = PHPhotoLibrary.authorizationStatus()
        }
        
        switch status {
        case .authorized:
            DispatchQueue.main.async {
                completion?()
            }
        case .denied, .restricted :
            DispatchQueue.main.async {
                showAlertAuthError(in: controller,
                                              withTitle: "Нет доступа к медиатеке",
                                              withMessage: "Пожалуйста предоставьте доступ к медиатеке")
            }
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization() { newStatus in
                DispatchQueue.main.async {
                    PhotoAuthCenter.checkLibraryAuthentication(in: controller) {
                        completion?()
                    }
                }
            }
        case .limited:
            if #available(iOS 14, *) {
                PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: controller)
            } else {
                return
            }
        default: return
        }
    }
    
    static func checkCameraAuthentication(in controller: UIViewController, completion: @escaping () -> ()) {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)

        switch cameraAuthorizationStatus {
        case .denied, .restricted:
            DispatchQueue.main.async {
                self.showAlertAuthError(in: controller,
                                                   withTitle: "Нет доступа к камере",
                                                   withMessage: "Пожалуйста предоставьте доступ к камере")
            }
        case .authorized:
            DispatchQueue.main.async {
                completion()
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                if granted {
                    
                    DispatchQueue.main.async {
                        PhotoAuthCenter.checkCameraAuthentication(in: controller) {
                            completion()
                        }
                    }
                    
                }
            }
        default: return
        }
    }
    
    private static func showAlertAuthError(in controller: UIViewController,
                                                      withTitle title: String,
                                                      withMessage message: String) {

        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (_) in
            let settingsUrl = NSURL(string: UIApplication.openSettingsURLString)
            if let url = settingsUrl {
                UIApplication.shared.open(url as URL)
            }
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)

        ac.addAction(cancelAction)
        ac.addAction(settingsAction)

        controller.present(ac, animated: true)
    }
}
