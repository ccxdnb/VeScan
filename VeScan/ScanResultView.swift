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

    var body: some View {
        VStack {
            Image(systemName: scanProvider.scanResult.iconName())
                .font(.system(size: 200))
                .scaledToFill()
                .foregroundStyle(Color.purplePrimary)

            Text(scanProvider.scanResult.description())
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.bold)

        }
    }
}

#Preview {
    ScanResultView(scanProvider: .init())
}
