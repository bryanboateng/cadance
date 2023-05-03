import SwiftUI

struct Player: View {
	private let minimumCadance = 120
	private let maximumCadance = 250
	@AppStorage("cadance") var cadance: Int = 175
	@StateObject private var metronome = Metronome()
	@ScaledMetric private var fontSize = 60

	var body: some View {
		VStack(spacing: 8) {
			Text(String(cadance))
				.foregroundStyle(cadanceTextHierarchicalShapeStyle)
				.foregroundStyle(cadanceTextColor)
				.focusable(metronome.state == .off)
				.digitalCrownRotation(
					Binding(
						get: { Float(cadance) },
						set: { cadance = Int($0) }
					),
					from: Float(minimumCadance),
					through: Float(maximumCadance),
					by: 1,
					sensitivity: .medium,
					isContinuous: true
				)
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

struct Player_Previews: PreviewProvider {
	static var previews: some View {
		Player()
	}
}
