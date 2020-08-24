//
//  QRScannerViewController.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 07/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
/// Delegate protocol for QRScannerViewController
protocol QRScannerViewControllerDelegate {
    func qrScanner(_ viewController: QRScannerViewController, didScanQRCodeWithText text: String)
    func qrScanner(_ viewController: QRScannerViewController, didFailedWithError error: QRScannerViewControllerError)
}
// MARK: -
/// QRScannerViewController error types
enum QRScannerViewControllerError {
    case noCamera
    case other
}
// MARK: -
/// View Controller that scans QR codes from the camera, and shows the camera feed.
class QRScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    // Camera recording and QR scanning properties
    private var captureSession = AVCaptureSession()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var captureMetadataOutput: AVCaptureMetadataOutput!
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.qr]
    // Delegate
    var delegate: QRScannerViewControllerDelegate?
    // MARK: - Callbacks
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addPreviewLayer()
    }
    // MARK: - Capturing methods
    private func setUp() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("ERROR: Failed to get the camera device")
            delegate?.qrScanner(self, didFailedWithError: .noCamera)
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
        } catch {
            print("ERROR: \(error)")
            delegate?.qrScanner(self, didFailedWithError: .other)
            return
        }
    }
    private func addPreviewLayer() {
        if videoPreviewLayer == nil {
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            guard let videoPreviewLayer = videoPreviewLayer else { return }
            videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer.frame = view.layer.frame
            view.layer.addSublayer(videoPreviewLayer)
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        videoPreviewLayer?.frame = view.layer.frame
    }
    func stopCapturing(){
        captureSession.stopRunning()
    }
    func startCapturing(){
        captureSession.startRunning()
    }
    // MARK: - Capturing methods
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard !metadataObjects.isEmpty,
            let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
            supportedCodeTypes.contains(metadataObject.type)
            else {
                return
        }
        if let stringCode = metadataObject.stringValue {
            delegate?.qrScanner(self, didScanQRCodeWithText: stringCode)
        }
    }
}
