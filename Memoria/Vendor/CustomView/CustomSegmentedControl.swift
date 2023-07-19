//
//  CustomSegmentedControl.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 05/07/23.
//

import SwiftUI

struct CustomSegmentedControl: View {
    
    @Binding var preselectedIndex: Int
    var options: [String]
    let color: Color = .primaryWhite
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id:\.self) { index in
                ZStack {
                    Rectangle()
                        .fill(Color.clear)
                    Rectangle()
                        .fill(color)
                        .cornerRadius(6)
                        .padding(2)
                        .opacity(preselectedIndex == index ? 1 : 0.001)
                        .onTapGesture {
                                withAnimation(.interactiveSpring()) {
                                    if index < 1 {
                                        preselectedIndex = index
                                    }
                                }
                            }
                }
                .overlay(
                    Text(options[index])
                        .font(.custom("Inter", fixedSize: 14))
                        .foregroundColor( preselectedIndex == index ? Color(hex: "#4F46E5") : .softWhite)
                )
            }
        }
        .frame(height: 50)
        .cornerRadius(6)
    }
}

struct CustomSegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        CustomSegmentedControl(preselectedIndex: .constant(0), options: ["Your Party", "As Participant"])
    }
}
