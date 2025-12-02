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
    // 1. ACCESS THE SHARED ACCOUNT MANAGER
    @Environment(AccountManager.self) var accountManager
    @Environment(\.dismiss) var dismiss
    
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
                        // 2. USE accountManager.accounts
                        ForEach(accountManager.accounts.indices, id: \.self) { index in
                            Text(accountManager.accounts[index].name)
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
                        // 3. Update prototype action to use the manager for logging
                        print("Depositing $\(depositAmount) to \(accountManager.accounts[selectedAccountIndex].name)")
                        
                        // NOTE: For a functional prototype, you would add a method to AccountManager here
                        // to actually update the balance, similar to performTransfer.
                        
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


// MARK: - ImagePicker (Updated UIViewControllerRepresentable - No change needed here)

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .camera
    @Binding var selectedImage: UIImage?
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
            selectedImage = info[.originalImage] as? UIImage
            dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss()
        }
    }
}
