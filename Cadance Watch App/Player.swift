import SwiftUI

struct Player: View {
	@StateObject private var metronome = Metronome()

	var body: some View {
		Button {
			if metronome.isPlaying {
				metronome.stop()
			} else {
				// MARK: PLAY
				metronome.start(beatsPerMinute: 175)
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
