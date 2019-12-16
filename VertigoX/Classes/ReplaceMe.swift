
import Signals
import UIKit

open class TestVC: UIViewController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public let fireme = Signal<Void>()
    
    open override func viewDidLoad() {
        view.backgroundColor = .cyan
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        fireme.fire(())
    }
    
}
