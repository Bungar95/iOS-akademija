//
//  SecondViewController.swift
//  Predavanja
//
//  Created by Borna Ungar on 11.06.2021..
//

import UIKit

class SecondViewController: UIViewController {
    
    private let bottomSheet: UIView = {
        let bottomSheet = UIView()
        bottomSheet.backgroundColor = .white
        bottomSheet.translatesAutoresizingMaskIntoConstraints = false
        bottomSheet.layer.cornerRadius = 20
        return bottomSheet
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Quicksand-Medium", size: 21)
        label.textColor = UIColor(named: "Calypso")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(smallBreak: String?, bigBreak: String?, bigBreakTime: String?, inputTime: String?) {
        super.init(nibName: nil, bundle: nil)
        setSafeInput(smallBreak: smallBreak, bigBreak: bigBreak, bigBreakTime: bigBreakTime, inputTime: inputTime)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setSafeInput(smallBreak: String?, bigBreak: String?, bigBreakTime: String?, inputTime: String?){
        
        guard let safeSmallBreak = smallBreak, !safeSmallBreak.isEmpty else {
            label.text = "Unos malog odmora je prazan."
            return
        }
        
        guard let nSmallBreak = Int(safeSmallBreak) else {
            label.text = "Unos malog odmora nije broj."
            return
        }
        
        guard let safeBigBreak = bigBreak, !safeBigBreak.isEmpty else {
            label.text = "Unog velikog odmora je prazan."
            return
        }
        
        guard let nBigBreak = Int(safeBigBreak) else {
            label.text = "Unos velikog odmora nije broj."
            return
        }
        
        guard let safeBigBreakTime = bigBreakTime, !safeBigBreakTime.isEmpty else {
            label.text = "Unos termina velikog odmora je prazan."
            return
        }
        
        guard let nBigBreakTime = Int(safeBigBreakTime) else {
            label.text = "Unos termina velikog odmora nije broj."
            return
        }
        
        guard let safeInputTime = inputTime, !safeBigBreak.isEmpty else {
            label.text = "Unos zadanog vremena je prazan."
            return
        }
        
        let nClass = Classes()
        
        label.text = nClass.classAlgorithm(smallBreakLength: nSmallBreak, bigBreakLength: nBigBreak, bigBreakAppointment: nBigBreakTime, inputTime: safeInputTime)
        
    }
    
    private func setupUI() {
        title = "Predavanja"
        view.backgroundColor = UIColor(named: "Black0.3")
        view.addSubview(bottomSheet)
        
        bottomSheet.addSubview(label)
        
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
        
        let labelTopConstraint = label.topAnchor.constraint(equalTo: bottomSheet.topAnchor, constant: 100)
        labelTopConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            
            labelTopConstraint,
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            label.centerXAnchor.constraint(equalTo: bottomSheet.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: bottomSheet.centerYAnchor)
            
            
        ])
        
    }
    
}

