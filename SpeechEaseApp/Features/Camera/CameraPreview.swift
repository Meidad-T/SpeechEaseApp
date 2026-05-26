import SwiftUI
@preconcurrency import AVFoundation
import UIKit

struct CameraPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CameraViewController {
        return CameraViewController()
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}
}

class CameraViewController: UIViewController {
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = view.bounds
    }
    
    func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .photo
        
        guard let cameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            print("No front camera found")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: cameraDevice)
            if let session = captureSession, session.canAddInput(input) {
                session.addInput(input)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: session)
                previewLayer?.videoGravity = .resizeAspectFill
                previewLayer?.frame = view.bounds
                
                if let layer = previewLayer {
                    view.layer.addSublayer(layer)
                }
                
                DispatchQueue.global(qos: .userInitiated).async {
                    session.startRunning()
                }
            }
        } catch {
            print("Error setting up camera: \(error.localizedDescription)")
        }
    }
}

struct CameraViewWrapper: UIViewControllerRepresentable {
    @ObservedObject var manager: CameraRecordingManager
    
    func makeUIViewController(context: Context) -> CameraRecordingViewController {
        let controller = CameraRecordingViewController()
        controller.delegate = context.coordinator
        controller.updateOverlaySettings(
            hands: manager.showHandLines,
            body: manager.showBodyLines,
            face: manager.showFaceLines,
            handColor: UIColor(manager.handColor),
            bodyColor: UIColor(manager.bodyColor),
            faceColor: UIColor(manager.faceColor)
        )
        controller.updateAudioSettings(enabled: manager.isAudioEnabled)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: CameraRecordingViewController, context: Context) {
        
        // Update Toggles & Colors
        uiViewController.updateOverlaySettings(
            hands: manager.showHandLines,
            body: manager.showBodyLines,
            face: manager.showFaceLines,
            handColor: UIColor(manager.handColor),
            bodyColor: UIColor(manager.bodyColor),
            faceColor: UIColor(manager.faceColor)
        )
        
        uiViewController.updateAudioSettings(enabled: manager.isAudioEnabled)
        
        if manager.startRecordingTrigger {
            uiViewController.startRecording()
            DispatchQueue.main.async {
                manager.startRecordingTrigger = false
                manager.updateRecordingState(isRecording: true)
                manager.recordedVideoURL = nil
            }
        }
        
        if manager.stopRecordingTrigger {
            uiViewController.stopRecording()
            DispatchQueue.main.async {
                manager.stopRecordingTrigger = false
                manager.updateRecordingState(isRecording: false)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(manager: manager)
    }
    
    class Coordinator: NSObject, CameraControllerDelegate {
        var manager: CameraRecordingManager
        
        init(manager: CameraRecordingManager) {
            self.manager = manager
        }
        
        func didFinishRecording(url: URL) {
            let manager = self.manager
            DispatchQueue.main.async {
                manager.recordedVideoURL = url
                manager.updateRecordingState(isRecording: false)
            }
        }
        
        func didFailRecording(error: Error) {
            // Handle error
        }
    }
}
