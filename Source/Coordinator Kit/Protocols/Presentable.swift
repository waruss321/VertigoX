import Signals

public protocol Presentable: class {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    public func toPresent() -> UIViewController? {
        return self
    }
}
