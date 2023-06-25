//
//  MemoriaLogo.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 25/06/23.
//

import SwiftUI

struct MemoriaLogo: View {
    var body: some View {
        HStack {
            Image("ic_memoria")
            Text("Memoria")
                .font(.custom("Inter", fixedSize: 20))
                .fontWeight(.black)
                .foregroundColor(.white)
        }
    }
}

struct MemoriaLogo_Previews: PreviewProvider {
    static var previews: some View {
        MemoriaLogo()
    }
}
