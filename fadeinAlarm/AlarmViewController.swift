import UIKit
import AVKit

class AlarmViewController: UIViewController,AVAudioPlayerDelegate {
    
    var 🛎🕰:Date!
    var 🔈🔉🔊time:Int!
    
    var x = 0
    var y = 0
    
    var 🕰📝: UILabel!
    
    var 📻:AVAudioPlayer!
    
    enum 🔈 {
        case 🔇
        case 🔇🔈🔉🔊
        case 🔊🔉🔈🔇
    }
    
    var 🔈state:🔈 = .🔇
    
    var 🕕:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        🕰📝 = UILabel(frame: .init(x: 0, y: 0, width: 200, height: 200))
        🕰📝.numberOfLines = 4
        🕰📝.textColor = .lightGray
        view.addSubview(🕰📝)
        
        let 👆 = UITapGestureRecognizer(target: self, action: #selector(🔚))
        view.addGestureRecognizer(👆)
        
        guard let 📍 = Bundle.main.url(forResource: "a", withExtension: "mp3") else { return }
        let 🗃 = FileManager.default
        let 🗂 = 🗃.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        guard let 🏷 = try? FileManager.default.contentsOfDirectory(at: 🗂, includingPropertiesForKeys: nil, options: [])
            else { return }
        do{
            if 🏷.isEmpty{
                📻 = try AVAudioPlayer(contentsOf: 📍)
            }else{
                📻 = try AVAudioPlayer(contentsOf: 🏷[0])
            }
            📻.delegate = self
            📻.volume = .zero
            📻.numberOfLoops = 5
        } catch {
            print("👿")
        }
        
        🕕 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(🕰), userInfo: nil, repeats: true)
        🕰()
        
        UIApplication.shared.isIdleTimerDisabled = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let 🗯 = UIAlertController(title: "⚠️", message: "❌ leave App\n❌ sleep device\n❌ mute-mode\n❓ 🔊🎚\n❓ 📱🔋🔌", preferredStyle: .alert)
        let 🕹 = UIAlertAction(title: "ok", style: .default, handler: nil)
        🗯.addAction(🕹)
        self.present(🗯, animated: true, completion: nil)
    }
    
    
    @objc func 🕰(){
        let 📅 = DateFormatter()
        📅.timeStyle = .short
        🕰📝.text = 📅.string(from: Date()) + "\nAlarm for " + 📅.string(from: 🛎🕰) + "~\nFade-in " + String(🔈🔉🔊time) + "min\nvolume " + String(📻.volume)
        x = x % (Int(view.frame.width) - 200) + 1
        y = y % (Int(view.frame.height) - 200) + 1
        🕰📝.frame = .init(x: x, y: y, width: 200, height: 200)
        switch 🔈state{
        case .🔇:
            if 📅.string(from: Date()) == 📅.string(from: 🛎🕰){
                📻.play()
                🔈state = .🔇🔈🔉🔊
            }
        case .🔇🔈🔉🔊:
            if 📻.volume > 1{ break }
            📻.volume += 1.0 / 60.0 / Float(🔈🔉🔊time!)
        case .🔊🔉🔈🔇:
            📻.volume -= 0.1
            🕰📝.alpha -= 0.1
            if 📻.volume < 0{
                📻.stop()
                🕕.invalidate()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func 🔚(){
        🔈state = .🔊🔉🔈🔇
        🕰📝.textColor = .white
    }
    override var prefersHomeIndicatorAutoHidden: Bool{
        return true
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
