import SwiftUI

struct VolumeControl: WKInterfaceObjectRepresentable {
	func makeWKInterfaceObject(context: Self.Context) -> WKInterfaceVolumeControl {
		let view = WKInterfaceVolumeControl(origin: .local)
		view.setTintColor(.white)
		view.focus()
		return view
	}

	func updateWKInterfaceObject(
		_ wkInterfaceObject: WKInterfaceVolumeControl,
		context: WKInterfaceObjectRepresentableContext<VolumeControl>
	) {
	}
}
