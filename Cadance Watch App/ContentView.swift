import SwiftUI

struct ContentView: View {
	private let cadance = 170

	@StateObject private var metronome = Metronome()
	@ScaledMetric private var fontSize = 60

	var body: some View {
		VStack(spacing: 8) {
			Text(String(cadance))
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
			}
			.buttonStyle(.plain)
		}
		.font(.system(size: fontSize))
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
