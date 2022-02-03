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
        VStack{
            switch materialVM.state{
            case .success:
                List{
                    ForEach(materialVM.materialList){ material in
                        Text(material.name).swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive){
                                Task{
                                    await materialVM.deleteMaterial(id: material.id ?? "")
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }.environmentObject(materialVM)
                    .background(.white)
                
            case .loading:
                VStack{
                    Spacer()
                    ProgressView().padding()
                    Spacer()
                }.frame(maxWidth: .infinity)
            default:
                Text("Something went wrong")
            }
            AddBotMaterial(material: $material).environmentObject(materialVM)
        }
        .task {
            await materialVM.getMaterials()
        }
    }
}

struct MaterialView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([
            ColorScheme.light,
            ColorScheme.dark
        ], id :\.self) { scheme in
            MaterialView()
                .colorScheme(scheme)
            //               .previewLayout(.sizeThatFits)
            //                .previewDevice("iPhone SE")
            //                .previewDevice("iPhone 11")
            //                .previewDevice("iPhone 12")
            //                .previewDevice("iPhone 13")
            //                .previewDevice("iPhone 13 Pro Max")
            //                .previewLayout(.fixed(width: 500, height: 800))
        }
    }
}
