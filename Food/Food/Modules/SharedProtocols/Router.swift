import UIKit

typealias VoidHandler = (() -> Void)

protocol RouterProtocol: AnyObject {
    var sourceViewController: UIViewController? { get set }
    var closeCompletion: VoidHandler? { get set }
    func callPhoneNumber(_ phoneNumber: String)
    func dismiss()
}

class Router: NSObject, RouterProtocol {
    weak var sourceViewController: UIViewController?
    var closeCompletion: VoidHandler?

    func showError() {
        
    }

    func callPhoneNumber(_ phoneNumber: String) {
        guard let url = URL(string: "telprompt://" + phoneNumber) else {
            return
        }
        UIApplication.shared.open(url)
    }

    func dismiss() {
        sourceViewController?.dismiss(animated: true) { [weak self] in
            self?.closeCompletion?()
        }
    }
}
