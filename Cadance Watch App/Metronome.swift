import AVFoundation

class Metronome: ObservableObject {
	private let tickPlayer: AVAudioPlayer
	private let tockPlayer: AVAudioPlayer
	private var tickShouldPlay = true
	private var timer: Timer?
	
	@Published var isPlaying = false
	
	init() {
		tickPlayer = try! AVAudioPlayer(
			contentsOf: Bundle.main.url(forResource: "Tick", withExtension: "mp3")!
		)
		tockPlayer = try! AVAudioPlayer(
			contentsOf: Bundle.main.url(forResource: "Tock", withExtension: "mp3")!
		)
	}
	
	func start(beatsPerMinute: Int) {
		isPlaying = true
		tickShouldPlay = true
		tickPlayer.prepareToPlay()
		tockPlayer.prepareToPlay()
		timer = Timer(
			timeInterval: 60.0 / TimeInterval(beatsPerMinute),
			target: self,
			selector: #selector(playSound),
			userInfo: nil,
			repeats: true
		)
		guard let timer else { fatalError() }
		timer.tolerance = 0
		RunLoop.current.add(timer, forMode: .common)
	}
	
	func stop() {
		isPlaying = false
		tickPlayer.stop()
		tockPlayer.stop()
		guard let timer else { fatalError() }
		timer.invalidate()
		self.timer = nil
		tickShouldPlay = true
	}
	
	@objc func playSound() {
		if tickShouldPlay {
			play(player: tickPlayer)
		} else {
			play(player: tockPlayer)
		}
		tickShouldPlay.toggle()
	}
	
	private func play(player: AVAudioPlayer) {
		if player.isPlaying {
			player.pause()
		}
		player.currentTime = 0
		player.play()
	}
}
