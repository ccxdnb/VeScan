//
//  ScanViewProvider.swift
//  VeScan
//
//  Created by Joaquin Wilson on 18-06-24.
//

import VisionKit

enum ScanResult: String {
    case vegan
    case nonVegan
    case dunno
}

final class ScanProvider: NSObject, DataScannerViewControllerDelegate, ObservableObject {

    @Published var scanResult: ScanResult = .dunno
    @Published var error: DataScannerViewController.ScanningUnavailable?

    func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
        let nonVegan = getIngredients()

        switch item {
        case .text(let text):
            let textSplit = text.transcript.split(separator: " ", omittingEmptySubsequences: true)

            for ingredient in textSplit {
                if nonVegan.contains(String(ingredient).lowercased()) {
                    scanResult = .nonVegan
                    break
                } else {
                    scanResult = .vegan
                }
            }

        default:
            fatalError()
        }

    }

    func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {

    }

    func getIngredients() -> Set<String> {
        if let path = Bundle.main.path(forResource: "nonvegan", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as? Array<String> {
                    return Set(jsonResult)
                  }
              } catch {
                   // handle error
              }
        }
        return []
    }
}
