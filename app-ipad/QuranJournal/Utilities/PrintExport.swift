import SwiftUI
import UIKit

/// Lance l'impression AirPrint du HTML fourni quand `trigger` passe à true.
struct PrintController: UIViewControllerRepresentable {
    let html: String
    @Binding var trigger: Bool

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ viewController: UIViewController, context: Context) {
        guard trigger else { return }
        trigger = false
        let formatter = UIMarkupTextPrintFormatter(markupText: html)
        formatter.perPageTextInsets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        let controller = UIPrintInteractionController.shared
        controller.printFormatter = formatter
        controller.present(animated: true, completionHandler: nil)
    }
}
