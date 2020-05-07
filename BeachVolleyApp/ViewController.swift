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
import AMPopTip

class ViewController: UIViewController, UITextFieldDelegate, AVAudioPlayerDelegate {
    
    let popTip = PopTip()
    
    var tipNumber = 0
    
    var audioPlayer: AVAudioPlayer?
    
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
    
    @IBOutlet weak var SetNameLBL: UILabel!

    @IBOutlet weak var finalWhistleButton: UIButton!
    
    @IBOutlet weak var randomB: UIButton!
    
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
    
    @IBAction func swipeDown(_ sender: Any) {
        
       }
    
    // класс для каждого матча
    
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
    
    //запись результатов сетов и матчей
    
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

  // ф-я добавления данных о матче в массив для передачи в SecondVC с помошью prepareForSegue
   
    var arrayOfData: [Any] = []
    
    func addingToMain() {
        let match = Match (score: "  \(toSecondViewSets)", setscore: "  \(toSecondViewScore)", teamnames: " \(toSecondViewTeams)")
        arrayOfData.append(match.setscore)
        arrayOfData.append(match.score)
        arrayOfData.append(match.teamnames)
    }
  
    // ф-я напоминание-вибрация для смены сторон при достижении числа кратного 7
    
    func changeSides () {
        let scoreAmount = score1 + score2
        let scoreToVib3set : [Int] = [5, 10, 15, 20, 25,30, 35, 40, 45, 50, 55, 60, 65, 70]
        let scoreToVib : [Int] = [7, 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105, 112, 119, 126]
            if (setLBL.text == "3") {
                for i in scoreToVib3set {
                    if i == scoreAmount {
                        vibration()
                    }
                }
            } else {
                for i in scoreToVib {
                     if i == scoreAmount {
                        vibration()
                     }
                 }
        }
}
   
    // функция вибрации
    
    func vibration () {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }

    var elapse: Double = 0
    
   // запуск таймера
    
    @IBAction func timerStart(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: NSDate(), repeats: true)
        timeoutStart.isHidden = true
        timeoutStop.isHidden = false
        score1Button.isEnabled = false
        score2Button.isEnabled = false
    }
    
    @objc func timerUpdate () {
        elapse = -(self.timer.userInfo as! NSDate).timeIntervalSinceNow
            let minutes = Int(elapse) / 60 % 60
            let seconds = Int(elapse) % 60
        if elapse <= 180 {
            timerLBL.text = String (format: "%.02i:%.02i", minutes, seconds)
            if ((elapse >= 30 && elapse < 31) || (elapse >= 59 && elapse < 60) || (elapse >= 90 && elapse < 91) || (elapse >= 120 && elapse < 121) || (elapse >= 150 && elapse < 151) || (elapse >= 179 && elapse < 180)) {
                vibration()
            }
        } else if elapse > 180 {
            timer.invalidate()
            timerLBL.text = "00:00"
            timeoutStart.isHidden = false
            timeoutStop.isHidden = true
            elapse = 0
            score1Button.isEnabled = true
            score2Button.isEnabled = true
        }
    }
    
    
