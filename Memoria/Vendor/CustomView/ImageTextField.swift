//
//  ImageTextField.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 25/06/23.
//

import SwiftUI

struct ImageTextField: View {
    
    let image: Image
    @Binding var text: String
    
    var body: some View {
        HStack {
            Spacer(minLength: 20)
            
            HStack(alignment: .center, spacing: 10) {
                image
                    .resizable()
                    .frame(width: 14, height: 14, alignment: .center)
                    .foregroundColor(.black)
                    .frame(minWidth: 0, maxWidth: 30)
                    .frame(minHeight: 0, maxHeight: 33)
                TextField("", text: $text)
                    .font(.custom("Inter", fixedSize: 15))
                    .foregroundColor(.blackAccent)
                
            }
            .padding([.top,.bottom], 2)
            .background(Color.white, alignment: .center)
            .cornerRadius(5)
            
            Spacer(minLength: 20)
        }
    }
}

struct ImageTextField_Previews: PreviewProvider {
    static var previews: some View {
        ImageTextField(image: Image(systemName: "person"), text: .constant("halo"))
    }
}
