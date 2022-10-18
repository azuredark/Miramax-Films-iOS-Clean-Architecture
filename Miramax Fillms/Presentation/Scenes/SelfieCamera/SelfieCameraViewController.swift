//
//  SelfieCameraViewController.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 16/10/2022.
//

import UIKit
import SnapKit
import SwifterSwift
import RxCocoa
import RxSwift
import AVFoundation
import Kingfisher
import Domain

enum CameraDevice {
    case back, front
}

class SelfieCameraViewController: BaseViewController<SelfieCameraViewModel> {
    
    // MARK: - Outlets + Views
    
    @IBOutlet weak var previewView: UIView!
    
    @IBOutlet weak var frameImageView: UIImageView!
    @IBOutlet weak var frameImageViewHc: NSLayoutConstraint!
    
    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var canvasImageView: UIImageView!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSwitchCamera: UIButton!
    @IBOutlet weak var btnFlash: UIButton!
    @IBOutlet weak var btnMoreOption: UIButton!
    
    @IBOutlet weak var btnCapture: UIButton!
    @IBOutlet weak var btnFrameLayer: UIView!

    var noPermissionView: UIView!
    
    // MARK: - Properties
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    var currentCameraDevice: CameraDevice = .back
    var isConfiguringCamera: Bool = false {
        didSet {
            updateCameraViewsState(isEnable: !isConfiguringCamera)
        }
    }
    
    private var isViewAppear: Bool = false
    
    let selectMovieImageTriggerS = PublishRelay<Void>()
    
    // MARK: - Lifecycle

    override func configView() {
        super.configView()
        
        configureViews()
        setupLivePreview()
        updateCameraViewsState(isEnable: false)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = SelfieCameraViewModel.Input(
            popViewTrigger: btnBack.rx.tap.asDriver(),
            selectMovieImageTrigger: selectMovieImageTriggerS.asDriverOnErrorJustComplete()
        )
        let output = viewModel.transform(input: input)
        
        output.selfieFrame
            .drive(onNext: { [weak self] item in
                guard let self = self else { return }
                self.setFrameImage(with: item)
            })
            .disposed(by: rx.disposeBag)
        
        output.movieImage
            .drive(onNext: { [weak self] item in
                guard let self = self else { return }
                self.setMovieImage(with: item)
            })
            .disposed(by: rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isViewAppear {
            checkCameraPermission {
                self.setupCamera()
                self.isViewAppear = true
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        videoPreviewLayer.frame = previewView.bounds
    }
}

// MARK: - Private functions

extension SelfieCameraViewController {
    private func configureViews() {
        btnCapture.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.snapPhoto()
            })
            .disposed(by: rx.disposeBag)
        
        btnFlash.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.toggleFlash()
            })
            .disposed(by: rx.disposeBag)
        
        btnSwitchCamera.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.switchCameraDevice()
            })
            .disposed(by: rx.disposeBag)
        
//        btnGallery.rx.tap
//            .subscribe(onNext: { [weak self] in
//                guard let self = self else { return }
//                self.presentImagePickerController()
//            })
//            .disposed(by: rx.disposeBag)
        
        btnFrameLayer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onButtonFrameLayerTapped(_:))))
    }
    
    private func presentImagePickerController() {
//        let vc = UIImagePickerController()
//        vc.sourceType = .photoLibrary
//        vc.delegate = self
//        present(vc, animated: true)
    }
    
    @objc private func onButtonFrameLayerTapped(_ sender: UITapGestureRecognizer) {
        
    }
}
