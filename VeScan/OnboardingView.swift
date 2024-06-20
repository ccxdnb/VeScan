//
//  OnboardingView.swift
//  VeScan
//
//  Created by Joaquin Wilson on 20-06-24.
//

import SwiftUI

struct OnboardingView: View {
    @State var isVisible: Bool = false
    @State var subOpacity: CGFloat = 0.0

    @State private var isShowingDetailView = false

    var onboardingCompleted: () -> Void = {}

    var body: some View {
        NavigationView {
            ZStack {
                Image("onboarding-bg")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)


                VStack(spacing: 15) {
                    if isVisible {
                        Spacer()
                        VStack(spacing: 30) {
                            HStack {
                                BouncingText(
                                    text: "Welcome to VeScan!",
                                    style: BouncingText.BouncingTextStyle(
                                        font: .largeTitle,
                                        color: .white,
                                        offsetYForBounce: -50,
                                        dropSpeed: 0.1,
                                        opacity: 0)
                                )
                                Spacer()
                            }
                            HStack {
                                Text("Our app lets you effortlessly scan product ingredients to determine if they're vegan. Designed to simplify your vegan lifestyle.\r\n\nVeScan provides instant, accurate results, helping you make informed choices with ease.\r\nStart scanning and stay vegan-friendly!.")
                                    .font(.subheadline)
                                .opacity(subOpacity)
                                Spacer()
                            }


                            Text("If you downloaded this app it means you are in a path to saving quite a lot of animals.")
                                .multilineTextAlignment(.leading)
                                .font(.subheadline)
                                .opacity(subOpacity)

                            Text("Thank you!")
                                .font(.title3)
                                .fontWeight(.bold)
                                .opacity(subOpacity)
                        }
                        .padding(.horizontal, 15)
                        .padding(.top, 25)
                        .padding(.bottom, 25)
                        .background{
                            TransparentBlurView(removeAllFilters: true)
                                .blur(radius: 9)
                                .background(.white.opacity(isVisible ? 0.15 : 0))

                        }.clipShape(RoundedRectangle(cornerRadius: 25.0))

                        Spacer()

                    }

                    NavigationLink(destination: MainScanView().transition(.opacity), isActive: $isShowingDetailView) { EmptyView() }

                    Button {
                        withAnimation(.easeInOut.delay(isVisible ? 0.5 : 0)) {
                            isVisible.toggle()
                        }
                        withAnimation(.easeInOut.delay(1.8)) {
                            subOpacity = isVisible ? 1 : 0
                        }

                        if !isVisible {
                            isShowingDetailView = true
                            onboardingCompleted()
                        }

                    } label: {
                        Text(isVisible ? "Let's go!" : "Welcome Buddy")
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundColor(Color.purplePrimary)
                    .tint(Color.white)
                    .controlSize(.extraLarge)
                    .opacity(0.8)
                }.padding(.horizontal, 30)
            }
        }
    }
}

//struct Transparent

#Preview {
    OnboardingView()
}