// остановка таймера
    
    @IBAction func timerStop(_ sender: Any) {
        timer.invalidate()
        timerLBL.text = "00:00"
        timeoutStop.isHidden = true
        timeoutStart.isHidden = false
        //timerLBL.isHidden = true
        score1Button.isEnabled = true
        score2Button.isEnabled = true
    }
   
    // завершение партии/матча
    
    @IBAction func finalWhistleAction(_ sender: Any) {
        if (score1 != score2) {
            let dialogMessage = UIAlertController(title: NSLocalizedString("Final whistle", comment: ""), message: NSLocalizedString("What do you want to finish?", comment: ""), preferredStyle: .alert)
   
            // ALERT при нажатии кнопки финального свистка для завершения матча или партии
            
        let set = UIAlertAction(title: NSLocalizedString("Set", comment: ""), style: .default, handler: { (action) -> Void in
            print("Set button tapped")
            if (self.score1 > 0 && (self.score1 > self.score2)) {
                self.team1log+=1
                self.stringequal()
                switch self.setLBL.text {
                case "1":
                    self.setLBL.text = "2"
                case "2":
                    self.setLBL.text = "3"
                case "3":
                    self.setLBL.text = "4"
                case "4":
                    self.setLBL.text = "5"
                case "5":
                    self.setLBL.text = "1"
                default:
                    break
                }
            } else if (self.score2 > 0 && (self.score2 > self.score1)) {
                self.team2log+=1
                self.stringequal()
                switch self.setLBL.text {
                case "1":
                    self.setLBL.text = "2"
                case "2":
                    self.setLBL.text = "3"
                case "3":
                    self.setLBL.text = "4"
                case "4":
                    self.setLBL.text = "5"
                case "5":
                    self.setLBL.text = "1"
                default:
                    break
                }
            }
            self.reset()
        })
        
        let match = UIAlertAction(title: NSLocalizedString("Match", comment: ""), style: .default, handler:  { (action) -> Void in
            print("Match button tapped")
            if (self.score1 > 0 && (self.score1 > self.score2)) {
                self.team1log+=1
                self.stringequal()
                self.setLBL.text = "1"
            } else if (self.score2 > 0 && (self.score2 > self.score1)) {
                self.team2log+=1
                self.stringequal()
                self.setLBL.text = "1"
            }
            self.addingToMain()
            self.resetAllData()
        })
        
        dialogMessage.addAction(set)
        dialogMessage.addAction(match)

        self.present(dialogMessage, animated: true) {
            dialogMessage.view.superview?.isUserInteractionEnabled = true
            dialogMessage.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        }
     
        finalWhistleButton.isEnabled = false
        }
    }

    @objc func alertControllerBackgroundTapped()
    {
        self.dismiss(animated: true, completion: nil)
        finalWhistleButton.isEnabled = true
    }
    
    // удаление данных о матче (после отправки в SecondVC)
    
    func arrRemove()  {
        arrayOfData.removeAll()
    }
   
    // передача массива данных о матче в SecondViewController
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (arrayOfData.count > 0) {
     let destVCdata: SecondViewController = segue.destination as! SecondViewController
     destVCdata.arrData = arrayOfData as! [String]
            arrRemove()
        }
     }
    
    // сброс всех введенных данных и обнуление информации о текущем матче после выбора "Окончить матч"
    
    func resetAllData() {
        score1 = 0
        score2 = 0
        score1LBL.text = NSString (format: "%i", score1) as String
        score2LBL.text = NSString (format: "%i", score2) as String
        team1log = 0
        team2log = 0
        team1 = NSLocalizedString("Team 1", comment: "")
        team2 = NSLocalizedString("Team 2", comment: "")
        t1 = NSLocalizedString("Team 1", comment: "")
        t2 = NSLocalizedString("Team 2", comment: "")
        inputTeam1.text = NSString (format: "%@", team1) as String
        inputTeam2.text = NSString (format: "%@", team2) as String
        serviceBallImg.isHidden = true
        serviceBall2Img.isHidden = true
        servNumLBL1.text = ""
        servNumLBL2.text = ""
        select_service1.isHidden = true
        select_service2.isHidden = true
        setLBL.text = "1"
    }

    var t1 = NSLocalizedString("Team 1", comment: "")
    var t2 = NSLocalizedString("Team 2", comment: "")
    var s1 = 0
    var s2 = 0
    
    // возвращаем данные с введенные в текстовые поля (названия команд)
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if (inputTeam1.text == "") {
            team1 = NSLocalizedString("Team 1", comment: "")
            t1 = NSLocalizedString("Team 1", comment: "")
        } else {
        team1 = inputTeam1.text!
        t1 = inputTeam1.text!
        }
        if (inputTeam2.text == "") {
             team2 = NSLocalizedString("Team 2", comment: "")
             t2 = NSLocalizedString("Team 2", comment: "")
         } else {
         team2 = inputTeam2.text!
         t2 = inputTeam2.text!
         }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if (inputTeam1.text == "") {
            inputTeam1.text = NSLocalizedString("Team 1", comment: "")
        }
        if (inputTeam2.text == "") {
        inputTeam2.text = NSLocalizedString("Team 2", comment: "")
        }
    }
    
    @objc func inputControllerBackgroundTapped()
      {
        inputTeam1.isUserInteractionEnabled = false
        inputTeam2.isUserInteractionEnabled = false
        inputTeam1.text = NSLocalizedString("Team 1", comment: "")
        inputTeam2.text = NSLocalizedString("Team 2", comment: "")
      }
  
    // текущая партия, установка вручную
        
    @IBAction func insertTeam1(_ sender: Any) {
    }
    
    @IBAction func insertTeam2(_ sender: Any) {
    }
    
    @IBAction func resetButtonPress(_ sender: Any) {
        reset ()
    }

   // добавление очков команда 1 и свайп вниз минус очко
    
    var sc1 = 0
    var sc2 = 0
    
    @IBAction func score1plus(_ sender: Any) {
        servNumLBL1.isHidden = false
            sc2 = 0
        if (sc1 == 0 && servNumLBL1.text == "1") {
            servNumLBL1.text = "2"
        } else if (sc1 == 0 && servNumLBL1.text == "2"){
            servNumLBL1.text = "1"
        }  else if (sc1 != 0 && servNumLBL1.text == "1"){
            servNumLBL1.text = "1"
        }  else if (sc1 != 0 && servNumLBL1.text == "2"){
            servNumLBL1.text = "2"
        }
        sc1+=1
        finalWhistleButton.isEnabled = true
            if (score1 < 99) {
                score1+=1
            }
        changeSides()
        score1LBL.text = NSString (format: "%i", score1) as String
        serviceBallImg.isHidden = false
        servNumLBL2.isHidden = true
        serviceBall2Img.isHidden = true

        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        downSwipe.direction = .down
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        upSwipe.direction = .up
        
        score1Button.isUserInteractionEnabled = true
        score1Button.addGestureRecognizer(upSwipe)
        score1Button.addGestureRecognizer(downSwipe)
        if (score1LBL.text == "1") {
            select_service1.isHidden = false
            //serviceBallImg.isHidden = true
        } else {
            select_service1.isHidden = true
        }
        saveServ = 0
    }
    
    // свайп вверх и вниз для очков команды1
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .up:
                if (score1 >= 0 && score1 < 99) {
                    servNumLBL1.isHidden = false
                               sc2 = 0
                           if (sc1 == 0 && servNumLBL1.text == "1") {
                               servNumLBL1.text = "2"
                           } else if (sc1 == 0 && servNumLBL1.text == "2"){
                               servNumLBL1.text = "1"
                           }  else if (sc1 != 0 && servNumLBL1.text == "1"){
                               servNumLBL1.text = "1"
                           }  else if (sc1 != 0 && servNumLBL1.text == "2"){
                               servNumLBL1.text = "2"
                           }
                           sc1+=1
                    score1+=1
                    changeSides()
                score1LBL.text = NSString (format: "%i", score1) as String
                    serviceBallImg.isHidden = false
                    servNumLBL2.isHidden = true
                    serviceBall2Img.isHidden = true
                    if (score1LBL.text == "1") {
                        select_service1.isHidden = false
                        serviceBallImg.isHidden = true
                    }
                    else {
                        select_service1.isHidden = true
                    }
                }
            case .down:
                if (score1 > 0 && score1 <= 99) {
                    score1-=1
                    changeSides()
                score1LBL.text = NSString (format: "%i", score1) as String
                   // if (score1LBL.text == "1") {
                        select_service1.isHidden = false
                        serviceBallImg.isHidden = true
                    select_service2.isHidden = false
                 //   } else {
                   //     select_service1.isHidden = true
                  //  }
                    if (score1LBL.text == "0" && score2LBL.text == "0") {
                        finalWhistleButton.isEnabled = false
                    }
                }
            default:
                break
            }
        }
    }

 // добавление очков второй команде
    
    @IBAction func score2plus(_ sender: Any) {
        servNumLBL2.isHidden = false
        sc1 = 0
        if (sc2 == 0 && servNumLBL2.text == "1") {
            servNumLBL2.text = "2"
        } else if (sc2 == 0 && servNumLBL2.text == "2"){
            servNumLBL2.text = "1"
        }  else if (sc2 != 0 && servNumLBL2.text == "1"){
            servNumLBL2.text = "1"
        }  else if (sc2 != 0 && servNumLBL2.text == "2"){
            servNumLBL2.text = "2"
        }
        sc2+=1
        finalWhistleButton.isEnabled = true
        if (score2 < 99) {
        score2+=1
        }
        changeSides()
        score2LBL.text = NSString (format: "%i", score2) as String
            serviceBallImg.isHidden = true
            serviceBall2Img.isHidden = false
            servNumLBL1.isHidden = true

        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe2(sender:)))
        downSwipe.direction = .down
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe2(sender:)))
        upSwipe.direction = .up
        
        score2Button.isUserInteractionEnabled = true
        score2Button.addGestureRecognizer(upSwipe)
        score2Button.addGestureRecognizer(downSwipe)
        if (score2LBL.text == "1") {
            select_service2.isHidden = false
            //serviceBall2Img.isHidden = true
        } else {
            select_service2.isHidden = true
        }
        saveServ = 0
    }
    
    // свайп вверх и вниз для очков команды2
    
    @objc func handleSwipe2(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .up:
                if (score2 >= 0 && score2 < 99) {
                    servNumLBL2.isHidden = false
                    sc1 = 0
                    if (sc2 == 0 && servNumLBL2.text == "1") {
                        servNumLBL2.text = "2"
                    } else if (sc2 == 0 && servNumLBL2.text == "2"){
                        servNumLBL2.text = "1"
                    }  else if (sc2 != 0 && servNumLBL2.text == "1"){
                        servNumLBL2.text = "1"
                    }  else if (sc2 != 0 && servNumLBL2.text == "2"){
                        servNumLBL2.text = "2"
                    }
                    sc2+=1
                score2+=1
                changeSides()
                score2LBL.text = NSString (format: "%i", score2) as String
                    serviceBallImg.isHidden = true
                    serviceBall2Img.isHidden = false
                    servNumLBL1.isHidden = true
                    if (score2LBL.text == "1") {
                        select_service2.isHidden = false
                        serviceBall2Img.isHidden = true
                    }
                    else {
                 
                    select_service2.isHidden = true
                    }
                }
            case .down:
                if (score2 > 0 && score2 <= 99) {
                score2-=1
                changeSides()
                score2LBL.text = NSString (format: "%i", score2) as String

                    select_service1.isHidden = false
                        select_service2.isHidden = false
                        serviceBall2Img.isHidden = true
                    if (score1LBL.text == "0" && score2LBL.text == "0") {
                        finalWhistleButton.isEnabled = false
                    }
                }
            default:
                break
            }
        }
    }
    
    // смена сторон
    
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
    
    // аудиоплеер (создается сессия)
    
    @IBAction func playPauseButton(_ sender: UIButton) {
        if (sender.currentImage?.isEqual(UIImage(named: "play-button")))! {
        playPauseBTN.setImage(UIImage.init(named: "pauseBtn"), for: .normal)
            if num == 1 {
                name = "Energy Sport Fun Upbeat"
                playSound()
                num += 1
                
            } else if num == 2 {
                name = "Oleg Kashchenko - Sport Summer Dubstep Fashion Pop"
                playSound()
                num += 1
                
            } else if num == 3 {
                name = "Fast Sport Energetic Rock (Full)"
                playSound()
                num += 1
                
            } else if num == 4 {
                name = "The Sport Music"
                playSound()
                num += 1
                
            } else if num == 5 {
                name = "Extreme Sport full edit"
                playSound()
                num += 1
                
            } else if num == 6 {
                name = "Sport Summer Dance"
                playSound()
                num += 1
                
            } else if num == 7 {
                name = "Sport Summer Party "
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
            audioPlayer?.stop()
            playPauseBTN.setImage(UIImage.init(named: "play-button"), for: .normal)
            DigBtn.isEnabled = true
            blockBTN.isEnabled = true
            atackBTN.isEnabled = true
            awesomeBTN.isEnabled = true
            whistleB.isEnabled = true
             
        }
    
    }

 // частичный сброс данных без сброса названия команд
    
    func reset () {
        score1 = 0
        score2 = 0
        score1LBL.text = NSString (format: "%i", score1) as String
        score2LBL.text = NSString (format: "%i", score2) as String
        serviceBallImg.isHidden = true
        serviceBall2Img.isHidden = true
        servNumLBL1.text = ""
        servNumLBL2.text = ""
        select_service1.isHidden = true
        select_service2.isHidden = true

    }
    
    var servNum = 0
    var saveServ = 0
    var servNumStr = ""
    
 // ф-я смены сторон каждые 7(5) очков
    
    func sButton() {
        saveServ = 1
        teamlog = team1log
        team1log = team2log
        team2log = teamlog
        score = score1
        score1 = score2
        score2 = score
        servNumStr = servNumLBL1.text!
        servNumLBL1.text = servNumLBL2.text!
        servNumLBL2.text = servNumStr
        servNum = sc1
        sc1 = sc2
        sc2 = servNum
        print("change sc1 =", sc1)
        print("change sc2 =", sc2)
        if (servNumLBL1.isHidden == true) {
            servNumLBL1.isHidden = false
            servNumLBL2.isHidden = true
        } else {
            servNumLBL1.isHidden = true
            servNumLBL2.isHidden = false
        }
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

    // ф-я аудиоплеера с созданием сессии
    
    func playSound() {
        do {
            self.audioPlayer =  try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: name, ofType: "mp3")!) as URL)
            audioPlayer!.delegate = self
            self.audioPlayer!.play()
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
   
    // блок кнопок со звуковыми эффектами
    
    @IBAction func whistleBut(_ sender: UIButton) {
        self.audioPlayer!.stop()
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
   
    // убираем navigationBar
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // подброс монетки для выбора
    
    @IBAction func randomButtom(_ sender: Any) {
        let randomInt = Int.random(in: 1...2)
        randomB.isEnabled = false
            if (randomInt == 1) {
                blinkingTeam1(blink: blinkingMarker)
            } else {
                blinkingTeam2(blink: blinkingMarker)
            }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            self.workitemteam1?.cancel()
            self.workitemteam2?.cancel()
            self.workitemteam3?.cancel()
            self.workitemteam4?.cancel()
            self.blinkingMarker = 1
            self.randomB.isEnabled = true
        }
    }
    
    var clear = "2"
    var clear2 : String = "0"
    
    //  ф-я UISegmentedControl для выбора подающего игрока
    
    func selectedPlayer (segment: UISegmentedControl, image2: UIImageView, image: UIImageView) -> Int {
        let select = segment.selectedSegmentIndex
        var num = 0
        switch select {
        case 0:
            num = 1
        case 1:
            num = 2
        default:
            print("not selected")
        }
        segment.isHidden = true
        image2.isHidden = true
        image.isHidden = false
        return (num)
    }
 
    // сегменты
    
    @IBOutlet weak var select_service1: UISegmentedControl!
    @IBOutlet weak var select_service2: UISegmentedControl!
    
    @IBOutlet weak var servNumLBL1: UILabel!
    @IBOutlet weak var servNumLBL2: UILabel!
    @IBOutlet weak var screenLBL: UILabel!
    
    var playerToService1 = 0
    var playerToService2 = 0
    
    @IBAction func selectServiceAction1(_ sender: Any) {
        playerToService1 = selectedPlayer(segment: select_service1, image2: serviceBall2Img, image: serviceBallImg)
        servNumLBL1.text = String (playerToService1)
        select_service1.selectedSegmentIndex = UISegmentedControl.noSegment
    }
    
    @IBAction func selectServiceAction2(_ sender: Any) {
        playerToService2 = selectedPlayer(segment: select_service2,image2: serviceBallImg, image: serviceBall2Img)
        servNumLBL2.text = String (playerToService2)
        select_service2.selectedSegmentIndex = UISegmentedControl.noSegment
    }

    // возврат светлого и активного экрана после обучалки
    
    func redim () {
        inputTeam1.backgroundColor = .white
        inputTeam2.backgroundColor = .white
        whistleB.backgroundColor = .white
        randomB.backgroundColor = .white
        finalWhistleButton.backgroundColor = .white
        timeoutStart.backgroundColor = .white
        resetButton.backgroundColor = .white
        timeoutStop.backgroundColor = .white
        timerLBL.backgroundColor = .white
        DigBtn.isEnabled = true
        blockBTN.isEnabled = true
        atackBTN.isEnabled = true
        awesomeBTN.isEnabled = true
        whistleB.isEnabled = true
        score1Button.isEnabled = true
        score2Button.isEnabled = true
        resetButton.isEnabled = true
        randomB.isEnabled = true
        timeoutStop.isEnabled = true
        timeoutStart.isEnabled = true
        switchButton.isEnabled = true
        playPauseBTN.isEnabled = true
    }
    
    // затемнение экрана для прохождения обучающих подсказок
    
    func dim () {
        view.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        inputTeam1.backgroundColor = UIColor(red:0.77, green:0.75, blue:0.75, alpha:1.0)
        inputTeam2.backgroundColor = UIColor(red:0.77, green:0.75, blue:0.75, alpha:1.0)
        whistleB.backgroundColor = UIColor(red:0.77, green:0.75, blue:0.75, alpha:1.0)
        randomB.backgroundColor = UIColor(red:0.77, green:0.75, blue:0.75, alpha:1.0)
        finalWhistleButton.backgroundColor = UIColor(red:0.77, green:0.75, blue:0.75, alpha:1.0)
        timeoutStart.backgroundColor = UIColor(red:0.77, green:0.75, blue:0.75, alpha:1.0)
        resetButton.backgroundColor = UIColor(red:0.77, green:0.75, blue:0.75, alpha:1.0)
        timeoutStop.backgroundColor = UIColor(red:0.77, green:0.75, blue:0.75, alpha:1.0)
        timerLBL.backgroundColor = UIColor(red:0.77, green:0.75, blue:0.75, alpha:1.0)
        DigBtn.isEnabled = false
        blockBTN.isEnabled = false
        atackBTN.isEnabled = false
        awesomeBTN.isEnabled = false
        whistleB.isEnabled = false
        select_service1.isHidden = true
        select_service2.isHidden = true
        score1Button.isEnabled = false
        score2Button.isEnabled = false
        resetButton.isEnabled = false
        randomB.isEnabled = false
        timeoutStop.isEnabled = false
        timeoutStart.isEnabled = false
        switchButton.isEnabled = false
        playPauseBTN.isEnabled = false
        
        if (finalWhistleButton.isEnabled == true) {
            fvb = 1
            finalWhistleButton.isEnabled = false
        }
    }
    
    var fvb = 0
    
    // смена подсказки при касании экрана
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.changeTips()
    }
  
    // вызов подсказок
    
    @IBAction func TipBTNPressed () {
        tipNumber = 1
        changeTips()
        dim()
        view.backgroundColor = UIColor(red:0.77, green:0.75, blue:0.75, alpha:1.0)
    }
    
    @IBOutlet weak var questionBTN: UIButton!
    
    @IBOutlet weak var tip1LBL: UILabel!
    
    // ф-я смены посказок во время обучения
    
    func changeTips () {
        if (tipNumber == 1) {
            popTip.show(text: NSLocalizedString("Smash the game with funny sounds!", comment: ""), direction: .down, maxWidth: 200, in: view, from: dabaImgLBL.frame)
            popTip.actionAnimation = .bounce(5)
            tipNumber += 1
            questionBTN.isHidden = true
            DigBtn.isHidden = true
            blockBTN.isHidden = true
            atackBTN.isHidden = true
            awesomeBTN.isHidden = true
            dabaImgLBL.isHidden = false
        } else if (tipNumber == 2) {
            popTip.show(text: NSLocalizedString("Use the whistle in the app!", comment: ""), direction: .up, maxWidth: 200, in: view, from: whistleImgLBL.frame)
            whistleImgLBL.isHidden = false
            whistleB.isHidden = true
            popTip.actionAnimation = .bounce(5)
            tipNumber += 1
            DigBtn.isHidden = false
            blockBTN.isHidden = false
            atackBTN.isHidden = false
            awesomeBTN.isHidden = false
            dabaImgLBL.isHidden = true
            whistleB.isEnabled = true
        } else if (tipNumber == 3) {
            popTip.show(text: NSLocalizedString("Choose a serving player!", comment: ""), direction: .right, maxWidth: 200, in: view, from: select_service1.frame)
            whistleB.isHidden = false
            whistleImgLBL.isHidden = true
            select_service1.isHidden = false
            select_service1.backgroundColor = .white
            select_service1.isEnabled = true
            select_service1.selectedSegmentIndex = 1
            blinkingSelector(blinkNum: blink)
            popTip.actionAnimation = .bounce(5)
            tipNumber += 1
           whistleB.isEnabled = false
        } else if (tipNumber == 4) {
            popTip.show(text: NSLocalizedString("Fill pauses with cool tracks!", comment: ""), direction: .up, maxWidth: 200, in: view, from: playImgLBL.frame)
            popTip.actionAnimation = .bounce(5)
            workitem?.cancel()
            workitem2?.cancel()
            self.select_service1.selectedSegmentIndex = UISegmentedControl.noSegment
            playImgLBL.isHidden = false
            playImgLBL.image = UIImage (named: "play-button")
            select_service1.isHidden = true
            playPauseBTN.isHidden = true
            blinkingPlay(blinkNum: blink)
            tipNumber = 5
        } else if (tipNumber == 5) {
                popTip.show(text: NSLocalizedString("Use random coin to select service/side!", comment: ""), direction: .right, maxWidth: 200, in: view, from: coinImgLBL.frame)
                playImgLBL.isHidden = true
                playPauseBTN.isHidden = false
                coinImgLBL.isHidden = false
                randomB.isHidden = true
                select_service1.isHidden = true
                popTip.actionAnimation = .bounce(5)
                blinkingCoin(blinkNum: blink)
                tipNumber = 6
        } else if (tipNumber == 6) {
            popTip.show(text: NSLocalizedString("This button for finish set or match!", comment: ""), direction: .up, maxWidth: 200, in: view, from: finalImgLBL.frame)
            popTip.actionAnimation = .bounce(5)
            workitem3?.cancel()
            workitem4?.cancel()
            inputTeam1.isHidden = false
            inputTeam2.isHidden = false
            coinImgLBL.isHidden = true
            randomB.isHidden = false
            finalWhistleButton.isHidden = true
            finalImgLBL.isHidden = false
            tipNumber = 7
        } else if (tipNumber == 7) {
            popTip.show(text: NSLocalizedString("The time-out button vibrates every 30 seconds!", comment: ""), direction: .down, maxWidth: 200, in: view, from: timeoutImgLBL.frame)
            popTip.actionAnimation = .bounce(5)
            finalImgLBL.isHidden = true
            finalWhistleButton.isHidden = false
            timeoutStop.isHidden = true
            timeoutStart.isHidden = true
            timeoutImgLBL.isHidden = false
            tipNumber = 8
        } else if (tipNumber == 8) {
            popTip.show(text: NSLocalizedString("Remember to change sides every 7 points", comment: ""), direction: .left, maxWidth: 200, in: view, from: switchImgLBL.frame)
            popTip.actionAnimation = .bounce(5)
            timeoutStop.isHidden = false
            timeoutStart.isHidden = false
            timeoutImgLBL.isHidden = true
            switchButton.isHidden = true
            switchImgLBL.isHidden = false
            tipNumber = 9
        } else if (tipNumber == 9) {
            popTip.show(text: NSLocalizedString("<<<Swipe to see the log<<<", comment: ""), direction: .left, maxWidth: 200, in: view, from: tip1LBL.frame)
            popTip.actionAnimation = .bounce(5)
            switchButton.isHidden = false
            switchImgLBL.isHidden = true
            tipNumber = 10
        } else if (tipNumber == 10) {
            questionBTN.isHidden = false
            view.backgroundColor = UIColor.white.withAlphaComponent(1)
            tipNumber = 0
            if (fvb == 1) {
                finalWhistleButton.isEnabled = true
                fvb = 0
            }
            redim()
        }
    }
    
    // image's outlets fot POPTip
    
    @IBOutlet weak var coinImgLBL: UIImageView!
    @IBOutlet weak var whistleImgLBL: UIImageView!
    @IBOutlet weak var playImgLBL: UIImageView!
    @IBOutlet weak var dabaImgLBL: UIImageView!
    @IBOutlet weak var finalImgLBL: UIImageView!
    @IBOutlet weak var timeoutImgLBL: UIImageView!
    @IBOutlet weak var switchImgLBL: UIImageView!
    
    
    var workitem : DispatchWorkItem?
    var workitem2 : DispatchWorkItem?
    var blink = 1
    
    // мигание некоторых элементов во время подсказок
    
    func blinkingSelector (blinkNum: Int) {
        workitem = DispatchWorkItem { self.select_service1.selectedSegmentIndex = 0
            self.blink = 2
            self.blinkingSelector(blinkNum: self.blink)
        }
        workitem2 = DispatchWorkItem { self.select_service1.selectedSegmentIndex = 1
            self.blink = 1
            self.blinkingSelector(blinkNum: self.blink)
        }
      if (blinkNum == 1) {
        DispatchQueue.main.asyncAfter (deadline: .now() + 0.5, execute: workitem!)
            } else {
        DispatchQueue.main.asyncAfter (deadline: .now() + 0.5, execute: workitem2!)
        }
    }
    var workitem3 : DispatchWorkItem?
    var workitem4 : DispatchWorkItem?
    
    
    func blinkingCoin (blinkNum: Int) {
        if (blinkNum == 1) {
            workitem3 = DispatchWorkItem {
                self.inputTeam1.isHidden = false
                self.inputTeam2.isHidden = true
                self.blink = 2
                self.blinkingCoin(blinkNum: self.blink)
            }
            DispatchQueue.main.asyncAfter (deadline: .now() + 0.5, execute: workitem3!)
        } else {
            workitem4 = DispatchWorkItem {
                self.inputTeam1.isHidden = true
                self.inputTeam2.isHidden = false
                self.blink = 1
                self.blinkingCoin(blinkNum: self.blink)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5,execute: workitem4!)
        }
    }
    
    func blinkingPlay (blinkNum: Int) {
        if (blinkNum == 1) {
            let image1 : UIImage = UIImage(named: "play-button")!
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.playImgLBL.image = image1
                self.blink = 2
                self.blinkingPlay(blinkNum: self.blink)
            }
        } else {
            let image2 : UIImage = UIImage(named: "pauseBtn")!
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.playImgLBL.image = image2
                self.blink = 1
                self.blinkingPlay(blinkNum: self.blink)
            }
        }
    }
   
    var workitemteam1 : DispatchWorkItem?
    var workitemteam2 : DispatchWorkItem?
    var workitemteam3 : DispatchWorkItem?
    var workitemteam4 : DispatchWorkItem?
    var blinkingMarker : Int = 1
     
    func blinkingTeam1 (blink: Int) {
         if (blink == 1) {
            workitemteam1 = DispatchWorkItem {
                self.blinkingMarker = 2
                self.inputTeam1.isHidden = true
                self.blinkingTeam1(blink: self.blinkingMarker)
            }
                DispatchQueue.main.asyncAfter (deadline: .now() + 0.5, execute: workitemteam1!)
         } else if (blink == 2){
            workitemteam2 = DispatchWorkItem {
                self.blinkingMarker = 1
                self.inputTeam1.isHidden = false
                self.blinkingTeam1(blink: self.blinkingMarker)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workitemteam2!)
         }
     }
    
    func blinkingTeam2 (blink: Int) {
         if (blink == 1) {
            workitemteam3 = DispatchWorkItem {
                self.blinkingMarker = 2
                self.inputTeam2.isHidden = true
                self.blinkingTeam2(blink: self.blinkingMarker)
            }
                DispatchQueue.main.asyncAfter (deadline: .now() + 0.5, execute: workitemteam3!)
         } else if (blink == 2){
            workitemteam4 = DispatchWorkItem {
                self.blinkingMarker = 1
                self.inputTeam2.isHidden = false
                self.blinkingTeam2(blink: self.blinkingMarker)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workitemteam4!)
         }
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))

        inputTeam2.delegate = self
        inputTeam1.delegate = self
        inputTeam1.text = NSLocalizedString("Team 1", comment: "")
        inputTeam2.text = NSLocalizedString("Team 2", comment: "")
        serviceBallImg.isHidden = true
        serviceBall2Img.isHidden = true
        timeoutStart.isHidden = false
        timeoutStop.isHidden = true
        finalWhistleButton.isEnabled = false
        select_service1.isHidden = true
        select_service2.isHidden = true
        changeSides()
        popTip.bubbleColor = .white
        popTip.textColor = UIColor(red:1.00, green:0.40, blue:0.00, alpha:0.8)
        popTip.shouldDismissOnTap = true
    }
}

