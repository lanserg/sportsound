//
//  ViewController.swift
//  SportSoundApp
//
//  Created by Elena Nazarova on 07.01.2019.
//  Copyright © 2019 Elena Nazarova. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController, UITextFieldDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var SetNameLBL: UILabel!
    
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    var name: String?
    
    var score1 = 0
    
    var score2 = 0
    
    var score = 0
    
    var team1:String = ""
    
    var team2:String = ""
    
    var team:String = ""
    
    var set = 1
    
    var team1log = 0
    
    var team2log = 0
    
    var teamlog = 0
    
    var toSecondViewTeams: String = ""
    
    var toSecondViewScore: String = ""
    
    var toSecondViewSets: String = ""
    
    var setscore: String = ""
    
    var matchNumber = 0
    
    var timer = Timer()
    
    var lang1 = ""

    @IBOutlet weak var finalWhistleButton: UIButton!
    

    
    @IBAction func swipeDown(_ sender: Any) {
    }
    
    @IBOutlet weak var serviceBall2Img: UIImageView!
    
    @IBOutlet weak var serviceBallImg: UIImageView!
    
    @IBOutlet weak var score1Button: UIButton!
    
    @IBOutlet weak var switchButton: UIButton!
    
    @IBOutlet weak var score2Button: UIButton!
    
    @IBOutlet weak var score1LBL: UILabel!
    
    @IBOutlet weak var score2LBL: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var inputTeam1: UITextField!
    
    @IBOutlet weak var inputTeam2: UITextField!
    
    @IBOutlet weak var setButton: UIButton!
    
    @IBOutlet weak var setLBL: UILabel!
    
    @IBOutlet weak var whistleB: UIButton!
    
    @IBOutlet weak var timeoutStart: UIButton!
    
    @IBOutlet weak var timeoutStop: UIButton!
    
    @IBOutlet weak var timerLBL: UILabel!
    
    @IBOutlet weak var randomCoinImage: UIImageView!
    
    @IBOutlet weak var DigBtn: UIButton!
    
    @IBOutlet weak var blockBTN: UIButton!
    
    @IBOutlet weak var atackBTN: UIButton!
    
    @IBOutlet weak var awesomeBTN: UIButton!
    
    @IBOutlet weak var playPauseBTN: UIButton!
    
    class Match {
        var score: String = ""
        var setscore: String = ""
        var teamnames: String = ""
        init(score: String, setscore: String, teamnames: String) {
            self.score = score
            self.setscore = setscore
            self.teamnames = teamnames
        }
    }
    
    var arrayOfData: [Any] = []
    
    func stringequal () {
       
        toSecondViewTeams = "\(t1) - \(t2)"
        if (team1log == 1 && team2log == 0) || (team1log == 0 && team2log == 1) {
             if (t1 == team1) {
            toSecondViewScore = "\(score1) : \(score2)"
            toSecondViewSets = "\(team1log) : \(team2log)"
             } else {
                toSecondViewScore = "\(score2) : \(score1)"
                toSecondViewSets = "\(team2log) : \(team1log)"
            }
        } else {
            if (t1 == team1) {
                toSecondViewScore += "; \(score1) : \(score2)"
                toSecondViewSets = "\(team1log) : \(team2log)"
            } else {
                toSecondViewScore += "; \(score2) : \(score1)"
                toSecondViewSets = "\(team2log) : \(team1log)"
            }
    }
    }
    var matchResault : String = ""
    var matchScore : String = ""
    var matchTeams : String = ""

    
    func addingToMain() {
        let match = Match (score: "  \(toSecondViewSets)", setscore: "  \(toSecondViewScore)", teamnames: " \(toSecondViewTeams)")
        arrayOfData.append(match.teamnames)
        arrayOfData.append(match.score)
        arrayOfData.append(match.setscore)
    }
    
    func changeSides () {
        let scoreAmount = score1 + score2
        let scoreToVib : [Int] = [7, 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105, 112, 119, 126]
        for i in scoreToVib {
            if i == scoreAmount {
            vibration()
            }
        }
    }
    
    func vibration () {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }

    var elapse: Double = 0
    
    @IBAction func timerStart(_ sender: Any) {
        timerLBL.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: NSDate(), repeats: true)
        timeoutStart.isHidden = true
        timeoutStop.isHidden = false
    }
    
    @objc func timerUpdate () {
        elapse = -(self.timer.userInfo as! NSDate).timeIntervalSinceNow
        if elapse <= 60 {
            timerLBL.text = String (format: "%.0f", elapse)
            if ((elapse >= 30 && elapse < 31) || (elapse >= 59 && elapse < 60)) {
                vibration()
            }
        } else if elapse > 60 {
            timer.invalidate()
            timerLBL.text = "0"
            timeoutStart.isHidden = false
            timeoutStop.isHidden = true
            elapse = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.timerLBL.isHidden = true
            }
        }
    }
    
    
    
    @IBAction func timerStop(_ sender: Any) {
        timer.invalidate()
        timerLBL.text = "0"
        timeoutStop.isHidden = true
        timeoutStart.isHidden = false
        timerLBL.isHidden = true
    }
   
    @IBAction func finalWhistleAction(_ sender: Any) {
        
        let dialogMessage = UIAlertController(title: "End of:", message: "", preferredStyle: .alert)
        
        let set = UIAlertAction(title: "Set", style: .default, handler: { (action) -> Void in
            print("Set button tapped")
            if (self.score1 > 0 && (self.score1 > self.score2)) {
                self.team1log+=1
                self.stringequal()
            } else if (self.score2 > 0 && (self.score2 > self.score1)) {
                self.team2log+=1
                self.stringequal()
            }
        })
        
        
        let match = UIAlertAction(title: "Match", style: .default, handler:  { (action) -> Void in
            print("Match button tapped")
            if (self.score1 > 0 && (self.score1 > self.score2)) {
                self.team1log+=1
                self.stringequal()
            } else if (self.score2 > 0 && (self.score2 > self.score1)) {
                self.team2log+=1
                self.stringequal()
            }
            self.addingToMain()
            self.resetAllData()
        })
        
        dialogMessage.addAction(set)
        dialogMessage.addAction(match)
        
        self.present(dialogMessage, animated: true, completion: nil)

        finalWhistleButton.isEnabled = false
    }

    func arrRemove()  {
        arrayOfData.removeAll()
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (arrayOfData.count > 0) {
     let destVCdata: SecondViewController = segue.destination as! SecondViewController
     destVCdata.arrData = arrayOfData as! [String]
            arrRemove()
        }
     }
     
    func resetAllData() {
        score1 = 0
        score2 = 0
        score1LBL.text = NSString (format: "%i", score1) as String
        score2LBL.text = NSString (format: "%i", score2) as String
        team1log = 0
        team2log = 0
        team1 = ""
        team2 = ""
        t1 = ""
        t2 = ""
        inputTeam1.text = NSString (format: "%@", team1) as String
        inputTeam2.text = NSString (format: "%@", team2) as String
    }

    var t1 = ""
    var t2 = ""
    var s1 = 0
    var s2 = 0
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        team1 = inputTeam1.text!
        team2 = inputTeam2.text!
        t1 = inputTeam1.text!
        t2 = inputTeam2.text!
        return true
    }
    
    @IBAction func setPlusButton(_ sender: Any) {
        if (set < 5) {
        set+=1
        setLBL.text = NSString (format: "%i", set) as String
        } else {
            set=1
            setLBL.text = NSString (format: "%i", set) as String
        }
    }
    
    @IBAction func insertTeam1(_ sender: Any) {
    }
    
    @IBAction func insertTeam2(_ sender: Any) {
    }
    
    @IBAction func resetButtonPress(_ sender: Any) {
        reset ()
    }
    
    @IBAction func score1plus(_ sender: Any) {
        finalWhistleButton.isEnabled = true
        if (score1 < 99) {
        score1+=1
        }
        changeSides()
        score1LBL.text = NSString (format: "%i", score1) as String
        serviceBallImg.isHidden = false
        serviceBall2Img.isHidden = true

        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        downSwipe.direction = .down
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        upSwipe.direction = .up
        
        score1Button.isUserInteractionEnabled = true
        score1Button.addGestureRecognizer(upSwipe)
        score1Button.addGestureRecognizer(downSwipe)
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .up:
                if (score1 >= 0 && score1 < 99) {
                    score1+=1
                score1LBL.text = NSString (format: "%i", score1) as String
                }
            case .down:
                if (score1 > 0 && score1 <= 99) {
                    score1-=1
                score1LBL.text = NSString (format: "%i", score1) as String
                }
            default:
                break
            }
        }
    }

    @IBAction func score2plus(_ sender: Any) {
        finalWhistleButton.isEnabled = true
        if (score2 < 99) {
        score2+=1
        }
        changeSides()
        score2LBL.text = NSString (format: "%i", score2) as String
            serviceBallImg.isHidden = true
            serviceBall2Img.isHidden = false

        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe2(sender:)))
        downSwipe.direction = .down
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe2(sender:)))
        upSwipe.direction = .up
        
        score2Button.isUserInteractionEnabled = true
        score2Button.addGestureRecognizer(upSwipe)
        score2Button.addGestureRecognizer(downSwipe)
    }
    
    @objc func handleSwipe2(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .up:
                if (score2 >= 0 && score2 < 99) {
                score2+=1
                score2LBL.text = NSString (format: "%i", score2) as String
                }
            case .down:
                if (score2 > 0 && score2 <= 99) {
                score2-=1
                score2LBL.text = NSString (format: "%i", score2) as String
                }
            default:
                break
            }
        }
    }
    
    @IBAction func doSwitch(_ sender: Any) {
     sButton()
    }
    
    var num = Int.random(in: 1...4)

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully: Bool)
    {
        playPauseBTN.setImage(UIImage.init(named: "play-button"), for: .normal)
        DigBtn.isEnabled = true
        blockBTN.isEnabled = true
        atackBTN.isEnabled = true
        awesomeBTN.isEnabled = true
        whistleB.isEnabled = true
    }
    
    @IBAction func playPauseButton(_ sender: UIButton) {
        if (sender.currentImage?.isEqual(UIImage(named: "play-button")))! {
        playPauseBTN.setImage(UIImage.init(named: "pauseBtn"), for: .normal)
            if num == 1 {
                name = "soundOfTimeout"
                playSound()
                num += 1
                
            } else if num == 2 {
                name = "soundOfTimeout1"
                playSound()
                num += 1
                
            } else if num == 3 {
                name = "soundOfTimeout2"
                playSound()
                num += 1
                
            } else if num == 4 {
                name = "soundOfTimeout3"
                playSound()
                num = 1
                
            }
            DigBtn.isEnabled = false
            blockBTN.isEnabled = false
            atackBTN.isEnabled = false
            awesomeBTN.isEnabled = false
            whistleB.isEnabled = false
            
        }
        else {
       
            self.audioPlayer.stop()
             playPauseBTN.setImage(UIImage.init(named: "play-button"), for: .normal)
            DigBtn.isEnabled = true
            blockBTN.isEnabled = true
            atackBTN.isEnabled = true
            awesomeBTN.isEnabled = true
            whistleB.isEnabled = true
        }
    
    }

    func reset () {
        score1 = 0
        score2 = 0
        score1LBL.text = NSString (format: "%i", score1) as String
        score2LBL.text = NSString (format: "%i", score2) as String
        serviceBallImg.isHidden = true
        serviceBall2Img.isHidden = true
        
    }
    func sButton() {
        teamlog = team1log
        team1log = team2log
        team2log = teamlog
        score = score1
        score1 = score2
        score2 = score
        score1LBL.text = NSString (format: "%i", score1) as String
        score2LBL.text = NSString (format: "%i", score2) as String
        team = team1
        team1 = team2
        team2 = team
        inputTeam1.text = NSString (format: "%@", team1) as String
        inputTeam2.text = NSString (format: "%@", team2) as String
        if (serviceBallImg.isHidden == true) {
            serviceBallImg.isHidden = false
            serviceBall2Img.isHidden = true
        } else {
            serviceBallImg.isHidden = true
            serviceBall2Img.isHidden = false
        }
    }
  
    func playSound() {
        do {
            self.audioPlayer =  try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: name, ofType: "mp3")!) as URL)
            audioPlayer.delegate = self
            self.audioPlayer.play()
            let audiosession = AVAudioSession.sharedInstance()
            do {
                try audiosession.setCategory(AVAudioSession.Category.playback)
            }
            catch {
                
            }
            
        } catch {
            print("Error")
        }
    }
    
    @IBAction func whistleBut(_ sender: UIButton) {
        self.audioPlayer.stop()
    }
    
    @IBAction func whistleHoldButton(_ sender: Any) {
        name="whistle_long"
        playSound()
    }
    
    @IBAction func playButton(_ sender: Any) {
        name="cheer"
        playSound()
    }
    
    
    @IBAction func playBuzzel(_ sender: Any) {
        name="buzzle"
        playSound()
    }

    
    @IBAction func playBlock(_ sender: Any) {
        name="monsterBlock"
        playSound()
    }

    
    @IBAction func playBadluck(_ sender: Any) {
        name="unluck"
        playSound()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func randomButtom(_ sender: Any) {
        let randomInt = Int.random(in: 1...2)
        randomCoinImage.isHidden = false
        if (randomInt == 1) {
            let image1 : UIImage = UIImage(named: "euro")!
            randomCoinImage.image = image1
        } else {
            let image2 : UIImage = UIImage(named: "bitcoin")!
            randomCoinImage.image = image2
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.randomCoinImage.isHidden = true
        }
    }
    
    var clear = "2"
    var clear2 : String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomCoinImage.isHidden = true
        inputTeam2.delegate = self
        inputTeam1.delegate = self
        serviceBallImg.isHidden = true
        serviceBall2Img.isHidden = true
        timerLBL.isHidden = true
        timeoutStart.isHidden = false
        timeoutStop.isHidden = true
        finalWhistleButton.isEnabled = false
        changeSides()
    }
    
}

