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
            TextField("Materials", text: $material)
                .autocapitalization(.none)
                .font(.system(size: 15))
                .frame(height: 30)
                .padding(10)
                .background(.white)
                .cornerRadius(15)
            
            HStack{
                Spacer()
                Button(action: {
                    Task{
                        await materialVM.addMaterial(name: self.material)
                        self.material = ""
                    }
                }){
                    Text("Add Material")
                }.font(.system(size: 12))
                    .frame(height: 20)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.green)
                    .cornerRadius(15)
            }
        }
    }
}

struct AddBotMaterial_Previews: PreviewProvider {
    static var previews: some View {
        AddBotMaterial(material: .constant("test")).environmentObject(MaterialViewModel())
    }
}
