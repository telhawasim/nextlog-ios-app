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
                DatePicker("", selection: self.$selectedDate, in: ...Date.now, displayedComponents: .date)
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

#Preview {
    DatePickerView(
        isShowDatePicker: Binding.constant(true),
        selectedValue: Binding.constant(""),
        selectedDate: Binding.constant(Date())
    )
}
