//
//  ContentView.swift
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
        Color.red, Color.orange, Color.yellow, Color.green, Color.blue, Color.purple
    ]
    @State var resultOverlayColor: Color = .clear
    @State var shouldDisplayOverlay: Bool = false
    @State var startPointOverlay: UnitPoint = .center
    @State var endPointOverlay: UnitPoint = .bottomTrailing
    @State var startPositionArray: [UnitPoint] = [
        .topLeading,
        .top,
        .topTrailing,
        .trailing,
        .bottomTrailing,
        .bottom,
        .bottomLeading,
        .leading,
    ]
    @State var endPositionArray: [UnitPoint] = [
        .bottomTrailing,
        .bottom,
        .bottomLeading,
        .leading,
        .topLeading,
        .top,
        .topTrailing,
        .trailing,
    ]

    // Size of the view
    let size: CGFloat = 230
    var body: some View {
        NavigationView{
            ZStack{
                VStack {
                    ScanViewWrapper(scanProvider: scanProvider)
                        .clipShape(.rect(cornerRadius: 30))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(
                                    LinearGradient( // main border gradient
                                        gradient: Gradient(colors: [Color.mint, Color.purplePrimary, Color.indigo, Color.mint]),
                                        startPoint: startPointOverlay,
                                        endPoint: endPointOverlay), lineWidth: 3)
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
                .background(backgroundOverlay)
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
            }
        }
        .onAppear {
            withAnimation(.spring(duration: 2).repeatForever()) {
                //OVERLAY ANIMATION
                startPositionArray = startPositionArray.rotateLeftByOne()
                endPositionArray = endPositionArray.rotateLeftByOne()
                startPointOverlay = startPositionArray.first!
                endPointOverlay = endPositionArray.first!

            }
        }
    }

    var backgroundOverlay: some View {
        RoundedRectangle(cornerRadius: size / 5)
            .fill(LinearGradient(colors: [Color.purpleSecondary, Color.purpleDark, Color.background.opacity(0.3)],
                                 startPoint: .top,
                                 endPoint: .bottomTrailing)
            )
            .overlay(
                RoundedRectangle(cornerRadius: size / 5)
                    .stroke(
                        LinearGradient( // main border gradient
                            gradient: Gradient(colors:
                                [Color.green.opacity(shouldDisplayOverlay ? 1 : 0)]
                            ),
                            startPoint: .top,
                            endPoint: .bottom), lineWidth: 5)
                    .blur(radius: 3)
                    .mask(
                        RoundedRectangle(cornerRadius: size / 5)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [.black, .clear]),
                                startPoint: .center,
                                endPoint: .topLeading
                            ))
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [.black, .clear]),
                                startPoint: .center,
                                endPoint: .bottomTrailing
                            ))
                    )
            ).ignoresSafeArea()
    }
}

#Preview {
    MainScanView()
}
