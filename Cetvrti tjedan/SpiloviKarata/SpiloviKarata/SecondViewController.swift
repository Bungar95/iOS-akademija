//
//  SecondViewController.swift
//  SpiloviKarata
//
//  Created by Borna Ungar on 10.06.2021..
//

import UIKit

class SecondViewController: UIViewController {
    
    private let viewForImages: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let label1: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand-Regular", size: 15)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand-Regular", size: 15)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(n: Int) {
        super.init(nibName: nil, bundle: nil)
        runDecks(n: n)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Broj špilova karata"
        view.backgroundColor = .white
        
        /*
        for i in 0...31 {
            let imageName = "Group-\(i)"
            let image = UIImage(named: imageName)
            let imageView: UIImageView = UIImageView(image: image)

            // add to parent view
            viewForImages.addSubview(imageView)
        }
        
        print(viewForImages.subviews.count) */
        view.addSubviews([viewForImages, label1, label2])
        setupConstraints()
    }

    private func setupConstraints() {
        
        let label1TopConstraint = label1.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        label1TopConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
        
            label1TopConstraint,
            label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            label1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            label2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            label2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20),
            
            viewForImages.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 20),
            viewForImages.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
    }
    
    private func runDecks(n: Int) {
        
        var cardDeck: [String: Int] = [:]
        var foundFirstDeckFilled = false
        var cardThatFilledTheDeck = 0
        var numDecks = 0
        var i = 0
        
        while i < n {
            
            let num = Int.random(in: 1...32)
            
            if cardDeck.keys.contains("\(num)") {
                cardDeck["\(num)"]? += 1
            } else {
                cardDeck["\(num)"] = 1
            }
            
           i += 1
            
            if(cardDeck.count == 32 && cardDeck.allSatisfy{$0.value >= 1} && !foundFirstDeckFilled){
                //print("Deck is filled after the \(i). card")
                cardThatFilledTheDeck = i
                foundFirstDeckFilled = !foundFirstDeckFilled
            }
        }
        
        numDecks = checkDeckNumber(cardDeck: cardDeck)
        
        
        addTextFieldText(cardThatFilledTheDeck: cardThatFilledTheDeck, filledDecks: numDecks)
    }
    
    private func checkDeckNumber(cardDeck: [String: Int]) -> Int {
        if (cardDeck.count) == 32 {
           let numDecks = cardDeck.min{ a, b in a.value < b.value}
            guard let decks = numDecks else {return 0}
            return decks.value
        }
        return 0
    }
    
    private func wholeDeckFilled(key: String, value: Int) -> Bool {
        return value == 1
    }
    
    private func addTextFieldText(cardThatFilledTheDeck: Int, filledDecks: Int){
        
        if (filledDecks == 0){
            label1.text = "\u{2022} Nažalost, nasumičnim dodjeljivanjem karata, nije popunjen ni jedan špil karata."
            
            label2.text = "\u{2022} Probajte povećati broj karata za veće šanse."
        } else {
            label1.text = "\u{2022} Špil karata je uspješno sastavljen nakon \(cardThatFilledTheDeck) uspješnih špilova karata"
        
            label2.text = "\u{2022} \(filledDecks) uspješnih špilova karata"
        }
    }
    
}
