//
//  DepositCheckView.swift
//  MobileBank
//
//  Created by Stuart Minchington on 12/1/25.
//
import SwiftUI
import UIKit

// MARK: - DepositCheckView (The Main Deposit Screen)

struct DepositCheckView: View {
    @Environment(\.dismiss) var dismiss // Modern way to dismiss the sheet
    @State private var inputImage: UIImage?
    @State private var isShowingCamera = false
    @State private var depositAmount: String = ""
    @State private var selectedAccountIndex = 0
    
    let primaryBankColor = Color(red: 0.0, green: 86.0/255.0, blue: 145.0/255.0)

    var body: some View {
        NavigationView {
            Form {
                // Section 1: Account and Amount
                Section(header: Text("Deposit Details")) {
                    Picker("Deposit To", selection: $selectedAccountIndex) {
                        ForEach(MockData.accounts.indices, id: \.self) { index in
                            Text(MockData.accounts[index].name)
                        }
                    }
                    HStack {
                        Text("Amount")
                        Spacer()
                        TextField("0.00", text: $depositAmount)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .font(.title3.weight(.semibold))
                    }
                }
                
                // Section 2: Check Photo
                Section(header: Text("Check Photo (Front)")) {
                    VStack {
                        if let image = inputImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .cornerRadius(8)
                        } else {
                            Image(systemName: "photo.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                                .padding()
                        }
                        
                        Button {
                            // Check if camera is available (it's not on a Mac simulator)
                            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                isShowingCamera = true
                            } else {
                                print("Camera not available. Use a device or change sourceType to .photoLibrary for simulator testing.")
                            }
                        } label: {
                            Label("Take Photo", systemImage: "camera.fill")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(inputImage == nil ? Color(.systemGray5) : primaryBankColor)
                                .foregroundColor(inputImage == nil ? .primary : .white)
                                .cornerRadius(10)
                        }
                    }
                }
                
                // Section 3: Deposit Button
                Section {
                    Button("Confirm Deposit") {
                        // Prototype action
                        print("Depositing $\(depositAmount) to \(MockData.accounts[selectedAccountIndex].name)")
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(primaryBankColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Deposit Check")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $isShowingCamera) {
                // Use the updated ImagePicker
                ImagePicker(selectedImage: $inputImage)
            }
        }
    }
}


// MARK: - ImagePicker (Updated UIViewControllerRepresentable)

struct ImagePicker: UIViewControllerRepresentable {
    // We are defaulting to .camera, but the user can change this for simulator testing.
    var sourceType: UIImagePickerController.SourceType = .camera
    @Binding var selectedImage: UIImage?
    // Use @Environment(\.dismiss) inside the Coordinator for modern dismissal
    @Environment(\.dismiss) var dismiss

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(selectedImage: $selectedImage, dismiss: dismiss)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var selectedImage: UIImage?
        var dismiss: DismissAction

        init(selectedImage: Binding<UIImage?>, dismiss: DismissAction) {
            _selectedImage = selectedImage
            self.dismiss = dismiss
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // Use .originalImage for full resolution
            selectedImage = info[.originalImage] as? UIImage
            dismiss() // Use the modern dismissal action
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss()
        }
    }
}
