import Signals

public protocol BaseModule: NSObjectProtocol, Presentable { }

public protocol BaseSheetModule: NSObjectProtocol, SheetPresentable {
    var sheetDidDismiss: VoidSignal { get }
}

