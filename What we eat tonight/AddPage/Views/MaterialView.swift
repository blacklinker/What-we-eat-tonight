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
        VStack(alignment: .leading){
            ScrollView(.vertical ,showsIndicators: true){
                switch materialVM.state{
                case .success:
                    ForEach(materialVM.materialList, id: \.id){ material in
                        MaterialEdit(material: material).environmentObject(materialVM)
                            .animation(.easeInOut, value: 4)
                    }
                case .loading:
                    ProgressView().padding()
                default:
                    Text("Something went wrong")
                }
            }
            Divider()
            AddBotMaterial(material: $material).environmentObject(materialVM)
        }
        .task {
            await materialVM.getMaterials()
        }
    }
}

struct MaterialView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialView()
    }
}
