//
//  ScanQRView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 01/07/23.
//

import SwiftUI
import CodeScanner

struct ScanQRView: View {
    
    @StateObject var appStateNavigation = AppStateNavigation.shared
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .bottom) {
                CodeScannerView(codeTypes: [.qr], completion: handleScan)
                LargeButton(title: "Done", backgroundColor: .purpleButton, foregroundColor: .white) {
                    withAnimation(.easeOut) {
                        appStateNavigation.showJoinByQR = false
                    }
                }.padding(.bottom, 20)
            }
            HStack {
                Image(systemName: "qrcode")
                    .foregroundColor(.softWhite)
                Text("Join by Scan QR")
                    .font(.custom("Inter", fixedSize: 12))
                    .fontWeight(.semibold)
                    .foregroundColor(.softWhite)
            }
            .padding()
            .background(Color.black.opacity(0.4))
            .cornerRadius(6)
            .padding(.top, 20)
        }
    }
    
    private func handleScan(result: Result<ScanResult, ScanError>) {
        appStateNavigation.showJoinByQR = false
        switch result {
        case .success(let data):
            appStateNavigation.push(to: Screen.onboarding)
        case .failure(let error):
            print(error)
        }
     }
}

struct ScanQRView_Previews: PreviewProvider {
    static var previews: some View {
        ScanQRView()
    }
}
