import Signals

public protocol BaseModule: NSObjectProtocol, Presentable { }

public protocol BaseSheetModule: NSObjectProtocol, SheetPresentable, PanModalPresentable {
    var sheetDidDismiss: VoidSignal { get }
}


