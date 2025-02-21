//
//  DepositCheckView.swift
//  MobileBank
//
//  Created by Stuart Minchington on 12/28/24.
//
import SwiftUI
import AVFoundation
import UIKit

struct DepositCheckView: View {
    @State private var isShowingCamera = false
    @State private var inputImage: UIImage?

    var body: some View {
        NavigationView {
            VStack {
                Text("Deposit a Check")
                if let image = inputImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                } else {
                    Image(systemName: "camera")
                        .font(.system(size: 100))
                        .foregroundColor(.gray)
                }
                Button("Take Photo") {
                    isShowingCamera = true
                }
            }
            .sheet(isPresented: $isShowingCamera) {
                ImagePicker(sourceType: .camera, selectedImage: $inputImage)
            }
            .navigationTitle("Deposit Check")
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.selectedImage = info[.originalImage] as? UIImage
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

