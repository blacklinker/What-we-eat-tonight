//
//  TopNav.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import SwiftUI

struct TopNav: View {
    var body: some View {
        HStack(alignment: .center, spacing: 30){
            Text("菜谱")
            Text("吃什么")
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 25).frame(width: 70, height: 30))
            Text("材料")
        }
        .frame(width: UIScreen.main.bounds.width)
        .font(.system(size: 13))
    }
}

struct TopNav_Previews: PreviewProvider {
    static var previews: some View {
        TopNav()
    }
}
