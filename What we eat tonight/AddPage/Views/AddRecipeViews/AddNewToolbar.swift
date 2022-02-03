//
//  AddNewView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import SwiftUI

struct AddNewToolbar: View {
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var isImagePickerDisplay = false
    @Binding var selectedImage: UIImage?
    
    @Binding var ifAdd: Bool
    
    var body: some View {
        VStack(spacing: 0){
            Spacer()
            VStack(spacing: 0){
                Button(action: {
                    self.sourceType = .camera
                    self.isImagePickerDisplay.toggle()
                    
                }){
                    Text("Take photo").frame(width: UIScreen.main.bounds.width, height: 40)
                }.background(.white)
                Divider()
                Button(action: {
                    self.sourceType = .photoLibrary
                    self.isImagePickerDisplay.toggle()
                }){
                    Text("Select from library").frame(width: UIScreen.main.bounds.width, height: 40)
                }.background(.white)
            }
            Divider()
            Button(action: {
                withAnimation{
                    ifAdd = false
                }
            }){
                Text("Cancel").frame(width: UIScreen.main.bounds.width, height: 60, alignment: .center)
            }
            .padding(.bottom, UIScreen.main.bounds.width / 3)
            .background(.white)
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .bottom)
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $isImagePickerDisplay) {
            ImagePicker(sourceType: self.sourceType, selectedImage: self.$selectedImage, ifAdd: $ifAdd)
        }
        
    }
}

struct AddNewToolbar_Previews: PreviewProvider {
    static var previews: some View {
        AddNewToolbar(selectedImage: Binding.constant(nil), ifAdd: .constant(true))
    }
}
