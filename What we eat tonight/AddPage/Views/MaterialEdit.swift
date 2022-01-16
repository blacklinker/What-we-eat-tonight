//
//  MaterialEdit.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-15.
//

import SwiftUI

struct MaterialEdit: View {
    let name: String
    @State private var showEdit = false
    
    var body: some View {
        ZStack{
            if showEdit{
                HStack{
                    Button(action: {}){
                        Text("Edit").foregroundColor(.white).font(.system(size: 20))
                    }.padding()
                        .background(.green)
                        .cornerRadius(10)
                    Button(action: {}){
                        Text("Delete").foregroundColor(.white)
                            .font(.system(size: 20))
                    }.padding()
                        .background(.red)
                        .cornerRadius(10)
                }.frame(width: 180, height: 70)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }else{
                Button(action: {showEdit.toggle()}){
                    Text(name)
                }.padding()
                    .padding(10)
                    .background(.white)
                    .cornerRadius(15)
                
            }
            
            
            
        }
    }
}

struct MaterialEdit_Previews: PreviewProvider {
    static var previews: some View {
        MaterialEdit(name: "test")
    }
}
