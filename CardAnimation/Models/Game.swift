//
//  Game.swift
//  CardAnimation
//
//  Created by Mohammed Skaik on 30/08/2023.
//

import Foundation

struct Game {
    var id: String = UUID().uuidString
    var rating: CGFloat
    var date: Date

    init(rating: CGFloat, date: Date) {
        self.rating = rating//.rounded()
        self.date = date
    }

    static func > (next: Game, previous: Game) -> Bool {
        return previous.date > next.date
    }
}
