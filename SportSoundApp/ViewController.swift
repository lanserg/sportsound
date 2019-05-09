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

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var ApplauseLBL: UILabel!
    
    @IBOutlet weak var MagicLBL: UILabel!
    
    @IBOutlet weak var BuzzleLBL: UILabel!
    
    @IBOutlet weak var OhhhLBL: UILabel!
    
    @IBOutlet weak var BlockLBL: UILabel!
    
    @IBOutlet weak var WhistleLBL: UILabel!
    
    @IBOutlet weak var BadLuckLBL: UILabel!
    
    @IBOutlet weak var SetNameLBL: UILabel!
    
    @IBOutlet weak var stopTimeout: UILabel!
    
    var audioPlayer: AVAudioPlayer!
    
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
    
    @IBOutlet weak var SwitchLang: UISwitch!
    
    @IBAction func SwitchLangEngRu(_ sender: UISwitch) {
    }
    func language () {
        if (deviceLang.contains("ru-") || deviceLang.contains("be-") || deviceLang.contains("uk-") || deviceLang.contains("kk-")) {
            lang1 = "ru"
            ApplauseLBL.text = "Аплодисменты"
            MagicLBL.text = "Магия"
            BuzzleLBL.text = "Сирена"
            OhhhLBL.text = "О-оу"
            BlockLBL.text = "Блок"
            WhistleLBL.text = "Свисток"
            BadLuckLBL.text = "Не повезло"
            SetNameLBL.text = "ПАРТИЯ"
            inputTeam1.placeholder = "Команда 1"
            inputTeam2.placeholder = "Команда 2"
            EndOfSet.text = "Конец партии"
            finishTheMatchLBL.text = "Закончить матч"
            whistle.text = "Свисток"
            timeout.text = "Таймаут"
            stopTimeout.text = "Таймаут окончен"
            log.text = "История"
            resetScore.text = "Сбросить очки"
        } else {
                lang1 = "eng"
                ApplauseLBL.text = "Applause"
                MagicLBL.text = "Magic"
                BuzzleLBL.text = "Buzzle"
                OhhhLBL.text = "Ohhh"
                BlockLBL.text = "Block"
                WhistleLBL.text = "Whistle"
                BadLuckLBL.text = "Bad luck"
                SetNameLBL.text = "SET"
                inputTeam1.placeholder = "Team 1"
                inputTeam2.placeholder = "Team 2"
                EndOfSet.text = "finish set"
                finishTheMatchLBL.text = "finish the match"
                whistle.text = "whistle"
                timeout.text = "timeout"
                stopTimeout.text = "STOP Timeout"
                log.text = "Log"
                resetScore.text = "reset score"
        }
    }
    
    
    @IBOutlet weak var resetScore: UILabel!
    
    @IBOutlet weak var log: UILabel!
    
    @IBOutlet weak var timeout: UILabel!
    
    @IBOutlet weak var whistle: UILabel!
    
    @IBOutlet weak var finishTheMatchLBL: UILabel!
    
    @IBOutlet weak var EndOfSet: UILabel!
    
    @IBOutlet weak var newMatchButton: UIButton!
    
    @IBOutlet weak var finalWhistleButton: UIButton!
    
    @IBOutlet weak var logButton: UIButton!
    
    @IBOutlet var swipeDownOutlet: UISwipeGestureRecognizer!
    
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
    
    @IBOutlet weak var team1LBL: UILabel!
    
    @IBOutlet weak var team2LBL: UILabel!
    
    @IBOutlet weak var inputTeam1: UITextField!
    
    @IBOutlet weak var inputTeam2: UITextField!
    
    @IBOutlet weak var setButton: UIButton!
    
    @IBOutlet weak var setLBL: UILabel!
    
    @IBOutlet weak var whistleB: UIButton!
    
    @IBOutlet weak var timeoutStart: UIButton!
    
    @IBOutlet weak var timeotStop: UIButton!
    
    @IBOutlet weak var timerLBL: UILabel!
    
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
       
        toSecondViewTeams = "\(t1) : \(t2)"
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
            toSecondViewScore += ", \(score1) : \(score2)"
                toSecondViewSets = "\(team1log) : \(team2log)"
            } else {
                toSecondViewScore += ", \(score2) : \(score1)"
                toSecondViewSets = "\(team2log) : \(team1log)"
            }
    }
    }

    func addingToMain() {
        let match = Match (score: "\(toSecondViewSets)", setscore: "\(toSecondViewScore)", teamnames: "\(toSecondViewTeams)")
        arrayOfData.append(match.teamnames)
        arrayOfData.append(match.score)
        arrayOfData.append(match.setscore)
    }
    
    func changeSides () {
        let scoreAmount = score1 + score2
        if (scoreAmount == 7 || scoreAmount == 14 || scoreAmount == 21 || scoreAmount == 28 || scoreAmount == 35 || scoreAmount == 42) {
            vibration()
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
        timeotStop.isHidden = false
        timeout.isHidden = true
        stopTimeout.isHidden = false
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
            timeout.isHidden = false
            timeotStop.isHidden = true
            stopTimeout.isHidden = true
            elapse = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.timerLBL.isHidden = true
            }
        }
    }
    
    @IBAction func timerStop(_ sender: Any) {
        timer.invalidate()
        timerLBL.text = "0"
        timeotStop.isHidden = true
        timeoutStart.isHidden = false
        timeout.isHidden = false
        timerLBL.isHidden = true
        stopTimeout.isHidden = true
    }
    
    
    @IBAction func finalWhistleAction(_ sender: Any) {
        name="whistle_orig"
        playSound()
        newMatchButton.isEnabled = true
        if (score1 > 1 && (score1 >= (score2 + 2))) {
            team1log+=1
           stringequal()
        } else if (score2 > 1 && (score2 >= (score1 + 2))) {
                team2log+=1
          stringequal()
        }
        finalWhistleButton.isEnabled = false
    }
    
    @IBAction func toLogButton(_ sender: UIButton) {
        //let vc2 = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondViewController
        //vc2.arrData = arrayOfData as! [String]
        //self.present(vc2, animated: true, completion: nil)
    }
    
    @IBAction func newMatchStart(_ sender: Any) {
        addingToMain()
        resetAllData()
        newMatchButton.isEnabled = false
        print(arrayOfData)
        //let vc1 = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondViewController
        //vc1.arrData = arrayOfData as! [String]
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     let destVCdata: SecondViewController = segue.destination as! SecondViewController
     destVCdata.arrData = arrayOfData as! [String]
        let lang: SecondViewController = segue.destination as! SecondViewController
        lang.lang2 = lang1
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
        if (score1 < 50) {
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

        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .up:
                if (score1 >= 0 && score1 < 50) {
                    score1+=1
                score1LBL.text = NSString (format: "%i", score1) as String
                }
            case .down:
                if (score1 > 0 && score1 <= 50) {
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
        if (score2 < 50) {
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
        
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
    }
    
    @objc func handleSwipe2(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .up:
                if (score2 >= 0 && score2 < 50) {
                score2+=1
                score2LBL.text = NSString (format: "%i", score2) as String
                }
            case .down:
                if (score2 > 0 && score2 <= 50) {
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
            self.audioPlayer.play()
            
        } catch {
            print("Error")
        }
    }
   
    @IBAction func whistleBut(_ sender: Any) {
        name="serv_whistle"
        playSound()
    }
    

    @IBAction func playButton(_ sender: Any) {
        name="noise"
        playSound()
    }
    
    @IBAction func playMagic(_ sender: Any) {
        name="magic"
        playSound()
    }
    
    @IBAction func playBuzzel(_ sender: Any) {
        name="buzzle"
        playSound()
    }

    @IBAction func playOhhh(_ sender: Any) {
        name="oou"
        playSound()
    }
    
    @IBAction func playBlock(_ sender: Any) {
        name="monsterBlock"
        playSound()
    }
    
    @IBAction func playWhistle(_ sender: Any) {
        name="whistle"
        playSound()
    }
    
    @IBAction func playBadluck(_ sender: Any) {
        name="unluck"
        playSound()
    }
    
    var clear = "12345678"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    let deviceLang = Locale.preferredLanguages[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputTeam2.delegate = self
        inputTeam1.delegate = self
        serviceBallImg.isHidden = true
        serviceBall2Img.isHidden = true
        timerLBL.isHidden = true
        timeout.isHidden = false
        timeotStop.isHidden = true
        stopTimeout.isHidden = true
        changeSides()
        print(clear)
        print(arrayOfData)
        language()
        print(deviceLang)
    }
    
}

