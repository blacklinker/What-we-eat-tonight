//
//  MaterialEdit.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-15.
//

import SwiftUI

struct MaterialEdit: View {
    let material: Material
    @State private var showDelete = false
    @EnvironmentObject var materialVM: MaterialViewModel
    
    var body: some View {
        ZStack{
            Text(material.name)
                .font(.system(size: 12))
                .foregroundColor(.white)
                .padding(10)
                .background(.green)
                .cornerRadius(10)
                .zIndex(1)
                .onTapGesture {
                    withAnimation{
                        showDelete.toggle()
                    }
                }
           if showDelete {
                Button(action: {
                    Task{
                        await materialVM.deleteMaterial(id: material.id)
                    }
                }){
                    Text("✕")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .frame(width:15,height:15)
                        .background(Color.red)
                        .cornerRadius(100)
                }.offset(x: material.name.widthOfString(usingFont: UIFont.systemFont(ofSize: 12)) * 0.5 + 7.5,y:-15)
                   .zIndex(2)
            }
        }
        .transition(AnyTransition.scale)
    }
}

struct MaterialEdit_Previews: PreviewProvider {
    static var previews: some View {
        MaterialEdit(material:  Material(id: "", name: "test"))
    }
}
