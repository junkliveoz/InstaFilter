//
//  PhotoLibrary.swift
//  InstaFilter
//
//  Created by Adam Sayer on 13/8/2024.
//

import PhotosUI
import SwiftUI

struct PhotoLibrary: View {
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PhotoLibrary()
}
