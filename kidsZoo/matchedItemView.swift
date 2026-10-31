//
//  matchedItemView.swift
//  kidsZoo
//
//  Created by hachemibtb on 31/10/2026.
//

import SwiftUI

struct matchedItemView: View {

    // Properties
    @Binding var animalsArrayImagesName: [String]
    @Binding var selectedItems: [Int]
    @Binding var matchedItems: Set<Int>
    @Binding var moves: Int

    let onRestart: () -> Void

    private let gridSpacing: CGFloat = 12

    private var gridLayoutColumn: [GridItem] {
        [
            GridItem(.flexible(), spacing: gridSpacing),
            GridItem(.flexible(), spacing: gridSpacing),
            GridItem(.flexible(), spacing: gridSpacing)
        ]
    }

    @State private var isCheckingMatch = false

    // Game progress helpers
    private var pairsFound: Int {
        matchedItems.count / 2
    }

    private var totalPairs: Int {
        max(1, animalsArrayImagesName.count / 2)
    }

    private var isGameComplete: Bool {
        matchedItems.count == animalsArrayImagesName.count && !animalsArrayImagesName.isEmpty
    }

    private var progressFraction: CGFloat {
        CGFloat(pairsFound) / CGFloat(totalPairs)
    }

    // Body
    var body: some View {

        VStack(spacing: 14) {

            // Statistics & Progress Card
            HStack(spacing: 14) {
                // Pairs count
                VStack(alignment: .leading, spacing: 2) {
                    Text("PAIRS")
                        .font(.system(size: 9, weight: .bold, design: .rounded))
                        .tracking(0.8)
                        .foregroundColor(WoodlandPalette.forestGreen.opacity(0.7))

                    Text("\(pairsFound)/\(totalPairs)")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(WoodlandPalette.forestGreen)
                }

                // Progress Bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(WoodlandPalette.softSage.opacity(0.35))
                            .frame(height: 8)

                        Capsule()
                            .fill(WoodlandPalette.mossOlive)
                            .frame(width: max(0, min(geo.size.width, geo.size.width * progressFraction)), height: 8)
                            .animation(.spring(response: 0.35, dampingFraction: 0.75), value: progressFraction)
                    }
                    .frame(height: geo.size.height)
                }
                .frame(height: 8)

                // Moves count
                VStack(alignment: .trailing, spacing: 2) {
                    Text("MOVES")
                        .font(.system(size: 9, weight: .bold, design: .rounded))
                        .tracking(0.8)
                        .foregroundColor(WoodlandPalette.forestGreen.opacity(0.7))

                    Text("\(moves)")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(WoodlandPalette.forestGreen)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(WoodlandPalette.whiteCream)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(WoodlandPalette.softSage.opacity(0.6), lineWidth: 1)
                    )
            )
            .padding(.horizontal, 20)

            // Matching Grid
            LazyVGrid(columns: gridLayoutColumn, spacing: gridSpacing) {
                ForEach(animalsArrayImagesName.indices, id: \.self) { item in
                    cardView(for: item)
                }
            }
            .padding(.horizontal, 20)

