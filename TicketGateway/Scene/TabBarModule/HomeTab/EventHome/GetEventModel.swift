//
//  GetEventModel.swift
//  TicketGateway
//
//  Created by Apple  on 06/06/23.
//

import UIKit

// MARK: - GetEventModel
struct GetEventModel: Codable {
    var event: Event?
    var coverImage: CoverImage?
    var location: Location?
    var date: DateClass?

    enum CodingKeys: String, CodingKey {
        case event
        case coverImage = "cover_image"
        case location, date
    }
}

// MARK: - CoverImage
struct CoverImage: Codable {
    var id: Int?
    var eventCoverImage: String?
    var eventAdditionalCoverImages: [String]?
    var eventID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case eventCoverImage = "event_cover_image"
        case eventAdditionalCoverImages = "event_additional_cover_images"
        case eventID = "event_id"
    }
}

// MARK: - DateClass
struct DateClass: Codable {
    var id: Int?
   // var eventEndCount, monthRepeatDateOrDay: JSONNull?
    var displayStartTime: Bool?
    var eventID: Int?
    var eventEndDate: String?
    var eventEndTime: String?
    var eventTimeZoneID: Int?
    var isRecurring: Bool?
   // var weeklyOccurs: [JSONAny]?
    var dateOccurrence: DateOccurrence?
    var displayEndTime: Bool?
    var eventStartDate: String?
    var eventStartTime: String?
    var eventLanguageID: Int?

    enum CodingKeys: String, CodingKey {
        case id
       // case eventEndCount = "event_end_count"
       // case monthRepeatDateOrDay = "month_repeat_date_or_day"
        case displayStartTime = "display_start_time"
        case eventID = "event_id"
        case eventEndDate = "event_end_date"
        case eventEndTime = "event_end_time"
        case eventTimeZoneID = "event_time_zone_id"
        case isRecurring = "is_recurring"
     //   case weeklyOccurs = "weekly_occurs"
        case dateOccurrence = "date_occurrence"
        case displayEndTime = "display_end_time"
        case eventStartDate = "event_start_date"
        case eventStartTime = "event_start_time"
        case eventLanguageID = "event_language_id"
    }
}

enum DateOccurrence: String, Codable {
    case once = "Once"
}

// MARK: - Event
struct Event: Codable {
    var id: Int?
    var customizeWebLink: String?
    var isShowRemainingTickets: Bool?
    var ticketID: Int?
    var isFacilityFee: Bool?
    var title: String?
    var isPublishNow: Bool?
    var eventPublishType: EventPublishType?
    var createdAt: String?
    var visitorCount: Int?
   // var eventDescription: JSONNull?
    var scheduleEventDate: String?
  //  var eventAdditionalImageID: JSONNull?
    var updatedAt: String?
    var eventPassword: String?
    var formSteps: Int?
  //  var scheduleEventTime: JSONNull?
    var eventOrganizerID: Int?
    var createdBy: String?
    var isVirtual, isEmailInvitation: Bool?
    var eventTypeID, userID: Int?
 //   var eventLinks: JSONNull?
    var isPasswordProtected: Bool?
    var eventCategoryID: Int?
  //  var updatedBy, documentLinks: JSONNull?
    var isShowOrganizerProfile: Bool?
    var eventSubCategoryID: Int?
    var isActive, isPublic: Bool?
    var refundPolicyID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case customizeWebLink = "customize_web_link"
        case isShowRemainingTickets = "is_show_remaining_tickets"
        case ticketID = "ticket_id"
        case isFacilityFee = "is_facility_fee"
        case title
        case isPublishNow = "is_publish_now"
        case eventPublishType = "event_publish_type"
        case createdAt = "created_at"
        case visitorCount = "visitor_count"
       // case eventDescription = "event_description"
        case scheduleEventDate = "schedule_event_date"
       // case eventAdditionalImageID = "event_additional_image_id"
        case updatedAt = "updated_at"
        case eventPassword = "event_password"
        case formSteps = "form_steps"
       // case scheduleEventTime = "schedule_event_time"
        case eventOrganizerID = "event_organizer_id"
        case createdBy = "created_by"
        case isVirtual = "is_virtual"
        case isEmailInvitation = "is_email_invitation"
        case eventTypeID = "event_type_id"
        case userID = "user_id"
       // case eventLinks = "event_links"
        case isPasswordProtected = "is_password_protected"
        case eventCategoryID = "event_category_id"
       // case updatedBy = "updated_by"
      //  case documentLinks = "document_links"
        case isShowOrganizerProfile = "is_show_organizer_profile"
        case eventSubCategoryID = "event_sub_category_id"
        case isActive = "is_active"
        case isPublic = "is_public"
        case refundPolicyID = "refund_policy_id"
    }
}

