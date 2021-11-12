//
//  SpilKarata.swift
//  SpiloviKarata
//
//  Created by Borna Ungar on 14.06.2021..
//

import UIKit

class SpilKarata: UIViewController {

    let size: CGFloat = 35.0

private let card0: UIImageView = {
    let cardView = UIImageView()
    cardView.image = UIImage(named: "Group-0")
    cardView.translatesAutoresizingMaskIntoConstraints = false
    return cardView
}()

private let card0Label : UILabel = {
    let countLabel = UILabel()
    countLabel.text = "5"
    countLabel.textColor = .white
    countLabel.textAlignment = .center
    countLabel.font = UIFont(name: "Quicksand-Bold", size: 13)
    countLabel.bounds = CGRect(x: 0.0, y: 0.0, width: SpilKarata().size, height: SpilKarata().size)
    countLabel.layer.cornerRadius = SpilKarata().size / 2
    countLabel.layer.borderWidth = 3.0
    countLabel.backgroundColor = .black
    return countLabel
}()
    
}
