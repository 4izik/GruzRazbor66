//
//  ScanerViewController.swift
//  GruzRazbor66
//
//  Created by Настя on 23.05.2022.
//

import UIKit
import AVFoundation

class ScanerViewController: UIViewController {
    // MARK: - Properties
    
    var video = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()
        
    // MARK: - Vivew LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        startRunning()
    }

    func setupVideo() {
        let captureDevice = AVCaptureDevice.default(for: .video)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        } catch {
            fatalError(error.localizedDescription)
        }
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
    }
    
    func startRunning() {
        setupVideo()
        view.layer.addSublayer(video)
        session.startRunning()
    }
    
}

extension ScanerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard !metadataObjects.isEmpty else { return }
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            if object.type == AVMetadataObject.ObjectType.qr {
                let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Перейти", style: .default, handler: { [weak self] _ in
                    if let vendorCode = object.stringValue {
                        DispatchQueue.main.async { [weak self] in
                            let navigationVC = self?.tabBarController?.viewControllers?[0] as! UINavigationController
                            let mainVC = navigationVC.topViewController as! MainViewController
                            mainVC.codeFromScanner = vendorCode
                            self?.tabBarController?.selectedIndex = 0
                            
                        }
                    }
                }))
                alert.addAction(UIAlertAction(title: "Копировать", style: .default, handler: { [weak self] _ in
                    UIPasteboard.general.string = object.stringValue
                    self?.view.layer.sublayers?.removeLast()
                    self?.session.stopRunning()
                }))
                present(alert, animated: true, completion: nil)
            }
        }
    }
}