enum EventPublishType: String, Codable {
    case live = "LIVE"
}

// MARK: - Location
struct Location: Codable {
    var isVirtual: Bool?
   // var additionalCoverImage, virtualExternalDocument, toBeAnnouncedAddress: JSONNull?
    var isAdditionalSettings: Bool?
  //  var virtualTitleImage, addDetailsDescription: JSONNull?
    var eventID: Int?
    var eventAddress: String?
 //   var virtualTitleVideo: JSONNull?
    var isToBeAnnounced: Bool?
    var latitude: Double?
  //  var virtualImages, eventCountry: JSONNull?
    var longitude: Double?
    var virtualEventHostLink: String?
 //   var eventState, virtualLiveVideoURL, virtualVideoLinks, eventCity: JSONNull?
    var id: Int?
 //   var locationDescription: JSONNull?
    var virtualVideoUrls: String?
    var isAddressField: Bool?
    var virtualEventTitle: String?
 //   var virtualLinkTitle: JSONNull?

    enum CodingKeys: String, CodingKey {
        case isVirtual = "is_virtual"
      //  case additionalCoverImage = "additional_cover_image"
     //   case virtualExternalDocument = "virtual_external_document"
     //   case toBeAnnouncedAddress = "to_be_announced_address"
        case isAdditionalSettings = "is_additional_settings"
    //    case virtualTitleImage = "virtual_title_image"
    //    case addDetailsDescription = "add_details_description"
        case eventID = "event_id"
        case eventAddress = "event_address"
    //    case virtualTitleVideo = "virtual_title_video"
        case isToBeAnnounced = "is_to_be_announced"
        case latitude
    //    case virtualImages = "virtual_images"
    //    case eventCountry = "event_country"
        case longitude
        case virtualEventHostLink = "virtual_event_host_link"
    //    case eventState = "event_state"
    //    case virtualLiveVideoURL = "virtual_live_video_url"
    //    case virtualVideoLinks = "virtual_video_links"
    //    case eventCity = "event_city"
        case id
    //    case locationDescription = "location_description"
        case virtualVideoUrls = "virtual_video_urls"
        case isAddressField = "is_address_field"
        case virtualEventTitle = "virtual_event_title"
    //    case virtualLinkTitle = "virtual_link_title"
    }
}

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        var container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}

//class JSONCodingKey: CodingKey {
//    var key: String
//
//    required init?(intValue: Int) {
//        return nil
//    }
//
//    required init?(stringValue: String) {
//        key = stringValue
//    }
//
//    var intValue: Int? {
//        return nil
//    }
//
//    var stringValue: String {
//        return key
//    }
//}

