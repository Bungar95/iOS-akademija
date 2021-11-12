//
//  LoaderDelegate.swift
//  MoviesMVVM
//
//  Created by Borna Ungar on 13.07.2021..
//

import Foundation

protocol LoaderDelegate: AnyObject {
    func showLoader()
    func hideLoader()
}
