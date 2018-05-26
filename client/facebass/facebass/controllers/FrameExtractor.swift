//
//  FrameExtractor.swift
//  facebass
//
//  Created by Radu Petrisel on 26/05/2018.
//  Copyright © 2018 Radu Petrisel. All rights reserved.
//

import AVFoundation
import UIKit

protocol FrameExtractorDelegate: class {
    func captured(image: UIImage)
}

class FrameExtractor: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {

    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "session queue")
    private var permissionGranted = false
    private let position = AVCaptureDevice.Position.back
    private let quality = AVCaptureSession.Preset.medium
    private let context = CIContext()
    
    weak var delegate: FrameExtractorDelegate?
    
    override init(){
        super.init()
        
        checkPermission()
        sessionQueue.async {
            [unowned self] in
            self.configureSession()
            self.captureSession.startRunning()
        }
        
    }
    
    private func checkPermission(){
        
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video){
            
        case .authorized:
            permissionGranted = true
            
        case .notDetermined:
            requestPermission()
            
        default:
            permissionGranted = false
        }
    }
    
    private func requestPermission(){
        
        sessionQueue.suspend()
        AVCaptureDevice.requestAccess(for: AVMediaType.video){ [unowned self] granted in
            
            self.permissionGranted = granted
            self.sessionQueue.resume()
        }
    }
    
    private func configureSession(){
        
        guard permissionGranted else {
            print("permission error")
            return }
        captureSession.sessionPreset = quality
        
        guard let captureDevice = selectCaptureDevice() else {
            print("capture device error")
            return }
        guard let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice) else {
            print("capture device input error")
            return }
        guard captureSession.canAddInput(captureDeviceInput) else {
            print("capture session add input error")
            return }
        captureSession.addInput(captureDeviceInput)
        
        let videoOutput = AVCaptureVideoDataOutput()
        
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer"))
        
        guard captureSession.canAddOutput(videoOutput) else {
            print("capture session add output error")
            return }
        
        captureSession.addOutput(videoOutput)
        
        guard let connection = videoOutput.connection(with: AVMediaType.video) else { return }
        guard connection.isVideoOrientationSupported else { return }
        connection.videoOrientation = .portrait
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let uiImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }
        
        DispatchQueue.main.async {
            [unowned self] in
            self.delegate?.captured(image: uiImage)
        }
    }
    
    
    private func selectCaptureDevice() -> AVCaptureDevice?{
        return AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back)
    }
    
    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return nil}
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)

        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil}
        return UIImage(cgImage: cgImage)
    }
    
}
