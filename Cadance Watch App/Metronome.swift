import AVFoundation
import Combine

class Metronome: ObservableObject {
	private let beatPlayer = try! AVAudioPlayer(
		contentsOf: Bundle.main.url(forResource: "beat", withExtension: "m4a")!
	)
	private var timerConnection: Cancellable?
	private var playSoundConnection: Cancellable?

	@Published var isPlaying = false

	func start(beatsPerMinute: Int) {
		let session = configureAudioSession()
		Task { @MainActor in
			isPlaying = true
			try! await session.activate(options: [])
			beatPlayer.prepareToPlay()
			let timer = Timer.publish(
				// Fire timer n times per minute
				every: TimeInterval(60) / TimeInterval(beatsPerMinute),
				tolerance: 0,
				on: .main,
				in: .common
			)
			timerConnection = timer.connect()
			playSoundConnection = timer.sink { _ in
				self.play()
			}
		}
	}

	func stop() {
		isPlaying = false
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

	private func play() {
		if beatPlayer.isPlaying {
			beatPlayer.pause()
		}
		beatPlayer.currentTime = 0
		beatPlayer.play()
	}
}
