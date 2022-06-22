//
//  PhotosViewController.swift
//  GruzRazbor66
//
//  Created by Настя on 24.05.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    var model: DetailModel?
    var selectedImage: Int = 0
    
    let animationDuration: NSTimeInterval = 0.25
    let switchingInterval: NSTimeInterval = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addSwipeGesture()
    }
    
    private func setupUI() {
        closeButton.layer.cornerRadius = 23
        closeButton.clipsToBounds = true
        
        photoImageView.image = model?.photos[selectedImage]
        guard let allPhotosCount = model?.photos.count else { return }
        numberLabel.text = "\(selectedImage + 1)/\(allPhotosCount)"
    }
    
    @IBAction func closePhotosVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func addSwipeGesture() {
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(actionLeftSwipeGesture(_:)))
        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(actionRightSwipeGesture(_:)))
                
        leftGesture.direction = .left
        rightGesture.direction = .right
                
        self.view.addGestureRecognizer(leftGesture)
        self.view.addGestureRecognizer(rightGesture)
    }
    
    private func updateValues() {
        photoImageView.image = model?.photos[selectedImage]
        guard let allPhotosCount = model?.photos.count else { return }
        numberLabel.text = "\(selectedImage + 1)/\(allPhotosCount)"
    }
    
    @objc func actionLeftSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        guard let allPhotosCount = model?.photos.count else { return }
        if selectedImage == allPhotosCount - 1 {
            selectedImage = 0
        } else {
            selectedImage += 1
        }
        updateValues()
    }
        
    @objc func actionRightSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        guard let allPhotosCount = model?.photos.count else { return }
        if selectedImage == 0 {
            selectedImage = allPhotosCount - 1
        } else {
            selectedImage -= 1
        }
        updateValues()
    }
    
    func animateImageView() {
        CATransaction.begin()

        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            let delay = dispatch_time(dispatch_time_t(DispatchTime.now()), Int64(self.switchingInterval * NSTimeInterval(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                self.animateImageView()
            }
        }

        let transition = CATransition()
        transition.type = CATransitionType.fade
                    /*
                    transition.type = kCATransitionPush
                    transition.subtype = kCATransitionFromRight
                    */
        photoImageView.layer.add(transition, forKey: kCATransition)
        photoImageView.image = model?.photos[selectedImage]

        CATransaction.commit()

       // index = index < images.count - 1 ? index + 1 : 0
    }

}
