//
//  ScanResultView.swift
//  VeScan
//
//  Created by Joaquin Wilson on 19-06-24.
//

import SwiftUI

struct ScanResultView: View {
    @StateObject var scanProvider: ScanProvider

    @State var resultIconName: String = ""

    @State var animate: Bool = false

    var body: some View {
        VStack {
//            switch scanProvider.scanResult {
//            case .vegan:
//                GalaxyView()
//            case .nonVegan:
//                Text("")
//
//            default:
//                GalaxyView()
//            }
            ParticleEmitterView()


            Text(scanProvider.scanResult.description())
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.bold)

        }.padding(.horizontal, 15)
            .padding(.top, 25)
            .padding(.bottom, 25)
            .background{
                TransparentBlurView(removeAllFilters: true)
                    .blur(radius: 9)
                    .background(.white.opacity(0.15))
            }.clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

    import UIKit

struct ParticleEmitterView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let emitterLayer = CAEmitterLayer()

        emitterLayer.emitterShape = .line
        emitterLayer.emitterPosition = CGPoint(x: (UIScreen.main.bounds.width / 2) + 30, y: 0)
        emitterLayer.emitterSize = CGSize(width: UIScreen.main.bounds.width - 30, height: 100)

        let emitterCell = CAEmitterCell()
        let image = UIImage(systemName: "sun.min")?.withTintColor(.white)

        emitterCell.contents = image?.cgImage
        emitterCell.birthRate = 10
        emitterCell.lifetime = 5
        emitterCell.velocity = -100
        emitterCell.velocityRange = 50
        emitterCell.yAcceleration = 30
        emitterCell.scale = 0.05
        emitterCell.scaleRange = 0.3
        emitterCell.color = UIColor.red.cgColor
        emitterCell.alphaSpeed = -0.7

        emitterLayer.emitterCells = [emitterCell]

        view.layer.addSublayer(emitterLayer)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    ScanResultView(scanProvider: .init())
}
