//
//  BackButton.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import SwiftUI

struct BackButton: View {
    init(_ actionCompletion: (() -> Void)? = nil) {
        self.actionCompletion = actionCompletion
    }

    @Environment(\.dismiss)
    private var dismiss
    private var actionCompletion: (() -> Void)?

    var body: some View {
        Button(action: {
            if let action = actionCompletion {
                action()
            } else {
                dismiss()
            }
        }) {
            Image(systemName: "arrow.left")
                .font(.system(.headline, design: .serif, weight: .bold))
                .imageScale(.large)
                .foregroundColor(.white)
        }
    }
}

#if DEBUG
struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
            .previewLayout(.sizeThatFits)
            .background(Color.black)
    }
}
#endif
