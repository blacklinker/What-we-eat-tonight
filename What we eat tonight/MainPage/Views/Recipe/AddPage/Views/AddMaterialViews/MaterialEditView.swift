//
//  MaterialEditView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-02-05.
//

import SwiftUI
import Combine

struct MaterialEditView: View {
    @EnvironmentObject var materialVM: MaterialViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let material: Material
    @State var name: String
    @State var qty: String

    init(_ material: Material){
        self.material = material
        _name = State(initialValue: material.name)
        _qty = State(initialValue: String(material.qty))
    }
    
    var body: some View {
        ZStack{
            if materialVM.state == .loading {
                ProgressView().zIndex(2)
            }
            if materialVM.state == .saved {
                Text("Saved!").foregroundColor(.green)
                    .zIndex(3)
                    .transition(.move(edge: .top))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            withAnimation{
                                materialVM.state = .success
                            }
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
            }
            Form {
                Section(header: Text("Edit Material")) {
                    TextField("Name", text: $name)
                    TextField("Quantity", text: $qty).keyboardType(.numberPad)
                        .onReceive(Just(qty)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.qty = filtered
                            }
                        }
                }
            }.zIndex(1)
            .toolbar {
                Button("Save") {
                    Task{
                        await materialVM.editMaterial(id: material.id, name: name, qty: Int(qty) ?? 0)
                    }
                }
            }
        }
       
    }
}
