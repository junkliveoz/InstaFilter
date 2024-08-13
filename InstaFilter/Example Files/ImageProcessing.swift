//
//  ImageProcessing.swift
//  InstaFilter
//
//  Created by Adam Sayer on 13/8/2024.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI


struct ImageProcessing: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = beginImage
        let amount = 1.0
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }

        
        guard let outputImage = currentFilter.outputImage else { return }
        
        guard let cgImg = context.createCGImage(outputImage, from: outputImage.extent)
                else {return}
        
        let uiImage = UIImage(cgImage: cgImg)
        
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    ImageProcessing()
}
