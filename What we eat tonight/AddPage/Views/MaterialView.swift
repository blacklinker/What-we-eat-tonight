//
//  MaterialView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-06.
//

import SwiftUI

struct MaterialView: View {
    
    @StateObject var materialVM = MaterialViewModel()
    @State var material: String = ""
    
    var body: some View {
        ScrollView(.vertical ,showsIndicators: true){
            VStack(alignment: .leading){
                switch materialVM.state{
                case .success:
                    ForEach(materialVM.materialList!, id: \.id){ material in
                        MaterialEdit(name: material.name)
                    }
                case .loading:
                    ProgressView().padding()
                default:
                    Text("Something went wrong")
                }
                
                TextField("Materials", text: $material)
                    .autocapitalization(.none)
                    .font(.system(size: 15))
                    .frame(height: 30)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(15)
                
                Button(action: {
                    Task{
                        await materialVM.addMaterials(name: self.material)
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
        }.task {
            await materialVM.getMaterials()
        }
    }
}

struct MaterialView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialView()
    }
}
