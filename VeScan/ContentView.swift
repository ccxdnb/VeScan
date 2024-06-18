//
//  ContentView.swift
//  VeScan
//
//  Created by Joaquin Wilson on 18-06-24.
//

import SwiftUI
import VisionKit

struct ContentView: View {
    @StateObject var scanProvider: ScanProvider = .init()

    var body: some View {
        VStack {
            ScanView(scanProvider: scanProvider )
                .padding(EdgeInsets())
                .clipShape(.rect(cornerRadius: 30))
                .frame(height: 300)

            VStack {
                Text(scanProvider.scanResult.rawValue)
                    .foregroundColor(.white)
                    .fontWeight(.bold)


                switch scanProvider.scanResult {
                case .vegan:
                    Image(systemName: "leaf")
                        .foregroundColor(.mint)

                default:
                    Spacer()
                }


            }

            Spacer()

        }
        .padding()
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Gradient(colors: [.indigo, .black, .black]))
    }
}

#Preview {
    ContentView()
}
