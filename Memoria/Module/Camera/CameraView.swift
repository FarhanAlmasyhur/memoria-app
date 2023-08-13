//
//  CameraView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 17/07/23.
//
import SwiftUI

struct CameraView: View, KeyboardReadable {
    
    @StateObject var viewModel = CameraViewModel()
    @StateObject var appStateNavigation: AppStateNavigation = AppStateNavigation.shared
    @State var settingsSheetViewHeight: CGFloat = .zero
   
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                cameraPreviewStack(geometry: geometry)
                Spacer()
                shotDetailsStack()
                Spacer()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onAppear {
                viewModel.checkAuthorizationStatus()
                setSettingsSheetViewHeight(height: geometry.size.height * 0.5)
            }.bottomSheet(isPresented: $viewModel.showSettingsSheet, height: settingsSheetViewHeight) {
                SettingsSheetView(viewModel: viewModel, height: $settingsSheetViewHeight)
            }.bottomSheet(isPresented: $viewModel.showShareQRSheet, height: geometry.size.height * 0.8, content: {
                ShareQRSheetView(viewModel: viewModel)
            })
            .onReceive(keyboardPublisher) { keyboardVisible in
                if keyboardVisible {
                    setSettingsSheetViewHeight(height: geometry.size.height * 0.9)
                } else {
                    setSettingsSheetViewHeight(height: geometry.size.height * 0.5)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.blackAccent)
        .navigationBarHidden(true)
        .environmentObject(appStateNavigation)
    }
    
    private func setSettingsSheetViewHeight(height: CGFloat) {
        withAnimation {
            self.settingsSheetViewHeight = height
        }
    }
    
    private func cameraPreviewStack(geometry: GeometryProxy) -> some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .bottom) {
                CameraPreview(viewModel: viewModel)
                    .frame(height: geometry.size.height * 0.8)
                    .cornerRadius(24)
                controlButtonsStack()
            }
            dateLabel()
        }
    }
    
    private func controlButtonsStack() -> some View {
        HStack {
            Spacer()
            controlButton(imageName: "bolt.fill", action: {
                viewModel.toggleFlashlight()
            })
            Spacer()
            Color.white
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .onTapGesture {
                    viewModel.takePicture()
                }
            Spacer()
            controlButton(imageName: "arrow.triangle.2.circlepath.camera.fill", action: {
                viewModel.switchCamera()
            })
            Spacer()
        }
        .padding()
        .padding(.bottom, 30)
    }
    
    private func controlButton(imageName: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: imageName)
                .foregroundColor(.white)
                .padding()
                .background(Color.grayBg.clipShape(Circle()).opacity(0.4))
        }
    }
    
    private func dateLabel() -> some View {
        HStack {
            Text("\(Date().toString(withFormat: "dd MMMM"))")
                .font(.custom("Inter", fixedSize: 12))
                .fontWeight(.semibold)
                .foregroundColor(.softWhite)
        }
        .padding()
        .background(Color.black.opacity(0.4))
        .cornerRadius(6)
        .padding(.top, 20)
    }
    
    private func shotDetailsStack() -> some View {
        HStack {
            Text("< Back")
                .foregroundColor(.white)
                .font(.custom("Inter", fixedSize: 15))
                .fontWeight(.medium)
                .onTapGesture {
                    appStateNavigation.path.removeLast()
                }
            Spacer()
            shotCounter()
            Spacer()
            settingsButton()
        }
        .padding()
    }
    
    private func shotCounter() -> some View {
        HStack(spacing: 0) {
            Text("10 ")
                .foregroundColor(.white)
                .font(.system(size: 23))
                .italic()
                .bold()
            Text("Shots Remaining")
                .italic()
                .foregroundColor(.white)
                .font(.custom("Inter", fixedSize: 15))
                .fontWeight(.medium)
        }
    }
    
    private func settingsButton() -> some View {
        
        Button {
            withAnimation(.interactiveSpring()) {
                viewModel.showSettingsSheet.toggle()
            }
        } label: {
            HStack(spacing: 2) {
                Text("Settings")
                    .foregroundColor(.white)
                    .font(.custom("Inter", fixedSize: 15))
                    .fontWeight(.regular)
                Image(systemName: "gearshape")
                    .font(Font.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
            }
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
