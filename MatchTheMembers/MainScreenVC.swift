//
//  MainScreenVC.swift
//  MatchTheMembers
//
//  Created by Ian Shen on 2/5/20.
//  Copyright © 2020 Ian Shen. All rights reserved.
//

import UIKit

class MainScreenVC: UIViewController {
    
    @IBOutlet weak var pauseResumeButton: UIButton!
    
    @IBOutlet weak var nameButton1Title: UIButton!
    
    @IBOutlet weak var nameButton2Title: UIButton!
    
    @IBOutlet weak var nameButton3Title: UIButton!
    
    @IBOutlet weak var nameButton4Title: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var memberImageView: UIImageView!
    
    var inPlay: Bool = false
    var statsPressed: Bool = false
    var points: Int = 0
    var nameButtonArr: [UIButton] = []
    var correctButton: Int = 0
    var currentStreak: Int = 0
    var maxStreak: Int = 0
    var nameHistory: [String] = ["-","-","-"]
    var ansHistory: [String] = ["-","-","-"]
    var correctName: String = ""
    var correctNameId: Int = 0
    

    
    var timeLeft = 5
    var timer = Timer()
    var isTimerRunning = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameButtonArr = [nameButton1Title, nameButton2Title, nameButton3Title, nameButton4Title]
        
        startQuestion()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        runTimer()
    }
    
    func startQuestion() {
        inPlay = true
        statsPressed = false
        timeLeft = 5
        timeLabel.text = "\(timeLeft)"
        runTimer()
        buildGamePanel()
    }
    
    func buildGamePanel() {
        correctNameId = Int.random(in: 0..<Constants.names.count)
        correctName = Constants.names[correctNameId]
        let memberImage: UIImage = Constants.getImageFor(name: correctName)
        let mdbBlue = UIColor(red: 54/255, green: 113/255, blue: 253/255, alpha: 0.8)
        
        memberImageView.image = memberImage
        
        correctButton = Int.random(in: 0...3)
        for i in 0..<nameButtonArr.count {
            if i == correctButton {
                nameButtonArr[i].setTitle(correctName, for: [])
            } else {
                var currentNameId = Int.random(in: 0..<Constants.names.count)
                while currentNameId == correctNameId {
                    currentNameId = Int.random(in: 0..<Constants.names.count)
                }
                nameButtonArr[i].setTitle(Constants.names[currentNameId], for: [])
            }
            nameButtonArr[i].titleLabel?.textAlignment = NSTextAlignment.center
            nameButtonArr[i].backgroundColor = mdbBlue
            nameButtonArr[i].layer.borderColor = UIColor.black.cgColor
            nameButtonArr[i].layer.cornerRadius = 10
        }
        
        scoreLabel.text = "\(points)"
    }
    
    func runTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(MainScreenVC.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if timeLeft > 0 {
            timeLeft -= 1
        } else {
            showOutOfTime()
        }
        timeLabel.text = "\(timeLeft)"
    }
    
    func showOutOfTime() {
        currentStreak = 0
        timer.invalidate()
        for i in 0..<nameButtonArr.count {
            if i == correctButton {
                nameButtonArr[i].backgroundColor = UIColor.green
            }
            else {
                nameButtonArr[i].backgroundColor = UIColor.red
            }
        }
        recordAnswer(correct: false)
        restAfterAnswer()
    }
    
    func restAfterAnswer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(MainScreenVC.nextQuestion)), userInfo: nil, repeats: false)
    }
    
    @objc func nextQuestion() {
        startQuestion()
    }
    func recordAnswer(correct cor: Bool) {
        nameHistory.remove(at: 2)
        nameHistory.insert(correctName, at: 0)
        ansHistory.remove(at: 2)
        if cor {
            ansHistory.insert("Correct", at: 0)
        } else {
            ansHistory.insert("Wrong", at: 0)
        }
    }
    
    func showCorrectAnswer() {
        points += 1
        currentStreak += 1
        if currentStreak > maxStreak {
            maxStreak = currentStreak
        }
        nameButtonArr[correctButton].backgroundColor = UIColor.green
        recordAnswer(correct: true)
        restAfterAnswer()
    }
    
    func ShowWrongAnswer(pressed wrongButtonID: Int) {
        currentStreak = 0
        nameButtonArr[correctButton].backgroundColor = UIColor.green
        nameButtonArr[wrongButtonID].backgroundColor = UIColor.red
        recordAnswer(correct: false)
        restAfterAnswer()
    }
    
    @IBAction func restartTapped(_ sender: Any) {
        inPlay = false
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pauseResumeTapped(_ sender: Any) {
        var PRButtonTitle: String
        if inPlay == false {
            //Resuming the game
            inPlay = true
            runTimer()
            PRButtonTitle = "Pause"
            points = 0
        } else {
            //Pausing the game
            inPlay = false
            timer.invalidate()
            PRButtonTitle = "Resume"
        }
        pauseResumeButton.setTitle(PRButtonTitle, for: [])
        scoreLabel.text = "\(points)"
    }
    
    func pauseGame() {
        var PRButtonTitle: String
        if inPlay{
            //Pausing the game
            inPlay = false
            timer.invalidate()
            PRButtonTitle = "Resume"
        } else {
            //Resuming the game
            inPlay = true
            PRButtonTitle = "Pause"
            if !statsPressed {
                points = 0
            }
            runTimer()
        }
        if !statsPressed {
            pauseResumeButton.setTitle(PRButtonTitle, for: [])
        }
        scoreLabel.text = "\(points)"
    }

    @IBAction func nameButton1Pressed(_ sender: Any) {
        if inPlay == false {
            return
        }
        else if correctButton == 0 {
            //correct
            showCorrectAnswer()
        } else {
            //wrong
            ShowWrongAnswer(pressed: 0)
        }
        scoreLabel.text = "\(points)"
    }
    
    @IBAction func nameButton2Pressed(_ sender: Any) {
        if inPlay == false {
            return
        }
        else if correctButton == 1 {
            //correct
            showCorrectAnswer()
        } else {
            //wrong
            ShowWrongAnswer(pressed: 1)
        }
        scoreLabel.text = "\(points)"
    }
    
    @IBAction func nameButton3Pressed(_ sender: Any) {
        if inPlay == false {
            return
        }
        else if correctButton == 2 {
            //correct
            showCorrectAnswer()
        } else {
            //wrong
            ShowWrongAnswer(pressed: 2)
        }
        scoreLabel.text = "\(points)"
    }
    
    @IBAction func nameButton4Pressed(_ sender: Any) {
        if inPlay == false {
            return
        }
        else if correctButton == 3 {
            //correct
            showCorrectAnswer()
        } else {
            //wrong
            ShowWrongAnswer(pressed: 3)
        }
        scoreLabel.text = "\(points)"
    }
    
    @IBAction func statsButtonPressed(_ sender: Any) {
        statsPressed = true
        pauseGame()
        inPlay = true
        self.performSegue(withIdentifier: "toStatisticsScreenVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.modalPresentationStyle = .fullScreen
        if let destinationVC = segue.destination as? StatisticsScreenVC {
            destinationVC.streak = maxStreak
            destinationVC.nameHis = nameHistory
            destinationVC.ansHis = ansHistory
        }
    }

}
