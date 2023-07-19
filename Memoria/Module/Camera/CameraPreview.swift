//
//  CameraPreview.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 19/07/23.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
  
    @ObservedObject var camera: CameraModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        camera.session.startRunning()
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}

class CameraModel: ObservableObject {
    
    @Published var isTaken: Bool = false
    @Published var session = AVCaptureSession()
    @Published var alert: Bool = false
    @Published var output: AVCapturePhotoOutput = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    func checkAuthorizationStatus() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    self.setUp()
                    return
                }
            }
        case .restricted:
            self.alert.toggle()
            return
        case .denied:
            self.alert.toggle()
            return
        case .authorized:
            self.setUp()
        @unknown default:
            return
        }
    }
    
    func setUp() {
        do {
            self.session.beginConfiguration()
            guard let device = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .back) else { return }
            let input = try AVCaptureDeviceInput(device: device)
            
            if self.session.canAddInput(input) {
                self.session.addInput(input)
            }
            
            if self.session.canAddOutput(output) {
                self.session.addOutput(output)
            }
            
            self.session.commitConfiguration()
            
        } catch {
            
        }
    }
    
}
