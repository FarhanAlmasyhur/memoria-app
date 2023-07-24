//
//  CameraPreview.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 19/07/23.
//

import SwiftUI
import AVFoundation
import Combine

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

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    
    @Published var isTaken: Bool = false
    @Published var session = AVCaptureSession()
    @Published var alert: Bool = false
    @Published var output: AVCapturePhotoOutput = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var device: AVCaptureDevice?
    
    private var cancellables: Set<AnyCancellable> = []
    
    func checkAuthorizationStatus() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] status in
                if status {
                    self?.setUp()
                    return
                }
            }
        case .restricted, .denied:
            self.alert.toggle()
        case .authorized:
            setUp()
        @unknown default:
            break
        }
    }
    
    private func setUp() {
        do {
            session.beginConfiguration()
            guard let device = getCamera(with: .back) else { return }
            self.device = device
            let input = try AVCaptureDeviceInput(device: device)
            
            if session.canAddInput(input) {
                session.addInput(input)
            }
            
            if session.canAddOutput(output) {
                session.addOutput(output)
            }
            
            session.commitConfiguration()
            
        } catch {
            print("Error setting up the camera: \(error)")
        }
    }
    
    func takePicture() {
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.session.stopRunning()
            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken.toggle()
                }
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error)")
            return
        }
        print("Photo Taken")
    }
    
    func startSession() {
        if !session.isRunning {
            session.startRunning()
        }
    }
    
    func stopSession() {
        if session.isRunning {
            session.stopRunning()
        }
    }
    
    func toggleFlashlight() {
        guard let device = self.device else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if device.isTorchActive {
                    device.torchMode = .off
                } else {
                    try device.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
                }
                device.unlockForConfiguration()
            } catch {
                print("Error toggling flashlight: \(error)")
            }
        }
    }
    
    func switchCamera() {
        // Check if the current camera is the back camera
        let currentCameraPosition = getCurrentCameraPosition()
        let newCameraPosition: AVCaptureDevice.Position = (currentCameraPosition == .back) ? .front : .back
        
        if let newCamera = getCamera(with: newCameraPosition) {
            do {
                // Begin configuration changes
                session.beginConfiguration()
                
                // Remove existing input
                for input in session.inputs {
                    session.removeInput(input)
                }
                
                // Add new camera input
                let newInput = try AVCaptureDeviceInput(device: newCamera)
                self.device = newCamera
                if session.canAddInput(newInput) {
                    session.addInput(newInput)
                }
                
                // Commit configuration changes
                session.commitConfiguration()
            } catch {
                print("Error switching camera: \(error)")
            }
        }
    }

    private func getCurrentCameraPosition() -> AVCaptureDevice.Position? {
        if let currentInput = session.inputs.first as? AVCaptureDeviceInput {
            return currentInput.device.position
        }
        return nil
    }

    private func getCamera(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let deviceTypes: [AVCaptureDevice.DeviceType] = [.builtInWideAngleCamera, .builtInTelephotoCamera, .builtInUltraWideCamera]
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes, mediaType: .video, position: position).devices
        return availableDevices.first
    }

    
    override init() {
        super.init()
        setupBindings()
    }
    
    private func setupBindings() {
        $isTaken
            .sink { [weak self] isTaken in
                if isTaken {
                    self?.startSession()
                }
            }
            .store(in: &cancellables)
    }
}
