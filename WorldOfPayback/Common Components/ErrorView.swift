//
//  ErrorView.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 07.05.23.
//

import SwiftUI

struct ErrorView: View {

    // MARK: - Variables
    let errorMessage: String
    let errorHandler: (() -> Void)?

    // MARK: - UI
    var body: some View {
        ZStack {
            Color.red
                .opacity(0.7)
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.title2)
                        .foregroundColor(.white)
                    Text(errorMessage)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 5)
                if let errorHandler {
                    Button(action: errorHandler) {
                        Text(L10n.errorViewTryAgain)
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                }
            }
        }
        .cornerRadius(10)
        .frame(maxWidth: .infinity, maxHeight: 100)
        .animation(.easeOut, value: 0.5)
    }
}

// MARK: - Preview
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorMessage: "Lorem Ipsum Dolor Sit Amet", errorHandler: {})
    }
}
