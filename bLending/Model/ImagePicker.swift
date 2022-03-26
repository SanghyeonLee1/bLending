//
//  ImagePicker.swift
//  bLending
//
//  Created by Sanghyeon_Lee on 2021/10/22.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    let configuration: PHPickerConfiguration
    @Binding var pickerResult: [UIImage]
    //@Binding var pickerResult: Data
    @Binding var isPresented: Bool

    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_: PHPickerViewController, context _: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
    
    
        func picker(_: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            for image in results {
                image.itemProvider.loadObject(ofClass: UIImage.self) { selectedImage, error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        self.parent.pickerResult.append(selectedImage as! UIImage)
                        
                    }
                }
            }
            
            parent.isPresented = false
        }
    }
}
