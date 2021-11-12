//
//  SecondViewController.swift
//  iOS_elements (za prvi secondviewcontroller koji sam radio sam copy pasteo s ios_elements kao template)
//
//  Created by definitivno ne Danijel Trifunović on 25.02.2021..
//

import UIKit

fileprivate let defaultLabelString = "Igra je završena. Rezultati:"

class SecondViewController: UIViewController {
    
    private let bottomSheet: UIView = {
        let bottomSheet = UIView()
        bottomSheet.backgroundColor = .white
        bottomSheet.translatesAutoresizingMaskIntoConstraints = false
        bottomSheet.layer.cornerRadius = 20
        return bottomSheet
    }()
    
    private let label1: UILabel = {
        let label = UILabel()
        label.text = defaultLabelString
        label.font = UIFont(name: "Quicksand-Regular", size: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.text = "Igrač koji je završio igru"
        label.font = UIFont(name: "Quicksand-Regular", size: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label3: UILabel = {
        let label = UILabel()
        label.text = "Koliko je puta igra promijenila smjer"
        label.font = UIFont(name: "Quicksand-Regular", size: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label4: UILabel = {
        let label = UILabel()
        label.text = "Koliko se puta preskočio igrač u igri"
        label.font = UIFont(name: "Quicksand-Regular", size: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rectangleForLabel2: UILabel = {
        let rectangle = UILabel()
        rectangle.text = "X"
        rectangle.backgroundColor = UIColor(named: "DiSerria")
        rectangle.font = UIFont(name: "Quicksand-Medium", size: 21)
        rectangle.textColor = .white
        rectangle.textAlignment = .center
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        return rectangle
    }()
    
    private let rectangleForLabel3: UILabel = {
        let rectangle = UILabel()
        rectangle.text = "X"
        rectangle.backgroundColor = UIColor(named: "DiSerria")
        rectangle.font = UIFont(name: "Quicksand-Medium", size: 21)
        rectangle.textColor = .white
        rectangle.textAlignment = .center
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        return rectangle
    }()
    
    private let rectangleForLabel4: UILabel = {
        let rectangle = UILabel()
        rectangle.text = "X"
        rectangle.backgroundColor = UIColor(named: "DiSerria")
        rectangle.font = UIFont(name: "Quicksand-Medium", size: 21)
        rectangle.textColor = .white
        rectangle.textAlignment = .center
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        return rectangle
    }()
    
    init(numberN: String?, playerNumber: String?, directionNumber: String?, skipNumber: String?) {
        super.init(nibName: nil, bundle: nil)
        setSafeNumbers(n: numberN, players: playerNumber, direction: directionNumber, skip: skipNumber)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setSafeNumbers(n: String?, players: String?, direction: String?, skip: String?){
        
        guard let safeN = n, !safeN.isEmpty else {
            label1.text = "Input of N was empty."
            return
        }
        
        guard let nNumber = Int(safeN) else {
            label1.text = "Input of N wasn't an integer."
            return
        }
        
        guard let safePlayers = players, !safePlayers.isEmpty else {
            label1.text = "Input of players was empty."
            return
        }
        
        guard let playersNumber = Int(safePlayers) else {
            label1.text = "Input of players wasn't an integer."
            return
        }
        
        guard let safeDirection = direction, !safeDirection.isEmpty else {
            label1.text = "Input of direction was empty."
            return
        }
        
        guard let directionNumber = Int(safeDirection) else {
            label1.text = "Input of direction wasn't an integer."
            return
        }
        
        guard let safeSkip = skip, !safeSkip.isEmpty else {
            label1.text = "Input of skip was empty."
            return
        }
        
        guard let skipNumber = Int(safeSkip) else {
            label1.text = "Input of skip wasn't an integer."
            return
        }
        
        playGame(n: nNumber, nOfPlayers: playersNumber, nDirection: directionNumber, nSkip: skipNumber)
        
    }
    
    private func playGame(n: Int, nOfPlayers: Int, nDirection: Int, nSkip: Int) {
        
        var clockwise = true
        var player = 0
        var i = 1
        var directionCounter = 0
        var skipCounter = 0
    
        while i < n {
            
            if i % nDirection == 0 {
                clockwise = changeDirection(direction: clockwise)
                directionCounter += 1
            }else if i % nSkip == 0{
                player = changePlayer(direction: clockwise, player: player)
                skipCounter += 1
            }
            
            player = changePlayer(direction: clockwise, player: player)
            i += 1
        }
        
        rectangleForLabel2.text = "\(player)"
        rectangleForLabel3.text = "\(directionCounter)"
        rectangleForLabel4.text = "\(skipCounter)"
        
    }
    
    func changePlayer(direction: Bool, player: Int) -> Int{
        
        var currentPlayer = player
        
        if direction {
            currentPlayer += 1
        }else{
            currentPlayer -= 1
        }
        
        if currentPlayer == 11 {
            currentPlayer = 1
        }else if currentPlayer == 0 {
            currentPlayer = 10
        }
        
        return currentPlayer
        
    }
    
    func changeDirection(direction: Bool) -> Bool{
        return !direction
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "Black0.3")
        view.addSubview(bottomSheet)
        
        bottomSheet.addSubviews([label1, label2, label3, label4, rectangleForLabel2, rectangleForLabel3, rectangleForLabel4])
        
        setupConstraints()
    }

    private func setupConstraints() {
        
        let sheetBottomConstraint = bottomSheet.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        sheetBottomConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            
            bottomSheet.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -309),
            bottomSheet.widthAnchor.constraint(equalTo: view.widthAnchor),
            sheetBottomConstraint
            
        ])
        
        let rect4BottomConstraint = rectangleForLabel4.bottomAnchor.constraint(equalTo: bottomSheet.bottomAnchor, constant: 35)
        rect4BottomConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            
            label1.topAnchor.constraint(equalTo: bottomSheet.topAnchor, constant: 35),
            label1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 10),
            label2.centerXAnchor.constraint(equalTo: label1.centerXAnchor),
            
            rectangleForLabel2.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 7),
            rectangleForLabel2.centerXAnchor.constraint(equalTo: label1.centerXAnchor),
            rectangleForLabel2.widthAnchor.constraint(equalToConstant: 35),
            rectangleForLabel2.heightAnchor.constraint(equalToConstant: 35),
            
            label3.topAnchor.constraint(equalTo: rectangleForLabel2.bottomAnchor, constant: 10),
            label3.centerXAnchor.constraint(equalTo: label1.centerXAnchor),
            
            rectangleForLabel3.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 7),
            rectangleForLabel3.centerXAnchor.constraint(equalTo: label3.centerXAnchor),
            rectangleForLabel3.widthAnchor.constraint(equalToConstant: 35),
            rectangleForLabel3.heightAnchor.constraint(equalToConstant: 35),
            
            label4.topAnchor.constraint(equalTo: rectangleForLabel3.bottomAnchor, constant: 10),
            label4.centerXAnchor.constraint(equalTo: label1.centerXAnchor),
            
            rectangleForLabel4.topAnchor.constraint(equalTo: label4.bottomAnchor, constant: 7),
            rectangleForLabel4.centerXAnchor.constraint(equalTo: label4.centerXAnchor),
            rectangleForLabel4.widthAnchor.constraint(equalToConstant: 35),
            rectangleForLabel4.heightAnchor.constraint(equalToConstant: 35),
            rect4BottomConstraint
            
        ])
    }
}
