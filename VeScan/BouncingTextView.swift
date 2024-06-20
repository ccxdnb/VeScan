//
//  BouncingTextView.swift
//  VeScan
//
//  Created by Joaquin Wilson on 20-06-24.
//

import SwiftUI


struct BouncingText: View {
    // MARK: - Nested Types
    struct BouncingTextStyle {

        var font: Font
        var color: Color
        var offsetYForBounce: CGFloat
        var dropSpeed: Double
        var opacity: CGFloat
    }

    // MARK: - Stored Properties
    private var characters: Array<String.Element>

    // MARK: - Wrapped Properties
    @State private var style: BouncingTextStyle

    init(text: String, style: BouncingTextStyle) {
        self.characters = Array(text)
        self.style = style
    }

    var body: some View {
        HStack(spacing:0) {
            ForEach(0..<characters.count) { num in
                Text(String(characters[num]))
                    .font(style.font)
                    .foregroundColor(style.color)
                    .offset(x: 0.0, y: style.offsetYForBounce)
                    .opacity(style.opacity)
                    .animation(
                        .spring(
                            response: 0.2,
                            dampingFraction: 0.5,
                            blendDuration: 0.1)
                        .delay(Double(num) * style.dropSpeed), value: style.offsetYForBounce)
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    style.opacity = 1
                    style.offsetYForBounce = 0
                }
            }
        }
    }
}
