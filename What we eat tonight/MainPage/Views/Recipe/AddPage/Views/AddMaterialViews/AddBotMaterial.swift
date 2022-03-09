//
//  AddBotMaterial.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-16.
//

import SwiftUI
import Combine

struct AddBotMaterial: View {
    @EnvironmentObject var materialVM: MaterialViewModel
    @Binding var material: String
    @Binding var qty: String
    
    var body: some View {
        VStack{
            TextField("Material Name", text: $material).modifier(TextFieldModifier())
            TextField("Qty: 0", text: $qty).modifier(TextFieldModifier())
                        .keyboardType(.numberPad)
                        .onReceive(Just(qty)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.qty = filtered
                            }
                    }
            HStack{
                Spacer()
                Button(action: {
                    Task{
                        await materialVM.addMaterial(name: self.material, qty: Int(self.qty) ?? 0)
                        self.material = ""
                        self.qty = ""
                    }
                }){
                    Text("Add").font(.system(size: 15))
                }.font(.system(size: 12)).modifier(TextModifier(.green))
            }
        }.font(.system(size: 12))
        .padding(10)
        .padding(.bottom, UIScreen.main.bounds.width / 10)
    }
}

struct AddBotMaterial_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([
            ColorScheme.light,
            ColorScheme.dark
        ], id :\.self) { scheme in
            AddBotMaterial(material: .constant("test"), qty: .constant("")).environmentObject(MaterialViewModel())
                .colorScheme(scheme)
            //               .previewLayout(.sizeThatFits)
            //                .previewDevice("iPhone SE")
                            .previewDevice("iPhone 11")
            //                .previewDevice("iPhone 12")
            //                .previewDevice("iPhone 13")
            //                .previewDevice("iPhone 13 Pro Max")
            //                .previewLayout(.fixed(width: 500, height: 800))
        }
    }
}
