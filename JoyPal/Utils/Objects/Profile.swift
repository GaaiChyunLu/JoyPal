import UIKit
import SwiftData

/// A model representing a JoyPal profile for persistent storage.
@Model public class Profile {
    private var imageData: Data?
    
    /// The unique identifier for the profile.
    public var id: UUID
    /// The user ID associated with the profile.
    var userId: String
    /// The name of the JoyPal.
    var name: String
    /// The appearance description of the JoyPal.
    var appearance: String
    /// The gender description of the JoyPal.
    var gender: String
    /// The personality description of the JoyPal.
    var personality: String
    /// The generated image of the JoyPal.
    var image: UIImage? {
        get { imageData.flatMap(UIImage.init) }
        set { imageData = newValue?.pngData() }
    }
    
    /// Initializes a new `Profile` instance for a JoyPal.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the profile.
    ///   - userId: The user ID associated with the profile.
    ///   - name: The name of the JoyPal.
    ///   - profileParam: The parameters describing the JoyPal's characteristics.
    ///   - image: The generated image of the JoyPal.
    public init(id: UUID, userId: String, name: String, profileParam: ProfileParam, image: UIImage) {
        self.id = id
        self.userId = userId
        self.name = name
        self.appearance = profileParam.appearance
        self.gender = profileParam.gender
        self.personality = profileParam.personality
        self.image = image
    }
}

/// A model representing the parameters of a JoyPal for character generation.
public class ProfileParam: ObservableObject {
    /// The name of the JoyPal.
    @Published var name: String = ""
    /// The appearance description of the JoyPal.
    @Published var appearance: String = ""
    /// The gender description of the JoyPal.
    @Published var gender: String = ""
    /// The personality description of the JoyPal.
    @Published var personality: String = ""
    
    /// Whether all the fields are filled out.
    public var isComplete: Bool {
        get {
            [name, appearance, gender, personality].allSatisfy {
                $0.isEmpty == false
            }
        }
    }
}
