//
//  Utilities.swift
//  Nextlog
//
//  Created by Telha Wasim on 21/03/2025.
//

import UIKit

class Utilities {
    
    //MARK: - PROPERTIES -
    
    //Normal
    static let shared = Utilities()
    
    //MARK: - INITIALIZER -
    private init() { }
    
    //MARK: - FETCH IMAGE -
    func fetchImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        /// Convert string into URL
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        /// Fetch the image
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        .resume()
    }
    
    //MARK: - FORMAT DATE INTO STRING -
    func formatDateIntoString(_ date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd MMM, yyyy"
        
        return formatter.string(from: date)
    }
    
    //MARK: - CONVERT TO ISO 8601 -
    func convertToISO8601(_ dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd MMM, yyyy"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(identifier: "UTC")

        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = ISO8601DateFormatter()
            outputFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    
    //MARK: - REMOVE THE USER -
    func removeTheUser(router: Routing) {
        AppStorage.accessToken = nil
        AppStorage.user = nil
        
        router.reset()
        router.push(.login(LoginView.ViewModel()))
    }
}
