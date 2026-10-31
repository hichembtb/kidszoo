//
//  mainViewAppBar.swift
//  kidsZoo
//
//  Created by hachemibtb on 6/8/2026.
//

import SwiftUI

struct mainViewAppBar: View {
    @AppStorage("Paging") var paging: Int = 0

    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            // Player avatar token
            ZStack {
                Circle()
                    .fill(WoodlandPalette.whiteCream)
                    .frame(width: 46, height: 46)
                    .overlay(
                        Circle()
                            .stroke(WoodlandPalette.softSage, lineWidth: 1.5)
                    )

                Image("avatar")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }

            Spacer()

            // Title & Level Badge
            VStack(spacing: 3) {
                Text("Little Wilds")
                    .font(.system(size: 24, weight: .bold, design: .serif))
                    .foregroundColor(WoodlandPalette.forestGreen)

                Text("Find the animals!")
                    .font(.system(size: 10, weight: .heavy, design: .rounded))
                    .tracking(1.0)
                    .foregroundColor(.white)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 3)
                    .background(
                        Capsule()
                            .fill(WoodlandPalette.terracotta)
                    )
            }

            Spacer()

            // Settings button
            Button {
                // Settings action
            } label: {
                ZStack {
                    Circle()
                        .fill(WoodlandPalette.whiteCream)
                        .frame(width: 46, height: 46)
                        .overlay(
                            Circle()
                                .stroke(WoodlandPalette.softSage, lineWidth: 1.5)
                        )

                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(WoodlandPalette.forestGreen)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 4)
        .padding(.bottom, 6)
    }
}

#Preview {
    mainViewAppBar()
}
