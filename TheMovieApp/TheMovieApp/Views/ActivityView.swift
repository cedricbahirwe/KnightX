//
//  ActivityView.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 11/10/2022.
//

import SwiftUI

struct ActivityView: View {

    public var lineWidth: CGFloat
    public var pathColor: Color
    public var lineColor: Color

    // MARK: - Init
    public init(lineWidth: CGFloat = 30, pathColor: Color, lineColor: Color) {
        self.lineWidth = lineWidth
        self.lineColor = lineColor
        self.pathColor = pathColor
    }

    @State var isLoading: Bool = false

    public var body: some View {
        ZStack {
            Circle()
                .stroke(pathColor, lineWidth: lineWidth)
                .opacity(0.3)
            Circle()
                .trim(from: 0, to: 0.25)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(lineColor)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(.linear(duration: 1).repeatForever(autoreverses: false),
                           value: lineWidth)
                .onAppear { self.isLoading.toggle() }
        }
    }
}

public struct DotsActivityView: View {

    private let dotDelayMultiplyer = 2.0
    private let dotDelayValue = 0.20
    private let dotSize: CGFloat
    private let color: Color

    public init(dotSize: CGFloat = 30, color: Color) {
        self.dotSize = dotSize
        self.color = color
    }

    public var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                DotView(size: dotSize, delay: 0, color: color)
                DotView(size: dotSize, delay: dotDelayValue, color: color)
                DotView(size: dotSize, delay: dotDelayMultiplyer * dotDelayValue, color: color)
                Spacer()
            }
            Spacer()
        }
    }
}

public struct DotView: View {

    private let delay: Double
    private let size: CGFloat
    private let color: Color

    @State private var scale: CGFloat = 0.5

    public init(size: CGFloat, delay: Double, color: Color) {
        self.delay = delay
        self.size = size
        self.color = color
    }

    // MARK: - Body

    public var body: some View {
        Circle()
            .frame(width: size, height: size)
            .scaleEffect(scale)
            .foregroundColor(color)
            .animation(Animation.easeInOut(duration: 0.6).repeatForever().delay(delay))
            .onAppear {
                withAnimation {
                    self.scale = 1
                }
            }
    }
}
