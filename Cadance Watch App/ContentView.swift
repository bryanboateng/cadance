import SwiftUI

struct ContentView: View {
	private let cadance = 170

	@StateObject private var metronome = Metronome()

	var body: some View {
		VStack(alignment: .center) {
			Button {
				if metronome.isPlaying {
					metronome.stop()
				} else {
					metronome.start(beatsPerMinute: cadance)
				}
			} label: {
				Image(systemName: metronome.isPlaying ? "stop" : "play")
					.symbolVariant(.circle)
					.symbolRenderingMode(.hierarchical)
					.imageScale(.large)
					.font(.system(size: 50))
			}
			.buttonStyle(.plain)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
