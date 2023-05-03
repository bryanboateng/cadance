import SwiftUI

@main
struct Cadance_Watch_AppApp: App {
	var body: some Scene {
		WindowGroup {
			TabView {
				Player()
				VolumeControl()
			}
			.tabViewStyle(.page)
		}
	}
}
