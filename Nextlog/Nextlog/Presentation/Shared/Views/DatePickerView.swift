//
//  DatePicker.swift
//  Nextlog
//
//  Created by Telha Wasim on 21/03/2025.
//

import SwiftUI

struct DatePickerView: View {
    
    //Binding
    @Binding var isShowDatePicker: Bool
    @Binding var selectedValue: String
    @Binding var selectedDate: Date
    var minimuDate: Date? = nil
    var onPressDone: (() -> Void)?
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        ZStack(alignment: .bottom) {
            // Background
            Color.gray.opacity(0.3)
                .ignoresSafeArea()
                .opacity(self.isShowDatePicker ? 1 : 0)
                .onTapGesture {
                    self.isShowDatePicker.toggle()
                }
            // Done Button and Date Picker
            VStack(spacing: 0) {
                // Done Button
                HStack {
                    // Spacer
                    Spacer()
                    // Done Button
                    Button(action:  {
                        self.selectedValue = Utilities.shared.formatDateIntoString(self.selectedDate)
                        self.isShowDatePicker = false
                        self.onPressDone?()
                    }, label: {
                        Text("Done")
                            .font(.getSemibold(.h20))
                            .foregroundStyle(Color.black)
                    })
                }
                .padding()
                .background(Color.white)
                // Divider
                Divider()
                // Date Picker
                DatePicker("", selection: self.$selectedDate, in: self.handleRange(), displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.wheel)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
            }
            .offset(y: self.isShowDatePicker ? 0 : 400)
            .animation(.default, value: self.isShowDatePicker)
        }
    }
}

//MARK: - FUNCTIONS -
extension DatePickerView {
    
    //MARK: - HANDLE RANGE -
    private func handleRange() -> ClosedRange<Date> {
        if let minDate = self.minimuDate {
            return minDate...Date()
        } else {
            return Date.distantPast...Date()
        }
    }
}

#Preview {
    DatePickerView(
        isShowDatePicker: Binding.constant(true),
        selectedValue: Binding.constant(""),
        selectedDate: Binding.constant(Date())
    )
}
