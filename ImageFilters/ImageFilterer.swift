//
//  ImageFilterer.swift
//  ImageFilters
//
//  Created by Kapil Rathore on 25/03/18.
//  Copyright © 2018 Kapil Rathore. All rights reserved.
//

import UIKit

protocol ImageFilterViewDelegate {
    func imageFiltered(_ image: UIImage?)
    func displayFilterName(_ name: String)
}

protocol ImageFiltererType {
    var viewDelegate: ImageFilterViewDelegate! { get set }
    var originalImage: UIImage! { get set }
    var filterIndex: Int { get set }
}

class ImageFilterer: ImageFiltererType {
    
    var viewDelegate: ImageFilterViewDelegate!
    
    var originalImage: UIImage! {
        didSet {
            filterIndex = 0
            if originalImage != #imageLiteral(resourceName: "upload") {
                filterOriginalImage()
            }
        }
    }
    
    init() {
        originalImage = #imageLiteral(resourceName: "upload")
    }
    
    var filterIndex: Int = 0 {
        didSet {
            if !(filterIndex >= 0 && filterIndex < filterNames.count) {
                filterIndex = oldValue
            }
            if originalImage != #imageLiteral(resourceName: "upload") {
                filterOriginalImage()
                viewDelegate.displayFilterName(filterDisplayNames[filterIndex])
            }
        }
    }
    
    private let filterNames = [
        "No Filter",
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectMono",
        "CIPhotoEffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CILinearToSRGBToneCurve",
        "CISRGBToneCurveToLinear"
    ]
    
    private let filterDisplayNames = [
        "Normal",
        "Chrome",
        "Fade",
        "Instant",
        "Mono",
        "Noir",
        "Process",
        "Tonal",
        "Transfer",
        "Tone",
        "Linear"
    ]
    
    private let context = CIContext(options: nil)
    
    private func filterOriginalImage() {
        
        guard let filter = CIFilter(name: filterNames[filterIndex]) else {
            viewDelegate.imageFiltered(originalImage)
            return
        }
        
        filter.setDefaults()
        
        let inputImage = CIImage(image: originalImage)
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        if let result = filter.outputImage,
            let cgImage = context.createCGImage(result, from: result.extent) {
            
            viewDelegate.imageFiltered(UIImage(cgImage: cgImage))
        }
    }
}
