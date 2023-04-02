//
//  YearPicker.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 26/03/2023.
//

import Foundation
import SwiftUI
struct YearPicker: View {
    @Binding var year: Int
    let range: ClosedRange<Int>

    var body: some View {
        Picker("", selection: $year) {
            ForEach(range, id: \.self) { year in
                Text("\(year)").tag(year)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(maxWidth: .infinity)
        .clipped()
    }
}
