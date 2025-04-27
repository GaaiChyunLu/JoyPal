import UIKit

/// A model for API requests and image fetching.
class NetworkManager {
    /// Generate a character based on the provided profile parameters.
    ///
    /// - Parameters:
    ///  - profileParam: The parameters describing the character's characteristics.
    ///  - completion: A closure that is called with the result of the request.
    public static func generateCharacter(profileParam: ProfileParam, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let urlString = "http://joypal.natapp1.cc/generate/text2img"

        let body: [String: Any] = [
            "description": [
                ["Name": profileParam.name],
                ["Gender": profileParam.gender],
                ["Appearance": profileParam.appearance],
                ["Personality": profileParam.personality]
            ]
        ]
        
        sendPostRequest(urlString: urlString, body: body, completion: completion)
    }
    
    /// Generate text based on the provided message and profile.
    ///
    /// - Parameters:
    ///  - message: The input message for text generation.
    ///  - profile: The profile containing the character's characteristics.
    ///  - completion: A closure that is called with the result of the request.
    public static func generateText(message: String, profile: Profile, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let urlString = "http://joypal.natapp1.cc/generate-text"

        let body: [String: Any] = [
            "dialogues": [
                ["Input": message]
            ],
            "description": [
                ["Name": profile.name],
                ["Gender": profile.gender],
                ["Appearance": profile.appearance],
                ["Personality": profile.personality]
            ]
        ]
        
        sendPostRequest(urlString: urlString, body: body, completion: completion)
    }
    
    /// Fetch an image from the provided URL string.
    ///
    /// - Parameters:
    ///  - urlString: The URL string of the image to fetch.
    ///  - completion: A closure that is called with the result of the image fetch.
    public static func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let downloadedImage = UIImage(data: data) else {
                completion(.failure(NSError(domain: "ImageError", code: -1, userInfo: nil)))
                return
            }

            completion(.success(downloadedImage))
        }
        task.resume()
    }
    
    private static func sendPostRequest(urlString: String, body: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(.success(json))
                } else {
                    completion(.failure(NSError(domain: "ParsingError", code: -1, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
