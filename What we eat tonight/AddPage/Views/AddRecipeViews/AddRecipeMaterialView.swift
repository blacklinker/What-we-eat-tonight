//
//  AddRecipeMaterialView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-02-05.
//

import SwiftUI
import Combine

struct AddRecipeMaterialView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var addRecipeVM: AddRecipeViewModel
    let material: Material
    @State var qty = "0"
    
    init(material: Material, qty: Int){
        self.material = material
        _qty = State(initialValue: String(qty))
    }
    
    var body: some View {
            Form {
                Section(header: Text("Name")) {
                    Text(material.name).foregroundColor(.gray)
                }
                Section(header: Text("Quantity will be used")) {
                    TextField("0", text: $qty).keyboardType(.numberPad)
                        .onReceive(Just(qty)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.qty = filtered
                            }
                        }
                }
            }.zIndex(1)
            .toolbar {
                Button(action: {
                    Task {
                        await addRecipeVM.addMaterial(id: material.id, qty: self.qty)
                    }
                    self.presentationMode.wrappedValue.dismiss()
                    
                }){
                    Text("Done")
                }
            }
        

    }
}
