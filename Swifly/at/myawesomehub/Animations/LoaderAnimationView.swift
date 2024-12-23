//
//  LoaderAnimationView.swift
//  at/myawesomehub
//
//  Created by Mohammad Yasir on 23/12/24.
//

import SwiftUI

struct LoaderAnimationView: View {
    var body: some View {
        VStack {
            CircularRectanglesView()
                .colorScheme(.dark)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.init(hex: "141414").ignoresSafeArea())
    }
}

struct ProgressLine: Identifiable {
    var id: String = UUID().uuidString
    var length: CGFloat
    var gradient: LinearGradient
}

struct CircularRectanglesView: View {
    let numberOfRectangles = 100
    let circleRadius: CGFloat = 130
    let rectangleWidth: CGFloat = 4
    @State private var lines: [ProgressLine] = Array(repeating: .init(length: 25, gradient: LinearGradient(colors: [.init(hex: "141414"), .init(hex: "5A5A5A")], startPoint: .bottom, endPoint: .top)), count: 100)
    @State private var progressValue: Int = 0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            ForEach(lines.indices, id: \.self) { index in
                let line = lines[index]
                let angle = Angle(degrees: Double(index) / Double(numberOfRectangles) * 360)
                let xOffset = cos(angle.radians) * (circleRadius + line.length / 2)
                let yOffset = sin(angle.radians) * (circleRadius + line.length / 2)
                
                line.gradient
                    .frame(width: rectangleWidth, height: line.length)
                    .cornerRadius(2)
                    .rotationEffect(angle + Angle(degrees: 90))
                    .offset(x: xOffset, y: yOffset)
            }
        }
        .frame(width: circleRadius * 2 + (circleRadius / 2), height: circleRadius * 2 + (circleRadius / 2))
        .rotationEffect(.degrees(-90))
        .overlay {
            VStack(spacing: .zero) {
                Text("\(progressValue)%")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                Text("processing")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(.init(hex: "5A5A5A"))
            }
        }
        .onAppear {
            doProgress()
        }
    }
    
    func doProgress() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.06, repeats: true) { _ in
            if progressValue < 100 {
                progressValue += 1
            } else {
                timer?.invalidate()
            }
        }
        
        for index in 0..<lines.count {
            withAnimation(Animation.easeInOut(duration: 0.5).delay(Double(index) * 0.06)) {
                lines[index].length = 50
                lines[index].gradient = LinearGradient(colors: [Color(hex: "141414"), Color(hex: "F9836C")], startPoint: .bottom, endPoint: .top)
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
