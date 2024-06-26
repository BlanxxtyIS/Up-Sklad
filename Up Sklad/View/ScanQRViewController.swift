//
//  FourProduct.swift
//  Up Sklad
//
//  Created by Марат Хасанов on 30.04.2024.
//

import UIKit
import AVFoundation

class ScanQRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    private lazy var cameraView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var addQRInfoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Возобновить", for: .normal)
        button.addTarget(self, action: #selector(saveQrCodeInfo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialized
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        title = "Сканер"
        
        setupUI()
        //настройка сессии захвата
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr] // Настройте на другие типы, если нужно
        } else {
            failed()
            return
        }
        
        // Настройка слоя предварительного просмотра
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.masksToBounds = true
        cameraView.layer.addSublayer(previewLayer)
    
        // Запуск сессии захвата
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = cameraView.bounds
    }
    
    @objc
    private func saveQrCodeInfo() {
        print("Добавить добавить")
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.restartScanning()
        }
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    private func setupUI() {
        view.addSubview(cameraView)
        view.addSubview(addQRInfoButton)
        NSLayoutConstraint.activate([
            cameraView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            cameraView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            cameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addQRInfoButton.topAnchor.constraint(equalTo: cameraView.bottomAnchor, constant: 30),
            addQRInfoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addQRInfoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Проверяем, не запущена ли уже сессия
        if captureSession?.isRunning == false {
            // Запускаем сессию в фоновом потоке
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.captureSession.startRunning()
            }
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Останавливаем сессию в фоновом потоке
        if captureSession?.isRunning == true {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.captureSession.stopRunning()
            }
        }
    }
    
    // Обработка результатов сканирования
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            guard let stringValue = metadataObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            
            // Остановить сессию захвата
            DispatchQueue.main.async { [weak self] in
                self?.captureSession.stopRunning()
            }
            
            // Опционально: обновить UI или перейти на другой экран
            DispatchQueue.main.async { [weak self] in
                self?.showCodeDetails(code: stringValue)
            }
        }
    }
    
    func showCodeDetails(code: String) {
        // Отображение деталей кода, например, в UIAlertController или переход на другой UIViewController
        let alert = UIAlertController(title: "Информация", message: code, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Редактировать", style: .default, handler: { alert in
            self.present(CreateProductViewController(), animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Сохранить", style: .default))
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel))
        present(alert, animated: true, completion: nil)
    }
    
    func restartScanning() {
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
    func found(code: String) {
        print("Найден QR код: \(code)")
        // Здесь можно добавить логику обработки найденного QR кода
    }
    
    // Проверка разрешений на использование камеры
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
