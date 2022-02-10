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
    @State var qty: String = ""
    
    var body: some View {
        ZStack{
            VStack{
                switch materialVM.state{
                case .success:
                    List{
                        ForEach(materialVM.materialList){ material in
                            AddMaterialRow(material: material).swipeActions(edge: .trailing, allowsFullSwipe: true) {
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
                AddBotMaterial(material: $material, qty: $qty).environmentObject(materialVM)
            }
            .zIndex(1)
            .font(.system(size: 14))
            .navigationTitle("Material")
            .task {
                await materialVM.getMaterials()
            }
            
            if materialVM.error != nil{
                Text(materialVM.error!.localizedDescription)
                    .zIndex(2)
                    .animation(.easeInOut, value: 4)
                    .offset(y: -10)
                    .foregroundColor(.red)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation{
                                materialVM.error = nil
                            }
                        }
                    }
            }
        }
    }
}