//class JSONAny: Codable {
//
//    var value: Any
//
//    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
//        var context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
//        return DecodingError.typeMismatch(JSONAny.self, context)
//    }
//
//    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
//        var context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
//        return EncodingError.invalidValue(value, context)
//    }
//
//    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
//        if var value = try? container.decode(Bool.self) {
//            return value
//        }
//        if var value = try? container.decode(Int64.self) {
//            return value
//        }
//        if var value = try? container.decode(Double.self) {
//            return value
//        }
//        if var value = try? container.decode(String.self) {
//            return value
//        }
//        if container.decodeNil() {
//            return JSONNull()
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
//        if var value = try? container.decode(Bool.self) {
//            return value
//        }
//        if var value = try? container.decode(Int64.self) {
//            return value
//        }
//        if var value = try? container.decode(Double.self) {
//            return value
//        }
//        if var value = try? container.decode(String.self) {
//            return value
//        }
//        if var value = try? container.decodeNil() {
//            if value {
//                return JSONNull()
//            }
//        }
//        if var container = try? container.nestedUnkeyedContainer() {
//            return try decodeArray(from: &container)
//        }
//        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
//            return try decodeDictionary(from: &container)
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
//        if var value = try? container.decode(Bool.self, forKey: key) {
//            return value
//        }
//        if var value = try? container.decode(Int64.self, forKey: key) {
//            return value
//        }
//        if var value = try? container.decode(Double.self, forKey: key) {
//            return value
//        }
//        if var value = try? container.decode(String.self, forKey: key) {
//            return value
//        }
//        if var value = try? container.decodeNil(forKey: key) {
//            if value {
//                return JSONNull()
//            }
//        }
//        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
//            return try decodeArray(from: &container)
//        }
//        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
//            return try decodeDictionary(from: &container)
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
//        var arr: [Any] = []
//        while !container.isAtEnd {
//            var value = try decode(from: &container)
//            arr.append(value)
//        }
//        return arr
//    }
//
//    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
//        var dict = [String: Any]()
//        for key in container.allKeys {
//            var value = try decode(from: &container, forKey: key)
//            dict[key.stringValue] = value
//        }
//        return dict
//    }
//
//    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
//        for value in array {
//            if var value = value as? Bool {
//                try container.encode(value)
//            } else if var value = value as? Int64 {
//                try container.encode(value)
//            } else if var value = value as? Double {
//                try container.encode(value)
//            } else if var value = value as? String {
//                try container.encode(value)
//            } else if value is JSONNull {
//                try container.encodeNil()
//            } else if var value = value as? [Any] {
//                var container = container.nestedUnkeyedContainer()
//                try encode(to: &container, array: value)
//            } else if var value = value as? [String: Any] {
//                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
//                try encode(to: &container, dictionary: value)
//            } else {
//                throw encodingError(forValue: value, codingPath: container.codingPath)
//            }
//        }
//    }
//
//    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
//        for (key, value) in dictionary {
//            var key = JSONCodingKey(stringValue: key)!
//            if var value = value as? Bool {
//                try container.encode(value, forKey: key)
//            } else if var value = value as? Int64 {
//                try container.encode(value, forKey: key)
//            } else if var value = value as? Double {
//                try container.encode(value, forKey: key)
//            } else if var value = value as? String {
//                try container.encode(value, forKey: key)
//            } else if value is JSONNull {
//                try container.encodeNil(forKey: key)
//            } else if var value = value as? [Any] {
//                var container = container.nestedUnkeyedContainer(forKey: key)
//                try encode(to: &container, array: value)
//            } else if var value = value as? [String: Any] {
//                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
//                try encode(to: &container, dictionary: value)
//            } else {
//                throw encodingError(forValue: value, codingPath: container.codingPath)
//            }
//        }
//    }
//
//    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
//        if var value = value as? Bool {
//            try container.encode(value)
//        } else if var value = value as? Int64 {
//            try container.encode(value)
//        } else if var value = value as? Double {
//            try container.encode(value)
//        } else if var value = value as? String {
//            try container.encode(value)
//        } else if value is JSONNull {
//            try container.encodeNil()
//        } else {
//            throw encodingError(forValue: value, codingPath: container.codingPath)
//        }
//    }
//
//    public required init(from decoder: Decoder) throws {
//        if var arrayContainer = try? decoder.unkeyedContainer() {
//            self.value = try JSONAny.decodeArray(from: &arrayContainer)
//        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
//            self.value = try JSONAny.decodeDictionary(from: &container)
//        } else {
//            var container = try decoder.singleValueContainer()
//            self.value = try JSONAny.decode(from: container)
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        if var arr = self.value as? [Any] {
//            var container = encoder.unkeyedContainer()
//            try JSONAny.encode(to: &container, array: arr)
//        } else if var dict = self.value as? [String: Any] {
//            var container = encoder.container(keyedBy: JSONCodingKey.self)
//            try JSONAny.encode(to: &container, dictionary: dict)
//        } else {
//            var container = encoder.singleValueContainer()
//            try JSONAny.encode(to: &container, value: self.value)
//        }
//    }
//}
