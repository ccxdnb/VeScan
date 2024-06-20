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
            ZStack {
                ZStack {
                    Circle()
                        .frame(width: 200, height: 200)
                        .foregroundColor(Color.background.opacity(0.3))
                }

                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(Color.white.opacity(0.8))
                    .scaleEffect(0.3)
                    .blur(radius: 10)

                GradientShape(selectedShape: .first, colors: [.green, .clear])
                    .rotation3DEffect(
                        .degrees(75),
                        axis: (x: 1.0, y: 0, z: animate ? -35 : 45)
                    )
                    .blendMode(.multiply)

                GradientShape(selectedShape: .first, colors: [.pink, .clear])
                    .rotationEffect(.degrees(animate ? 0 : 360))
                    .blendMode(.multiply)

                GradientShape(selectedShape: .first, colors: [.mint, .clear])
                    .rotationEffect(.degrees(!animate ? 0 : 360))
                    .blendMode(.multiply)


                GradientShape(selectedShape: .third, colors: [.green, .clear])
                    .rotation3DEffect(
                        .degrees(75),
                        axis: (x: 1.0, y: 0, z: animate ? -5 : 15)
                    )
                    .blendMode(.colorBurn)


                GradientShape(selectedShape: .second, colors: [.indigo, .clear])
                    .rotation3DEffect(
                        .degrees(75),
                        axis: (x: 1.0, y: 0, z: animate ? -10 : 35)
                    )
                    .blendMode(.multiply)

            }.frame(maxHeight: 400)
                .blur(radius: 15)

            Text(scanProvider.scanResult.description())
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal, 15)
                    .padding(.top, 25)
                    .padding(.bottom, 25)
                .background{
                    TransparentBlurView(removeAllFilters: true)
                        .blur(radius: 9)
                        .background(.white.opacity(0.15))
                }.clipShape(RoundedRectangle(cornerRadius: 25.0))

        }
            .onAppear {
                withAnimation(.easeInOut(duration: 5).repeatForever()) {
                    animate.toggle()
                }
            }
    }
}

#Preview {
    ScanResultView(scanProvider: .init())
}