            // Game Completion Message Banner
            if isGameComplete {
                VStack(spacing: 4) {
                    Text("Splendid!")
                        .font(.system(size: 20, weight: .bold, design: .serif))
                        .foregroundColor(WoodlandPalette.forestGreen)

                    Text("Congratulations! You found all the matches in \(moves) moves.")
                        .font(.system(.footnote, design: .rounded, weight: .semibold))
                        .foregroundColor(WoodlandPalette.deepGreen)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(WoodlandPalette.whiteCream)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .stroke(WoodlandPalette.softSage, lineWidth: 1.5)
                        )
                )
                .padding(.horizontal, 20)
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }

            // Bottom Action Controls: Restart & Hint
            HStack(spacing: 16) {
                // Restart Button
                Button(action: onRestart) {
                    HStack(spacing: 6) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 13, weight: .semibold))
                        Text("Restart")
                            .font(.system(.subheadline, design: .rounded, weight: .semibold))
                    }
                    .foregroundColor(WoodlandPalette.forestGreen)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 9)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(WoodlandPalette.forestGreen, lineWidth: 1.5)
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(WoodlandPalette.whiteCream.opacity(0.85))
                            )
                    )
                }

                // Hint Button
                Button(action: provideHint) {
                    HStack(spacing: 6) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 13, weight: .semibold))
                        Text("Hint")
                            .font(.system(.subheadline, design: .rounded, weight: .bold))
                    }
                    .foregroundColor(WoodlandPalette.terracotta)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 9)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(WoodlandPalette.peach.opacity(0.35))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(WoodlandPalette.terracotta.opacity(0.55), lineWidth: 1.5)
                            )
                    )
                }
            }
            .padding(.top, 4)
        }
    }

    // Card View Builder
    @ViewBuilder
    private func cardView(for index: Int) -> some View {
        let isMatched = matchedItems.contains(index)
        let isSelected = selectedItems.contains(index)
        let isRevealed = isMatched || isSelected

        ZStack(alignment: .topTrailing) {
            if isRevealed {
                // Face-up Revealed Animal Card
                Image(animalsArrayImagesName[index])
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(
                                isMatched
                                ? WoodlandPalette.mossOlive
                                : WoodlandPalette.terracotta,
                                lineWidth: 2.5
                            )
                    )

                if isMatched {
                    // Checkmark indicator for matched pair
                    ZStack {
                        Circle()
                            .fill(WoodlandPalette.mossOlive)
                            .frame(width: 20, height: 20)

                        Image(systemName: "checkmark")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(5)
                }
            } else {
                // Face-down Forest Green Cardback
                Image("cardback")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(WoodlandPalette.forestGreen.opacity(0.25), lineWidth: 1)
                    )
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .onTapGesture {
            selectItem(index)
        }
        .disabled(isRevealed || isCheckingMatch)
    }

    // Handle image selection
    private func selectItem(_ index: Int) {

        // Ignore taps on already matched cards
        guard !matchedItems.contains(index) else {
            return
        }

        // Ignore taps while checking a pair
        guard !isCheckingMatch else {
            return
        }

        // Ignore selecting the same card twice
        guard !selectedItems.contains(index) else {
            return
        }

        selectedItems.append(index)

        // Check the pair when two cards are selected
        if selectedItems.count == 2 {
            moves += 1
            checkMatch()
        }
    }

    // Check whether the two images match
    private func checkMatch() {

        guard selectedItems.count == 2 else {
            return
        }

        let firstIndex = selectedItems[0]
        let secondIndex = selectedItems[1]

        let firstImage = animalsArrayImagesName[firstIndex]
        let secondImage = animalsArrayImagesName[secondIndex]

        if firstImage == secondImage {

            // Match found: keep both images visible
            matchedItems.insert(firstIndex)
            matchedItems.insert(secondIndex)

            selectedItems.removeAll()

        } else {

            // No match: hide both images after a short delay
            isCheckingMatch = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

                selectedItems.removeAll()
                isCheckingMatch = false
            }
        }
    }

    // Provide a brief hint by temporarily flashing an unmatched pair
    private func provideHint() {
        guard !isCheckingMatch, matchedItems.count < animalsArrayImagesName.count else {
            return
        }

        // Find the first unmatched animal
        for i in animalsArrayImagesName.indices {
            if !matchedItems.contains(i) {
                let targetAnimal = animalsArrayImagesName[i]
                let pairIndices = animalsArrayImagesName.indices.filter { animalsArrayImagesName[$0] == targetAnimal }
                if pairIndices.count == 2 {
                    selectedItems = pairIndices
                    isCheckingMatch = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        selectedItems.removeAll()
                        isCheckingMatch = false
                    }
                    break
                }
            }
        }
    }
}

#Preview {
    matchedItemView(
        animalsArrayImagesName: .constant(["fox", "owl", "bear", "rabbit", "raccoon", "hedgehog", "fox", "owl", "bear", "rabbit", "raccoon", "hedgehog"]),
        selectedItems: .constant([]),
        matchedItems: .constant([]),
        moves: .constant(0),
        onRestart: {}
    )
}
