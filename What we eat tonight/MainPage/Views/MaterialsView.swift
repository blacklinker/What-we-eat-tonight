//
//  MaterialsView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-13.
//

import SwiftUI

struct MaterialsView: View {
    @StateObject var materialVM = MaterialViewModel()
    @State var lst = [Material]()

    var body: some View {
        Button( action: {
            materialVM.getMaterials{completion in
                self.lst = try! completion.get()
            }
        }) {
            Text("text")
        }
    }
}

struct MaterialsView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialsView()
    }
}
