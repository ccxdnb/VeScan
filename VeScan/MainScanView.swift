//
//  MainScanView.swift
//  VeScan
//
//  Created by Joaquin Wilson on 18-06-24.
//

import SwiftUI
import VisionKit

struct MainScanView: View {
    @StateObject var scanProvider: ScanProvider = .init()

    @State var rotation: CGFloat = 0.0
    @State var borderGradientColors: [Color] = [
        Color.mint, Color.purplePrimary, Color.indigo, Color.mint
    ]
    @State var resultOverlayColor: Color = .clear
    @State var shouldDisplayOverlay: Bool = false


    // Size of the view
    let size: CGFloat = 230
    var body: some View {
        NavigationView{
            ZStack{
                backgroundOverlay
                VStack {
                    ScanViewWrapper(scanProvider: scanProvider)
                        .clipShape(.rect(cornerRadius: 30))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(
                                    LinearGradient( // main border gradient
                                        gradient: Gradient(colors: borderGradientColors),
                                        startPoint: .topLeading,
                                        endPoint: .bottomLeading), lineWidth: 3)
                                .blur(radius: 1)
                                .mask(
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(LinearGradient(
                                            gradient: Gradient(colors: [.white, .clear]),
                                            startPoint: .center,
                                            endPoint: .topLeading
                                        ))
                                        .fill(LinearGradient(
                                            gradient: Gradient(colors: [.white, .clear]),
                                            startPoint: .center,
                                            endPoint: .bottomTrailing
                                        ))
                                )
                        )
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                        .clipShape(.rect(cornerRadius: 30))
                        .frame(height: 300)
                    Text("Look for ingredients in the package")

                    VStack {
                        ScanResultView(scanProvider: scanProvider)
                    }

                    Spacer()
                }
                .padding()
                .containerRelativeFrame([.horizontal, .vertical])
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Spacer()
                        Image(systemName: "leaf.fill") // Replace with your logo image
                            .resizable()
                            .frame(width: 40, height: 40)

                        Text("VeScan")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
            }.transition(.opacity)
        }.navigationBarBackButtonHidden(true)
        .onAppear {
            withAnimation(.spring(duration:1.3).repeatForever()) {
                //OVERLAY ANIMATION
                borderGradientColors = borderGradientColors.shuffled()

            }
        }
    }

    var backgroundOverlay: some View {
        Image("mainscan-bg")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    MainScanView()
}
