//
//  DesignationPickerView.swift
//  Nextlog
//
//  Created by Telha Wasim on 01/04/2025.
//

import SwiftUI

struct DesignationPickerView: View {
    
    //MARK: - PROPERTIES -
    
    //State
    @State var selectedDesignation: DesignationModel = DesignationModel()
    //Binding
    @Binding var isShowPicker: Bool
    //Normal
    var values: [DesignationModel] = []
    var onPress: ((DesignationModel) -> Void)?
    
    //MARK: - VIEWS -
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background
            Color.gray.opacity(0.3)
                .ignoresSafeArea()
                .opacity(self.isShowPicker ? 1 : 0)
                .onTapGesture {
                    self.isShowPicker.toggle()
                }
            // Done Button and Date Picker
            VStack(spacing: 0) {
                // Done Button
                HStack {
                    // Spacer
                    Spacer()
                    // Done Button
                    Button(action:  {
                        self.isShowPicker = false
                        self.setValue()
                        self.onPress?(self.selectedDesignation)
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
                Picker("", selection: self.$selectedDesignation.name) {
                    ForEach(self.values, id: \.id) { value in
                        Text(value.name ?? "")
                            .tag(value.name ?? "")
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .pickerStyle(.wheel)
            }
            .offset(y: self.isShowPicker ? 0 : 400)
            .animation(.default, value: self.isShowPicker)
        }
    }
}

//MARK: - FUNCTIONS -
extension DesignationPickerView {
    
    //MARK: - SET VALUE -
    private func setValue() {
        if (self.values.count >= 1) && (self.selectedDesignation.name == "") {
            self.selectedDesignation = self.values[0]
        } else {
            if let selectedDesignation = self.values.first(where: { $0.name == self.selectedDesignation.name }) {
                self.selectedDesignation = selectedDesignation
            }
        }
    }
}

#Preview {
    DesignationPickerView(
        isShowPicker: Binding.constant(true)
//        isShowDatePicker: Binding.constant(true),
//        selectedValue: Binding.constant(""),
//        selectedDate: Binding.constant(Date())
    )
}
