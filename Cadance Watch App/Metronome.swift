import AVFoundation
import Combine

extension Metronome {
	enum State: Equatable {
		case off
		case on(RythmState)
	}
	enum RythmState {
		case onBeat
		case offBeat
		func toggled() -> Self {
			switch self {
			case .onBeat:
				return .offBeat
			case .offBeat:
				return .onBeat
			}
		}
	}
}

class Metronome: ObservableObject {
	private let beatPlayer = try! AVAudioPlayer(
		contentsOf: Bundle.main.url(forResource: "beat", withExtension: "m4a")!
	)
	private var timerConnection: Cancellable?
	private var playSoundConnection: Cancellable?

	@Published var state = State.off

	func start(beatsPerMinute: Int) {
		let session = configureAudioSession()
		Task { @MainActor in
			try! await session.activate(options: [])
			state = .on(.offBeat)
			beatPlayer.prepareToPlay()
			let timer = Timer.publish(
				every: TimeInterval(60) / TimeInterval(beatsPerMinute),
				tolerance: 0,
				on: .main,
				in: .common
			)
			timerConnection = timer.connect()
			playSoundConnection = timer.sink { _ in
				self.playSound()
			}
		}
	}

	func stop() {
		state = .off
		beatPlayer.stop()
		timerConnection?.cancel()
		timerConnection = nil
		playSoundConnection?.cancel()
		playSoundConnection = nil
	}

	private func configureAudioSession() -> AVAudioSession {
		let session = AVAudioSession.sharedInstance()
		try! session.setCategory(
			.playback,
			mode: .default,
			policy: .longFormAudio,
			options: []
		)
		return session
	}

	private func playSound() {
		switch state {
		case .off:
			fatalError()
		case .on(let rythmState):
			play(player: beatPlayer)
			state = .on(rythmState.toggled())
		}
	}

	private func play(player: AVAudioPlayer) {
		if player.isPlaying {
			player.pause()
		}
		player.currentTime = 0
		player.play()
	}
}
