//
//  AddEmployeeViewModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import Foundation
import SwiftUI
import Combine

extension AddEmployeeView {
    
    //MARK: - VIEW MODEL -
    class ViewModel: BaseViewModel {
        
        //MARK: - PROPERTIES -
        
        //Normal
        var cancellables = Set<AnyCancellable>()
        //Published
        @Published var desigations: [DesignationModel]?
        @Published var departments: [DesignationModel]?
        @Published var isShowActionSheet: Bool = false
        @Published var isShowingImagePicker: Bool = false
        @Published var selectedImage: UIImage?
        @Published var sourceType: UIImagePickerController.SourceType = .camera
        @Published var isShowDOBDatePicker: Bool = false
        @Published var isShowDateOfJoiningPicker: Bool = false
        @Published var isShowDesignationPicker: Bool = false
        @Published var isShowDepartmentPicker: Bool = false
        @Published var isShowErrorAlert: Bool = false
        @Published var errorMessage: String = ""
        @Published var isUnauthorized: Bool = false
        //Params (Published)
        @Published var name: String = ""
        @Published var empID: String = ""
        @Published var designationId: String = ""
        @Published var designation: String = ""
        @Published var departmentId: String = ""
        @Published var department: String = ""
        @Published var selectedDob: String = ""
        @Published var dob: Date = Date()
        @Published var email: String = ""
        @Published var phone: String = ""
        @Published var selectedDateOfJoining: String = ""
        @Published var dateOfJoining: Date = Date()
        
        //MARK: - INITIALIZER -
        override init() {
            super.init()
            self.getDesignations()
            self.getDepartments()
        }
    }
}

//MARK: - FUNCTIONS -
extension AddEmployeeView.ViewModel {
    
    //MARK: - GET DESIGNATIONS -
    private func getDesignations() {
        NetworkManager.shared.request(endPoint: APIEndpoint.getDesignations, responseType: GetDesignationsResponseModel.self)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorHandling(error)
                case .finished:
                    break
                }
            } receiveValue: { response in
                self.desigations = response.designations
            }
            .store(in: &self.cancellables)
    }
    
    //MARK: - GET DEPARTMENTS -
    private func getDepartments() {
        NetworkManager.shared.request(endPoint: APIEndpoint.getDepartments, responseType: GetDesignationsResponseModel.self)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorHandling(error)
                case .finished:
                    break
                }
            } receiveValue: { response in
                self.departments = response.departments
            }
            .store(in: &self.cancellables)
    }
    
    //MARK: - ADD EMPLOYEE -
    func addEmployee(completion: @escaping (Bool) -> Void) {
        guard let avatar = self.selectedImage else {
            self.showErrorAlert("Profile image is required")
            return
        }
        
        if (self.textFieldsValidation()) {
            let params: [String: Any] = [
                "name": self.name,
                "email": self.email,
                "emp_id": Int(self.empID) ?? 0,
                "phone": "+92" + self.phone,
                "designation": self.designationId,
                "department": self.departmentId,
                "dob": Utilities.shared.convertToRequiredFormat(self.selectedDob) ?? "",
                "date_of_joining": Utilities.shared.convertToRequiredFormat(self.selectedDateOfJoining) ?? ""
            ]
            
            NetworkManager.shared.multipartRequest(
                endPoint: .addEmployee,
                image: avatar,
                parameters: params,
                responseType: AddEmployeeResponseModel.self
            )
            .sink { result in
                switch result {
                case .failure(let error):
                    print(error)
                    completion(false)
                case .finished:
                    break
                }
            } receiveValue: { response in
                NotificationCenter.default.post(name: .employeeDidAdded, object: nil)
                completion(true)
            }
            .store(in: &self.cancellables)
        }
    }
    
    //MARK: - GET DESIGNATION -
    func getDesignationId() {
        if let designation = self.desigations?.first(where: { $0.name == self.designation }) {
            self.designationId = designation.id ?? ""
        }
    }
    
    //MARK: - GET DEPARTMENT ID -
    func getDepartmentId() {
        if let department = self.departments?.first(where: { $0.name == self.department }) {
            self.departmentId = department.id ?? ""
        }
    }
    
    //MARK: - TEXTFIELDS VALIDATION -
    private func textFieldsValidation() -> Bool {
        var errorMessage: String?
        
        if (self.name == "") {
            errorMessage = "Name is required"
        } else if (self.email == "") {
            errorMessage = "Email is required"
        } else if !(self.email.isValidEmail()) {
            errorMessage = "Email must be valid"
        } else if (self.phone == "") {
            errorMessage = "Phone is required"
        } else if (self.phone.count != 10) {
            errorMessage = "Phone must be valid"
        } else if (self.empID == "") {
            errorMessage = "Employee ID is required"
        } else if (self.designationId == "") {
            errorMessage = "Designation ID is required"
        } else if (self.departmentId == "") {
            errorMessage = "Department ID is required"
        } else if (self.selectedDob == "") {
            errorMessage = "Date of birth is required"
        } else if (self.selectedDateOfJoining == "") {
            errorMessage = "Date of joining is required"
        }
        
        if let error = errorMessage {
            self.showErrorAlert(error)
            return false
        } else {
            return true
        }
    }
    
    //MARK: - ERROR HANDLING -
    private func errorHandling(_ error: NetworkError) {
        let message: String
        
        switch error {
        case .unauthorized(_, _):
            self.isUnauthorized = true
            message = "Login session as expired. Please login again."
        case .serverError(_, let msg):
            message = msg
        default:
            message = "Something went wrong"
        }
        
        self.showErrorAlert(message)
    }
    
    //MARK: - ERROR HANDLING -
    private func showErrorAlert(_ message: String) {
        self.errorMessage = message
        self.isShowErrorAlert = true
    }
}
