import SwiftUI

struct Player: View {
	let cadance = 175
	@StateObject private var metronome = Metronome()

	var body: some View {
		Button {
			if metronome.isPlaying {
				metronome.stop()
			} else {
				metronome.start(beatsPerMinute: cadance)
			}
		} label: {
			Image(systemName: buttonSymbolName)
				.symbolVariant(.circle)
				.symbolRenderingMode(.hierarchical)
				.imageScale(.large)
		}
		.buttonStyle(.plain)
		.font(.system(size: 60))
	}
	private var buttonSymbolName: String {
		if metronome.isPlaying {
			return "stop"
		} else {
			return "play"
		}
	}
}

struct Player_Previews: PreviewProvider {
	static var previews: some View {
		Player()
	}
}
