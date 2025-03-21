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
}
