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
                    VStack{
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
                            .clipShape(.rect(cornerRadius: 30))
                            .frame(height: 300)
                        Text("Look for ingredients in the package")
                    }.transaction { transaction in
                        transaction.animation = nil
                    }
                    Spacer()
                    VStack {
                        Spacer()
                        ScanResultView(scanProvider: scanProvider)
                    }
                }
                .padding()
                .containerRelativeFrame([.horizontal, .vertical])
            }
            .onAppear {
                withAnimation(.spring(duration:1).repeatForever()) {
                    borderGradientColors = borderGradientColors.shuffled()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Spacer()
                        Image(systemName: "leaf.fill")
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
