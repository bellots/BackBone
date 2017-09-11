//  This file was automatically generated and should not be edited.

import Apollo

public final class EventForIdQuery: GraphQLQuery {
  public static let operationString =
    "query EventForId($eventId: ID!) {" +
    "  event(id: $eventId) {" +
    "    __typename" +
    "    name" +
    "    id" +
    "    planning {" +
    "      __typename" +
    "      day" +
    "      displayDay" +
    "      agenda {" +
    "        __typename" +
    "        startAt" +
    "        displayStartAt" +
    "        sessions {" +
    "          __typename" +
    "          title" +
    "          id" +
    "        }" +
    "      }" +
    "    }" +
    "  }" +
    "}"

  public var eventId: GraphQLID

  public init(eventId: GraphQLID) {
    self.eventId = eventId
  }

  public var variables: GraphQLMap? {
    return ["eventId": eventId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("event", arguments: ["id": Variable("eventId")], type: .object(Event.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(event: Event? = nil) {
      self.init(snapshot: ["__typename": "Query", "event": event])
    }

    public var event: Event? {
      get {
        return (snapshot["event"]! as! Snapshot?).flatMap { Event(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "event")
      }
    }

    public struct Event: GraphQLSelectionSet {
      public static let possibleTypes = ["Event"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("planning", type: .nonNull(.list(.object(Planning.self)))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(name: String? = nil, id: GraphQLID, planning: [Planning?]) {
        self.init(snapshot: ["__typename": "Event", "name": name, "id": id, "planning": planning])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String? {
        get {
          return snapshot["name"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var planning: [Planning?] {
        get {
          return (snapshot["planning"]! as! [Snapshot?]).map { $0.flatMap { Planning(snapshot: $0) } }
        }
        set {
          snapshot.updateValue(newValue.map { $0.flatMap { $0.snapshot } }, forKey: "planning")
        }
      }

      public struct Planning: GraphQLSelectionSet {
        public static let possibleTypes = ["EventDay"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("day", type: .scalar(Int.self)),
          GraphQLField("displayDay", type: .scalar(String.self)),
          GraphQLField("agenda", type: .list(.object(Agenda.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(day: Int? = nil, displayDay: String? = nil, agenda: [Agenda?]? = nil) {
          self.init(snapshot: ["__typename": "EventDay", "day": day, "displayDay": displayDay, "agenda": agenda])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var day: Int? {
          get {
            return snapshot["day"]! as! Int?
          }
          set {
            snapshot.updateValue(newValue, forKey: "day")
          }
        }

        public var displayDay: String? {
          get {
            return snapshot["displayDay"]! as! String?
          }
          set {
            snapshot.updateValue(newValue, forKey: "displayDay")
          }
        }

        public var agenda: [Agenda?]? {
          get {
            return (snapshot["agenda"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Agenda(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "agenda")
          }
        }

        public struct Agenda: GraphQLSelectionSet {
          public static let possibleTypes = ["TimeSchedule"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("startAt", type: .scalar(String.self)),
            GraphQLField("displayStartAt", type: .scalar(String.self)),
            GraphQLField("sessions", type: .nonNull(.list(.object(Session.self)))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(startAt: String? = nil, displayStartAt: String? = nil, sessions: [Session?]) {
            self.init(snapshot: ["__typename": "TimeSchedule", "startAt": startAt, "displayStartAt": displayStartAt, "sessions": sessions])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          public var startAt: String? {
            get {
              return snapshot["startAt"]! as! String?
            }
            set {
              snapshot.updateValue(newValue, forKey: "startAt")
            }
          }

          public var displayStartAt: String? {
            get {
              return snapshot["displayStartAt"]! as! String?
            }
            set {
              snapshot.updateValue(newValue, forKey: "displayStartAt")
            }
          }

          public var sessions: [Session?] {
            get {
              return (snapshot["sessions"]! as! [Snapshot?]).map { $0.flatMap { Session(snapshot: $0) } }
            }
            set {
              snapshot.updateValue(newValue.map { $0.flatMap { $0.snapshot } }, forKey: "sessions")
            }
          }

          public struct Session: GraphQLSelectionSet {
            public static let possibleTypes = ["Session"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("title", type: .scalar(String.self)),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(title: String? = nil, id: GraphQLID) {
              self.init(snapshot: ["__typename": "Session", "title": title, "id": id])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            public var title: String? {
              get {
                return snapshot["title"]! as! String?
              }
              set {
                snapshot.updateValue(newValue, forKey: "title")
              }
            }

            public var id: GraphQLID {
              get {
                return snapshot["id"]! as! GraphQLID
              }
              set {
                snapshot.updateValue(newValue, forKey: "id")
              }
            }
          }
        }
      }
    }
  }
}