//
//  TransparentBlurView.swift
//  VeScan
//
//  Created by Joaquin Wilson on 20-06-24.
//

import SwiftUI

struct TransparentBlurView: UIViewRepresentable {
    var removeAllFilters: Bool = false
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            if let backdropLayer = uiView.layer.sublayers?.first {
                if removeAllFilters {
                    backdropLayer.filters = []
                } else {
                    // Removing All Except Blur Filter
                    backdropLayer.filters?.removeAll(where: { filter in
                        String(describing: filter) == "gaussianBlur"
                    })
                }
            }
        }
    }
}
