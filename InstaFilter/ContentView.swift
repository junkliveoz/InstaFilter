//
//  ContentView.swift
//  InstaFilter
//
//  Created by Adam Sayer on 12/8/2024.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    
    
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilterOne = false
    @State private var showingFilterTwo = false
    @State private var filterOne = "Change Filter"
    @State private var filterTwo = "Change Filter"
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let processedImage {
                    ShareLink(item: processedImage, preview: SharePreview("Instafilter Image", image: processedImage)) {
                        Label("Click to share", systemImage: "photo")
                    }
                }
                Spacer ()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                Spacer ()
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, applyProcessing)
                        .disabled(filterOne == "Change Filter")
                }
                HStack {
                    Button(filterOne) {
                        changeFilter(filterNum: 1)
                    }
                    .disabled(processedImage == nil)
                    
                    Spacer()
                }
                
                HStack {
                    Text("Radius")
                    Slider(value: $filterRadius)
                        .onChange(of: filterRadius, applyProcessing)
                        .disabled(filterTwo == "Change Filter")
                }
                
                HStack {
                    Button(filterTwo) {
                        changeFilter(filterNum: 2)
                    }
                        .disabled(processedImage == nil)
                    Spacer()
                }
                
                
            }
        }
        .padding([.horizontal, .bottom])
        .navigationTitle("Instafilter")
        .confirmationDialog("Select a filter", isPresented: $showingFilterOne) {
            Button("Edges") {
                setFilter(CIFilter.edges())
                filterOne = "Edges"
            }
            Button("Dot Screen") {
                setFilter(CIFilter.dotScreen())
                filterOne = "Dot Screen"
            }
            Button("Pixellate") {
                setFilter(CIFilter.pixellate())
                filterOne = "Pixellate"
            }
            Button("Sepia Tone") {
                setFilter(CIFilter.sepiaTone())
                filterOne = "Sepia Tone"
            }
            Button("Unsharp Mark") {
                setFilter(CIFilter.unsharpMask())
                filterOne = "Unsharp Mark"
            }
            Button("Vignette") { 
                setFilter(CIFilter.vignette())
                filterOne = "Vignette"
            }
            Button("Cancel", role: .cancel) { }
        }
        .confirmationDialog("Select a filter", isPresented: $showingFilterTwo) {
            Button("Crystallize") {
                setFilter(CIFilter.crystallize())
                filterTwo = "Crystallize"
            }
            Button("Gaussian Blur") {
                setFilter(CIFilter.gaussianBlur())
                filterTwo = "Gaussian Blur"
            }
            Button("Bokeh Blur") {
                setFilter(CIFilter.bokehBlur())
                filterTwo = "Bokeh Blur"
            }
            Button("Pinch Distortion") {
                setFilter(CIFilter.pinchDistortion())
                filterTwo = "Pinch Distortion"
            }
            Button("Unsharp Mark") {
                setFilter(CIFilter.unsharpMask())
                filterTwo = "Unsharp Mark"
            }
            Button("Zoom Blur") {
                setFilter(CIFilter.zoomBlur())
                filterTwo = "Zoom Blur"
            }
            Button("Cancel", role: .cancel) { }
        }
    }
    
    func changeFilter(filterNum: Int) {
        if filterNum == 1 {
            showingFilterOne = true
        } else if filterNum == 2 {
            showingFilterTwo = true
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
        
    }
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        
        if filterCount >= 20 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
