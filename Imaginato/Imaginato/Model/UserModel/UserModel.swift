//
//  UserModel.swift


import Foundation
import SwiftyJSON

public final class UserModel {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let result = "result"
        static let errorMessage = "error_message"
        static let data = "data"
    }
    
    // MARK: Properties
    public var result: Int?
    public var errorMessage: String?
    public var userData: UserData?
    
    
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    init() {
    }
    
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        result = json[SerializationKeys.result].int
        errorMessage = json[SerializationKeys.errorMessage].string
        userData = UserData(json: json[SerializationKeys.data])
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = result { dictionary[SerializationKeys.result] = value }
        if let value = errorMessage { dictionary[SerializationKeys.errorMessage] = value }
        if let value = userData { dictionary[SerializationKeys.data] = value.dictionaryRepresentation() }
        return dictionary
    }
    
}

public final class UserData {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let user = "user"
    }
    
    // MARK: Properties
    public var user: User?
    
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    init() {
    }
    
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        user = User(json: json[SerializationKeys.user])
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = user { dictionary[SerializationKeys.user] = value.dictionaryRepresentation() }
        return dictionary
    }
}

public final class User {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let userName = "userName"
        static let userId = "userId"
        static let createdAt = "created_at"
    }
    
    // MARK: Properties
    public var userName: String?
    public var userId: Int?
    public var createdAt: String?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    init() {
    }
    
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        userName = json[SerializationKeys.userName].string
        userId = json[SerializationKeys.userId].int
        createdAt = json[SerializationKeys.createdAt].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = userName { dictionary[SerializationKeys.userName] = value }
        if let value = userId { dictionary[SerializationKeys.userId] = value }
        if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
        return dictionary
    }
    
}
