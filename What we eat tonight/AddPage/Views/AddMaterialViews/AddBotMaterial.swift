//
//  AddBotMaterial.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-16.
//

import SwiftUI

struct AddBotMaterial: View {
    @Binding var material: String
    @EnvironmentObject var materialVM: MaterialViewModel
    
    var body: some View {
        VStack{
            TextField("Material Name", text: $material)
                .autocapitalization(.none)
                .font(.system(size: 15))
                .frame(height: 30)
                .padding(.leading, 10)
                .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(.sRGB, red: 0.73, green: 0.73, blue: 0.73), lineWidth: 2)
                )
            
            HStack{
                Spacer()
                Button(action: {
                    Task{
                        await materialVM.addMaterial(name: self.material)
                        self.material = ""
                    }
                }){
                    Text("Add").font(.system(size: 15))
                }.font(.system(size: 12))
                    .frame(height: 20)
                    .padding(.leading, 18)
                    .padding(.trailing, 18)
                    .padding(.top, 7)
                    .padding(.bottom, 7)
                    .foregroundColor(.white)
                    .background(.green)
                    .cornerRadius(15)
            }
        }.padding(10)
            .padding(.bottom, UIScreen.main.bounds.width / 7)
    }
}

struct AddBotMaterial_Previews: PreviewProvider {
    static var previews: some View {
        AddBotMaterial(material: .constant("test")).environmentObject(MaterialViewModel())
    }
}
