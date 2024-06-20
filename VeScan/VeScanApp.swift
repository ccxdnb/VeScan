//
//  VeScanApp.swift
//  VeScan
//
//  Created by Joaquin Wilson on 18-06-24.
//

import SwiftUI

@main
struct VeScanApp: App {
    enum NavigationRoutes{
        case onboarding, main
    }

    @State var path: NavigationRoutes = .onboarding

    var body: some Scene {
        WindowGroup {

            //TODO: Implement navigation stack with custom transition
//            NavigationStack {
//                VStack {
//
//                }.navigationDestination(for: NavigationRoutes.self) { route in
//                        switch route {
//                        case .onboarding:
//                            OnboardingView()
//                        case .main:
//                            MainScanView()
//                        }
//                    }
//
//            }
            OnboardingView()
//            MainScanView()
        }
    }
}
