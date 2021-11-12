//
//  SupportCode.swift
//  RxExercise
//
//  Created by Borna Ungar on 21.07.2021..
//

import Foundation
public func example(of description: String, action: () -> Void)
{
    print("\n--- Example of:", description, "---")
    action()
}
