//
//  ScanViewProvider.swift
//  VeScan
//
//  Created by Joaquin Wilson on 18-06-24.
//

import VisionKit
import NaturalLanguage

final class ScanProvider: NSObject, DataScannerViewControllerDelegate, ObservableObject {
    enum ScanResult: String {
        case vegan
        case nonVegan
        case dunno

        func iconName () -> String {
            switch self {
            case .vegan:
                return "heart.fill"
            case .nonVegan:
                return "exclamationmark.circle"
            case .dunno:
                return " "
            }
        }

        func description () -> String {
            switch self {
            case .vegan:
                return "Vegan :D"
            case .nonVegan:
                return "Not Vegan ):"
            case .dunno:
                return "Thinking!"
            }
        }
    }

    @Published var scanResult: ScanResult = .dunno
    @Published var error: DataScannerViewController.ScanningUnavailable?

    func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
        switch allItems.first {
        case .text(let text):
            let detectedLanguage = detectedLanguage(for: text.transcript)
            self.scanResult = analyzeIngredientsIn(text.transcript, with: detectedLanguage)

            print("----- LANGUAGE DETECTED: \(detectedLanguage)")
            print("----- TEXT : \(text.transcript)")
            print("----- SCAN RESULT : \(self.scanResult)")
        default:
            break
        }
    }

    func analyzeIngredientsIn(_ text: String, with language: NLLanguage?) -> ScanResult {
        let nonVegan = getIngredients(language: language ?? .english)
        let ingredients = text.split(separator: " ", omittingEmptySubsequences: true)

        for ingredient in ingredients {
            if nonVegan.contains(String(ingredient).lowercased()) {
                return .nonVegan
            } else {
                return .vegan
            }
        }
        return .dunno
    }

    func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
        self.scanResult = .dunno
    }

    func detectedLanguage(for string: String) -> NLLanguage? {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(string)
        return recognizer.dominantLanguage
    }


    //TODO: Replace for Firebase Remote to control ingredients list without releasing app versions
    func getIngredients(language: NLLanguage) -> Set<String> {
        var fileName: String = ""

        switch language {
        case .english:
            fileName = "non-vegan-en"
        case .danish:
            fileName = "non-vegan-da"
        case .spanish:
            fileName = "non-vegan-es"
        default:
            fileName = "non-vegan-en"
        }

        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
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
