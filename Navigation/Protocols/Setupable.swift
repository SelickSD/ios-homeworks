//
//  Setupable.swift
//  Navigation
//
//  Created by Сергей Денисенко on 21.03.2022.
//

import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}
