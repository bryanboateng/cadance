import SwiftUI

struct ContentView: View {
	private let cadance = 170

	@StateObject private var metronome = Metronome()
	@ScaledMetric private var fontSize = 60

	var body: some View {
		VStack(spacing: 8) {
			Text(String(cadance))
				.foregroundStyle(cadanceTextHierarchicalShapeStyle)
				.foregroundStyle(cadanceTextColor)
			Button {
				switch metronome.state {
				case .off:
					metronome.start(beatsPerMinute: cadance)
				case .on:
					metronome.stop()
				}
			} label: {
				Image(systemName: buttonSymbolName)
					.symbolVariant(.circle)
					.symbolRenderingMode(.hierarchical)
					.imageScale(.large)
			}
			.buttonStyle(.plain)
		}
		.font(.system(size: fontSize))
	}
	private var buttonSymbolName: String {
		switch metronome.state {
		case .off:
			return "play"
		case .on:
			return "stop"
		}
	}
	private var cadanceTextColor: Color {
		switch metronome.state {
		case .off:
			return .primary
		case .on:
			return .yellow
		}
	}
	private var cadanceTextHierarchicalShapeStyle: HierarchicalShapeStyle {
		switch metronome.state {
		case .off:
			return .primary
		case .on(let rythmState):
			switch rythmState {
			case .onBeat:
				return .primary
			case .offBeat:
				return .secondary
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
