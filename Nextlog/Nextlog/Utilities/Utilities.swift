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
    
    //MARK: - CONVERT TO REQUIRED FORMAT -
    func convertToRequiredFormat(_ dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd MMM, yyyy"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(identifier: "UTC")
        
        if let date = inputFormatter.date(from: dateString) {
            // Use DateFormatter to convert to the desired format
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            outputFormatter.timeZone = TimeZone(identifier: "UTC")
            
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
    
    //MARK: - VERIFY URL -
    func verifyURL(_ urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    //MARK: - REMOVE THE PREFIX FROM THE PHONE NUMBER -
    func removeThePrefixFromPhoneNumber(_ prefix: String, _ phone: String?) -> String {
        guard let phone = phone, phone.hasPrefix(prefix) else {
            return ""
        }
        
        return String(phone.dropFirst(prefix.count))
    }
}
