//
//  MaterialsView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-13.
//

import SwiftUI

struct MaterialsView: View {
    @StateObject private var materialVM = MaterialViewModel()
    
    var body: some View {
        VStack{
            switch materialVM.state{
            case .success:
                ForEach(materialVM.materialList, id: \.id){ material in
                    Text(material.name)
                }
            case .loading:
                ProgressView().padding()
            default:
                Text("Something went wrong.")
            }
        }
        .task{
            await materialVM.getMaterials()
        }
    }
}

struct MaterialsView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialsView()
    }
}
