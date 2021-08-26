//
//  Egg.swift
//  EierML-ios
//
//  Created by Torben Köhler on 12.08.21.
//

import Foundation

struct Egg: Identifiable, Codable {
    let id: UUID
    var number: Int
    var height: Int
    var width: Int
    var viscosity: Int
    var time: Int
    // MARK: init without ML
    init(
        number: Int,
        height: Int,
        width: Int,
        viscosity: Int,
        time: Int
    ) {
        self.id = UUID()
        self.number = number
        self.height = height
        self.width = width
        self.viscosity = viscosity
        self.time = time
    }
    // MARK: init with ML
    init(
        number: Int,
        height: Int,
        width: Int,
        viscosity: Int
    ) {
        self.id = UUID()
        self.number = number
        self.height = height
        self.width = width
        self.viscosity = viscosity
        self.time = EierML.predict_v1(
            height: height,
            width: width,
            viscosity: viscosity
        )
    }
    var timeInMinutes: String {
        if time.isMultiple(of: 60) {
            return "\(time/60)"
        } else {
            return String(format: "%.1f", Double(time)/60)
        }
    }
    static var mock: Self {
        .init(
            number: 1,
            height: Int.random(in: 44...65),
            width: Int.random(in: 40...45),
            viscosity: Int.random(in: 1...10),
            time: 180
        )
    }
}
