//
//  GradientShape.swift
//  VeScan
//
//  Created by Joaquin Wilson on 20-06-24.
//

import SwiftUI


struct GradientShape: View {
    enum GradientShape {
        case first, second, third
    }
    @State var selectedShape: GradientShape = .first
    @State var colors: [Color] = [Color.purpleDark, .clear]

    var body: some View {
        switch selectedShape {
        case .first:
            FirstShape()
                .frame(width: 150, height: 150)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: colors),
                                                startPoint: .topLeading,
                                                endPoint: .bottomLeading))
                .mask(LinearGradient(gradient: Gradient(colors: colors),
                                     startPoint: .topLeading,
                                     endPoint: .bottomLeading))

        case .second:
            SecondShape()
                .frame(width: 150, height: 150)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: colors),
                                                startPoint: .topLeading,
                                                endPoint: .bottomLeading))
                .mask(LinearGradient(gradient: Gradient(colors: colors),
                                     startPoint: .topLeading,
                                     endPoint: .bottomLeading))

        case .third:
            ThirdShape()
                .frame(width: 150, height: 150)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: colors),
                                                startPoint: .topTrailing,
                                                endPoint: .bottomLeading))
                .mask(LinearGradient(gradient: Gradient(colors: colors),
                                     startPoint: .topLeading,
                                     endPoint: .bottomLeading))
        }
    }
}

struct FirstShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.99853*width, y: 0.55347*height))
        path.addCurve(to: CGPoint(x: 0.44231*width, y: 0.99734*height), control1: CGPoint(x: 0.82258*width, y: 0.79335*height), control2: CGPoint(x: 0.67252*width, y: 0.6722*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.43931*height), control1: CGPoint(x: 0.14809*width, y: 0.83526*height), control2: CGPoint(x: 0, y: 0.737*height))
        path.addCurve(to: CGPoint(x: 0.44231*width, y: 0.00233*height), control1: CGPoint(x: 0, y: 0.14162*height), control2: CGPoint(x: 0.10544*width, y: 0.00233*height))
        path.addCurve(to: CGPoint(x: 0.99853*width, y: 0.55347*height), control1: CGPoint(x: 0.77919*width, y: 0.00233*height), control2: CGPoint(x: 0.99853*width, y: 0.25578*height))
        path.closeSubpath()
        return path
    }
}

struct SecondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.65217*width, y: 0.42295*height))
        path.addCurve(to: CGPoint(x: 0.83251*width, y: 0.99762*height), control1: CGPoint(x: 0.83816*width, y: 0.68033*height), control2: CGPoint(x: 1.21174*width, y: 0.62877*height))
        path.addCurve(to: CGPoint(x: 0.10387*width, y: 0.36457*height), control1: CGPoint(x: 0.34783*width, y: 0.81375*height), control2: CGPoint(x: 0.10387*width, y: 0.70228*height))
        path.addCurve(to: CGPoint(x: 0.32126*width, y: 0.00164*height), control1: CGPoint(x: 0.10387*width, y: 0.02686*height), control2: CGPoint(x: -0.2337*width, y: 0.00164*height))
        path.addCurve(to: CGPoint(x: 0.65217*width, y: 0.42295*height), control1: CGPoint(x: 0.40904*width, y: 0.1918*height), control2: CGPoint(x: 0.43657*width, y: 0.12459*height))
        path.closeSubpath()
        return path
    }
}

struct ThirdShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: width, y: 0.76485*height))
        path.addCurve(to: CGPoint(x: 0.52933*width, y: 0.62297*height), control1: CGPoint(x: width, y: 1.10962*height), control2: CGPoint(x: 0.85111*width, y: 0.62297*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.89372*height), control1: CGPoint(x: 0.20755*width, y: 0.62297*height), control2: CGPoint(x: 0, y: 1.23849*height))
        path.addCurve(to: CGPoint(x: 0.55742*width, y: 0), control1: CGPoint(x: 0, y: 0.54895*height), control2: CGPoint(x: 0.23564*width, y: 0))
        path.addCurve(to: CGPoint(x: width, y: 0.76485*height), control1: CGPoint(x: 0.8792*width, y: 0), control2: CGPoint(x: width, y: 0.42008*height))
        path.closeSubpath()
        return path
    }
}

#Preview {
    GradientShape()
}
