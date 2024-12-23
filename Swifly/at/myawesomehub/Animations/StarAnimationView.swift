//
//  StarAnimationView.swift
//  at/myawesomehub
//
//  Created by Mohammad Yasir on 23/12/24.
//

import SwiftUI

struct StarAnimationView: View {
    @State private var stars: [Star] = []
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(stars) { star in
                    Circle()
                        .fill(star.color)
                        .frame(width: star.size, height: star.size)
                        .position(x: star.x, y: star.y)
                }
            }
            .background(Color.black)
            .onAppear {
                stars = createStars(in: geometry.size)
                startAnimation(in: geometry.size)
            }
        }
    }
    
    func createStars(in size: CGSize) -> [Star] {
        var stars: [Star] = []
        let centerX = size.width / 2
        let centerY = size.height / 2
        let exclusionRadius = min(size.width, size.height) / 4
        
        for _ in 0..<300 {
            var randomX: CGFloat = 0
            var randomY: CGFloat = 0
            repeat {
                randomX = CGFloat.random(in: 0...size.width)
                randomY = CGFloat.random(in: 0...size.height)
            } while distance(from: CGPoint(x: centerX, y: centerY), to: CGPoint(x: randomX, y: randomY)) < exclusionRadius
            
            let randomSize = CGFloat.random(in: 1...4)
            let randomSpeed = CGFloat.random(in: 1.5...4)
            let randomColor = Color(
                red: Double.random(in: 0.5...1),
                green: Double.random(in: 0.5...1),
                blue: Double.random(in: 0.5...1)
            )
            
            let star = Star(x: randomX, y: randomY, size: randomSize, speed: randomSpeed, color: randomColor)
            stars.append(star)
        }
        return stars
    }
    
    func startAnimation(in size: CGSize) {
        for index in stars.indices {
            let delay = Double.random(in: 0...1)
            let speedMultiplier = stars[index].speed
            let originalSize = stars[index].size
            withAnimation(Animation.linear(duration: speedMultiplier).repeatForever(autoreverses: false).delay(delay)) {
                stars[index].x = size.width / 2
                stars[index].y = size.height / 2
                stars[index].size = originalSize * 0.1
            }
        }
    }
    
    func distance(from p1: CGPoint, to p2: CGPoint) -> CGFloat {
        let dx = p1.x - p2.x
        let dy = p1.y - p2.y
        return sqrt(dx * dx + dy * dy)
    }
}

struct Star: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var speed: CGFloat
    var color: Color
}

