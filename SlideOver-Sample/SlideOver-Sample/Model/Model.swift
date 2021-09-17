//
//  Section.swift
//  SlideOver-Sample
//
//  Created by k-aoki on 2021/09/16.
//

import Foundation

struct Model {

    private(set) var placeNames = [
        "Yosemite",
        "Yellowstone",
        "Theodore Roosevelt",
        "Sequoia",
        "Pinnacles",
        "Mount Rainier",
        "Mammoth Cave",
        "Great Basin",
        "Grand Canyon"
    ]

    // structへの移動処理
    mutating func moveItem(at sourceIndex: Int, to destinationIndex: Int) {
        guard sourceIndex != destinationIndex else { return }

        let place = placeNames[sourceIndex]
        placeNames.remove(at: sourceIndex)
        placeNames.insert(place, at: destinationIndex)
    }

    // structへの追加処理
    mutating func addItem(_ place: String, at index: Int) {
        placeNames.insert(place, at: index)
    }
}
