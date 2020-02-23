import Signals

public protocol DeepLinkType { }

public protocol Coordinator: Presentable {
    func start()
    func start(with option: DeepLinkType?)
    func addDependency(_ coordinator: Coordinator)
    func removeAllDependencies()
    func removeDependency(_ coordinator: Coordinator?)
    
    var router: Router { get }
}

public enum CoordinatorOutputResult {
    case normal
    case cancelled
    case error
}

public protocol CoordinatorOutput: class {
    var finishFlow: Signal<CoordinatorOutputResult> { get }
}

public protocol CoordinatorLoadingDeferrable: class {
    var onCoordinatorFinishedLoading: Signal<ActionResult> { get }
}
