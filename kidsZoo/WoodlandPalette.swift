//
//  WoodlandPalette.swift
//  kidsZoo
//
//  Created for Little Wilds Redesign.
//

import SwiftUI

enum WoodlandPalette {
    static let canvasCream = Color(hex: 0xFCF4E4)
    static let warmIvory = Color(hex: 0xFCECE4)
    static let forestGreen = Color(hex: 0x2C442C)
    static let deepGreen = Color(hex: 0x344C34)
    static let mossOlive = Color(hex: 0x6F8150)
    static let softSage = Color(hex: 0xC4C4A4)
    static let paleSage = Color(hex: 0xC4D4C4)
    static let peach = Color(hex: 0xFCD4B4)
    static let softApricot = Color(hex: 0xFCDCAC)
    static let terracotta = Color(hex: 0xC96549)
    static let barkBrown = Color(hex: 0xAC6C3C)
    static let cardCream = Color(hex: 0xFCE4C4)
    static let whiteCream = Color(hex: 0xFFF9ED)
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255.0,
            green: Double((hex >> 8) & 0xff) / 255.0,
            blue: Double(hex & 0xff) / 255.0,
            opacity: alpha
        )
    }
}

