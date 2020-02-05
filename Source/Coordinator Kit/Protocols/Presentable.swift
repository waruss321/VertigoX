import Signals
import PanModal

public protocol Presentable: class {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    public func toPresent() -> UIViewController? {
        return self
    }
}

public typealias PanModalViewController = (UIViewController & PanModalPresentable)
public typealias PanModalPresenterVC = (UIViewController & PanModalPresenter)

public protocol SheetPresentable: Presentable {
    func toSheetPresent() -> PanModalViewController?
    func toSheetPresenter() -> PanModalPresenterVC?
}

extension UIViewController: SheetPresentable {
    public func toSheetPresent() -> PanModalViewController? {
        return self as? PanModalViewController
    }
    public func toSheetPresenter() -> PanModalPresenterVC? {
        return self as PanModalPresenterVC
    }
}
