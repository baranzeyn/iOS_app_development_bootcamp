import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    var counter = 0
    var timer = Timer()
    var totalTime=0

    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle! // guaranteed to be non-nil
        totalTime = eggTimes[hardness]! // set the counter based on the selected hardness
        counter=totalTime
        progressBar.progress=0.0
        titleLabel.text=hardness
        startTimer()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func startTimer() {
        timer.invalidate() // cancel any previous timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    func calculatePercent(count:Int,total:Int){
        let percent=Float(count)/Float(totalTime)
        progressBar.progress=percent
        print(percent)
    }

    @objc func updateCounter() {
        if counter > 0 {
            print("\(counter) seconds")
            calculatePercent(count: (totalTime-counter), total: totalTime)
            counter -= 1
        } else {
            timer.invalidate()
            titleLabel.text="DONE!"
            calculatePercent(count: (totalTime-counter), total: totalTime)
            playSound()
        }
    }

    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound" , withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
