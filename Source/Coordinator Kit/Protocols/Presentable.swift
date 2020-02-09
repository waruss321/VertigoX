import Signals

public protocol Presentable: class {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    public func toPresent() -> UIViewController? {
        return self
    }
}

public typealias PanModalViewController = (UIViewController & PanModalPresentable)

public protocol SheetPresentable: Presentable {
    func toSheetPresent() -> PanModalViewController?
}

extension UIViewController: SheetPresentable {
    public func toSheetPresent() -> PanModalViewController? {
        return self as? PanModalViewController
    }
}
