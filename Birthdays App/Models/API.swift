// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class PersonsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Persons {
      person {
        __typename
        id
        name
        date_of_birth
      }
    }
    """

  public let operationName: String = "Persons"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("person", type: .nonNull(.list(.nonNull(.object(Person.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(person: [Person]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "person": person.map { (value: Person) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "person"
    public var person: [Person] {
      get {
        return (resultMap["person"] as! [ResultMap]).map { (value: ResultMap) -> Person in Person(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Person) -> ResultMap in value.resultMap }, forKey: "person")
      }
    }

    public struct Person: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["person"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("date_of_birth", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, name: String, dateOfBirth: String) {
        self.init(unsafeResultMap: ["__typename": "person", "id": id, "name": name, "date_of_birth": dateOfBirth])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var dateOfBirth: String {
        get {
          return resultMap["date_of_birth"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "date_of_birth")
        }
      }
    }
  }
}
