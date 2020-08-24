//
//  SearchHomeViewController.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 06/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class SearchHomeViewController: UIViewController, ViewControllerWithLoadingOverlay, QRScannerViewControllerDelegate {
    
    @IBOutlet private var lotNumberTextField: UITextField?
    @IBOutlet private var mainView: UIView?
    @IBOutlet private var inputWrapperView: UIView?
    @IBOutlet private var cornerView: CornerView?
    @IBOutlet private var scanQRButton: UIButton?
    @IBOutlet private var searchButton: UIButton?
    @IBOutlet private var circleView: UIView?
    @IBOutlet private var scannerView: UIView?
    @IBOutlet private var barScannerView: UIImageView?
    private let scannerViewController = QRScannerViewController()
    var loadingOverlay: LoadingOverlay = LoadingOverlay()
    var presenter: SearchHomePresenterProtocol?
    var lot: Lot?
    
    @IBAction private func searchButtonTapped() {
        showLoadingOverlay()
        presenter?.searchLotByIdentifier(identifier: lotNumberTextField?.text ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scannerViewController.delegate = self
        setupUI()
        setupScanner()
        setupMaskCircleView()
        scanQRButton?.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(becameActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scannerViewController.startCapturing()
        setupBarScannerAnimation()
    }
    
    @objc private func becameActive() {
        setupBarScannerAnimation()
    }
    
    private func setupBarScannerAnimation() {
        let width = self.barScannerView?.frame.width ?? 0
        let height = self.barScannerView?.frame.height ?? 0
        let xPosition = self.barScannerView?.frame.minX ?? 0
        self.barScannerView?.frame = CGRect(x: xPosition, y: 0, width: width, height: height)
        UIImageView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            let width = self.barScannerView?.frame.width ?? 0
            let height = self.barScannerView?.frame.height ?? 0
            let xPosition = self.barScannerView?.frame.minX ?? 0
            self.barScannerView?.frame = CGRect(x: xPosition, y: 160, width: width, height: height)
        }, completion: nil)
    }
    
    private func setupScanner() {
        guard let scannerView = scannerView else { return }
        scannerView.layer.cornerRadius = scannerView.frame.size.width / 2
        scannerView.clipsToBounds = true
        self.addChild(viewController: scannerViewController, in: scannerView)
    }
    
    private func setupMaskCircleView() {
        if let circleView = circleView {
            circleView.backgroundColor = .clear
            let view = UIView(frame: CGRect(x: 0, y: 0, width: circleView.frame.width, height: circleView.frame.height))
            view.layer.cornerRadius = view.frame.size.width / 2
            view.clipsToBounds = true
            view.backgroundColor = .white
            circleView.addSubview(view)
            
            let maskLayer = CAShapeLayer()
            maskLayer.frame = circleView.bounds
//            // Create the frame for the circle.
            let radius: CGFloat = circleView.frame.width
//            // Rectangle in which circle will be drawn
            let rect = CGRect(x: 0, y: 0, width: radius, height: radius)
            let circlePath = UIBezierPath(ovalIn: rect)
//            // Create a path
            let path = UIBezierPath(rect: circleView.bounds)
//            // Append additional path which will create a circle
            path.append(circlePath)
//            // Setup the fill rule to EvenOdd to properly mask the specified area and make a crater
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
//            // Append the circle to the path so that it is subtracted.
            maskLayer.path = path.cgPath
//            // Mask our view with Blue background so that portion of red background is visible
            view.layer.mask = maskLayer
        }
    }
    
    private func setupUI() {
        // MARK: - View with only corners
        cornerView?.lineColor = UIColor.accentColor100
        cornerView?.sizeMultiplier = 0.09
        cornerView?.lineWidth = 3
        
        // MARK: - Main card
        mainView?.layer.shadowColor = UIColor.black.cgColor
        mainView?.layer.shadowOpacity = 0.10
        mainView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView?.layer.shadowRadius = 15
        
        // MARK: - Input card
        inputWrapperView?.layer.shadowColor = UIColor.black.cgColor
        inputWrapperView?.layer.shadowOpacity = 0.10
        inputWrapperView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        inputWrapperView?.layer.shadowRadius = 15
    }
    
    func qrScanner(_ viewController: QRScannerViewController, didScanQRCodeWithText text: String) {
        viewController.stopCapturing()
        showLoadingOverlay()
        presenter?.searchLotByIdentifier(identifier: text)
    }
    
    func qrScanner(_ viewController: QRScannerViewController, didFailedWithError error: QRScannerViewControllerError) {
        showError(message: "Error al leer el código QR, intente nuevamente")
    }
}

extension SearchHomeViewController: SearchHomeViewProtocol {
    
    func showError(message: String?) {
        hideLoadingOverlay()
        displayError(message)
    }
    
    func redirectOnSuccess(lot: Lot) {
        hideLoadingOverlay()
        self.lot = lot
        presenter?.goToLotDetail()
    }
    
    func navigateToLotDetail(lotId: Int) {
        let vc = LotDetailWireframe.getViewController(lotId: lotId)
        navigationController?.pushViewController(vc, animated: true)
    }
}
