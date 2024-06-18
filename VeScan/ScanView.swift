//
//  ScanView.swift
//  VeScan
//
//  Created by Joaquin Wilson on 18-06-24.
//

import SwiftUI
import VisionKit

struct ScanView: UIViewControllerRepresentable {
    @ObservedObject var scanProvider: ScanProvider

    func makeUIViewController(context: Context) -> DataScannerViewController {
        let vc: DataScannerViewController = .init(recognizedDataTypes: [.text()],qualityLevel: .fast, isHighlightingEnabled: true)
        vc.delegate = scanProvider
        try? vc.startScanning()
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
}
