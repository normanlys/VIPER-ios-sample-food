import UIKit

protocol AnyView: AnyObject {
    var view: UIView { get }
}

extension AnyView where Self: UIView {
    var view: UIView { return self }
}
