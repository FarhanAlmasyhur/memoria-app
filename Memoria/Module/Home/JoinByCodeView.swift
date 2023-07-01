//
//  JoinByCodeView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 01/07/23.
//

import SwiftUI

struct JoinByCodeView: View {
    
    @State private var text: String = ""
    @State private var wrongCode: Bool = false
    
    let height: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Join by Code")
                .font(.custom("Inter", fixedSize: 14))
                .foregroundColor(.softWhite)
                .fontWeight(.medium)
            HStack {
                TextField("", text: $text)
                    .font(.custom("Inter", fixedSize: 15))
                    .foregroundColor(.blackAccent)
                    .padding(7)
                Button(action: {
                    withAnimation(.easeIn) {
                        wrongCode = true
                    }
                }) {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .padding(10)
                        .foregroundColor(.black)
                        .animation(.default)
                }
            }.background(Color.white, alignment: .center)
                .cornerRadius(6)
            if wrongCode == false {
                Text("Ask for party code to the host")
                    .font(.custom("Inter", fixedSize: 14))
                    .foregroundColor(Color(hex: "737373"))
                    .fontWeight(.regular)
            } else {
                Text("Invalid code")
                    .font(.custom("Inter", fixedSize: 14))
                    .foregroundColor(.red)
                    .fontWeight(.regular)
            }
            
        }.frame(height: height)
         .padding()
         .background(Color.blackBg)
         .onChange(of: text) { _ in
             withAnimation(.easeIn) {
                 wrongCode = false
             }
         }
    }
}

struct JoinByCodeView_Previews: PreviewProvider {
    static var previews: some View {
        JoinByCodeView(height: 200)
    }
}
