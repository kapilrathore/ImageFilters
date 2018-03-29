//
//  ViewController.swift
//  CoreImage
//
//  Created by Kapil Rathore on 25/03/18.
//  Copyright © 2018 Kapil Rathore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView! {
        didSet {
            imageView.isUserInteractionEnabled = true
            
            let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureOnImage(_:)))
            rightSwipeGesture.direction = .right
            
            let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureOnImage(_:)))
            leftSwipeGesture.direction = .left
            
            imageView.addGestureRecognizer(rightSwipeGesture)
            imageView.addGestureRecognizer(leftSwipeGesture)
        }
    }
    
    @IBOutlet private weak var displayLabel: UILabel! {
        didSet {
            displayLabel.text = "Please select an image to apply filters to."
        }
    }
    
    @IBOutlet private weak var filterNameLabel: UILabel! {
        didSet {
            filterNameLabel.text = ""
            filterNameLabel.isHidden = true
        }
    }
    
    @objc func swipeGestureOnImage(_ sender: UISwipeGestureRecognizer) {
        
        switch sender.direction {
        case .right : imageFilterer.filterIndex -= 1
        case .left  : imageFilterer.filterIndex += 1
        default     : break
        }
    }
    
    var imagePickerVC: UIImagePickerController! {
        didSet {
            imagePickerVC.delegate = self
        }
    }
    
    var imageFilterer: ImageFiltererType! {
        didSet {
            imageFilterer.viewDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageFilterer = ImageFilterer()
        imagePickerVC = UIImagePickerController()
    }
    
    @IBAction func uploadImage(_ sender: UIBarButtonItem) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceType(rawValue: sender.tag)!
        present(imagePickerVC, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            imageFilterer.originalImage = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController: ImageFilterViewDelegate {
    
    func imageFiltered(_ image: UIImage?) {
        imageView.image = image
    }
    
    func displayFilterName(_ name: String) {
        filterNameLabel.isHidden = false
        filterNameLabel.text = name.capitalized
        displayLabel.text = "Swipe right / left to change filters."
    }
}
