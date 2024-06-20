//
//  VeScanApp.swift
//  VeScan
//
//  Created by Joaquin Wilson on 18-06-24.
//

import SwiftUI

@main
struct VeScanApp: App {
    @AppStorage("FirstStart") var shouldShowOnboarding = true

    var body: some Scene {
        WindowGroup {
            if shouldShowOnboarding {
                OnboardingView() {
                    shouldShowOnboarding = false
                }
            } else {
                MainScanView()
            }
        }
    }
}
