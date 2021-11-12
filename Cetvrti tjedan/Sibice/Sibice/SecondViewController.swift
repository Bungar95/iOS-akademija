//
//  SecondViewController.swift
//  Sibice
//
//  Created by Borna Ungar on 11.06.2021..
//

import UIKit

class SecondViewController: UIViewController {
    
    let matchesPerNumbers: Array<Int> = [6, 2, 5, 5, 4, 5, 6, 3, 7, 6]
    private var numMatches = 0
    
    private let viewForImages: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
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
        label.text = "Najveći prirodni broj je:"
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(enteredString1: String?, enteredString2: String?) {
        super.init(nibName: nil, bundle: nil)
        checkNumber(number: enteredString1, matches: enteredString2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = "Šibice"
        super.viewDidLoad()
        setupUI()
        
        
    }
    
    private func checkNumber(number enteredString1: String?, matches enteredString2: String?) {
        
        guard let safeNumberString = enteredString1 else { return }
        guard let safeInt = Int(safeNumberString) else { return }
        
        guard let safeMatchesString = enteredString2 else { return }
        guard let safeMatchesInt = Int(safeMatchesString) else { return }
        
        for i in 0...safeInt {
            
            let iString: String = String(i)
            
            for j in iString {
                let x: String = String(j)
                numMatches += matchesPerNumbers[Int(x) ?? 0]
            }
            
        }
        
        label1.text = "Ukupan broj šibica potrebnih za prikaz svih brojeva je: \(numMatches)"
        
        biggestNumberAvailable(n: safeInt, nAsString: safeNumberString, matchesAvailable: safeMatchesInt)
        
    }
    
    private func biggestNumberAvailable(n: Int, nAsString: String, matchesAvailable: Int) {
        
        for i in (0...n).reversed() {
            var matchesNeeded = 0
            for j in String(i) {
                let x: String = String(j)
                matchesNeeded += matchesPerNumbers[Int(x) ?? 0]
            }
            if (matchesNeeded<=matchesAvailable){
                
                makeMatchesImage(n: String(i))
                return
            }
            
        }
        
    }
    
    private func makeMatchesImage(n: String) {
        
        var position = 0
        
        for i in n {
            let imageName = "\(i)"
            let image = UIImage(named: imageName)
            let imageView: UIImageView = UIImageView(image: image)
            imageView.frame = CGRect(x: position, y: 0, width: 70, height: 105)
            // add to parent view
            viewForImages.addSubview(imageView)
            position += 75
        
        }
    }
    
    private func setupUI() {
        title = "Šibice"
        view.backgroundColor = .white
        
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
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 30),
            label2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            label2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            viewForImages.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 20),
            viewForImages.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            viewForImages.widthAnchor.constraint(equalTo: view.widthAnchor)
            
        ])
    }
    
    
}
