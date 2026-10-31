//
//  mainPage.swift
//  kidsZoo
//
//  Created by hachemibtb on 26/7/2026.
//

import SwiftUI

struct mainView: View {
    // Properties
    @AppStorage("Paging") var paging: Int = 0

    @State var animalsArrayImagesName: [String] = [
        "fox", "owl", "bear", "rabbit", "raccoon", "hedgehog",
        "fox", "owl", "bear", "rabbit", "raccoon", "hedgehog"
    ].shuffled()

    @State var selectedItems: [Int] = []
    @State var matchedItems: Set<Int> = []
    @State var moves: Int = 0
    @State var canUseHint: Bool = true

    // Body
    var body: some View {
        ZStack {
            WoodlandPalette.canvasCream
                .ignoresSafeArea()

            // 2. Decorative Background Layer (Positioned independently, behind interactive UI)
            GeometryReader { proxy in
                let screenWidth = proxy.size.width
                let screenHeight = proxy.size.height

                ZStack(alignment: .topLeading) {
                    // Top-Left Tree Foliage & Canopy Branch
                    Image("woodland_branch")
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: min(screenWidth , 400),
                            height: min(screenHeight * 0.22, 190),
                            alignment: .center
                        )
                        .clipped()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    

                    // Bottom Woodland Landscape
                    Image("woodland_landscape")
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: screenWidth,
                            height: min(screenHeight , 100),
                            alignment: .bottom
                        )
                        .clipped()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                }
            }
            .ignoresSafeArea()
            .allowsHitTesting(false)

            // 3. Interactive Game Screen Content
            VStack(spacing: 0) {
                mainViewAppBar()

                Spacer(minLength: 4)

                matchedItemView(
                    animalsArrayImagesName: $animalsArrayImagesName,
                    selectedItems: $selectedItems,
                    matchedItems: $matchedItems,
                    moves: $moves,
                    canUseHint: $canUseHint ,
                    onRestart: restartGame
                )

                Spacer(minLength: 12)
            }
        }
    }

    // Reset and reshuffle game
    private func restartGame() {
        withAnimation(.easeInOut(duration: 0.2)) {
            selectedItems.removeAll()
            matchedItems.removeAll()
            moves = 0
            canUseHint = true
            animalsArrayImagesName.shuffle()
        }
    }
}

#Preview {
    mainView()
}
