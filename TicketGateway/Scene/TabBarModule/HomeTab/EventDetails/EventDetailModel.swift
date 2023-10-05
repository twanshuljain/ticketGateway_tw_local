//
//  EventDetailModel.swift
//  TicketGateway
//
//  Created by Apple on 06/07/23.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   var welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

enum FollowUnfollow: String{
    case follow = "Successfully followed"
    case unfollow = "Successfully unfollowed"
}

// MARK: - Welcome

// MARK: - EventDetail
struct EventDetail: Codable {
    var event: Event?
    var ticketOnwards: Int?
    var locationType: String?
    var isMultiLocation: Bool?
    var organizer: Organizer?
    var eventType: DataEventType?
    var eventCategory, eventSubCategory: EventCategory?
    var eventRefundPolicy: EventRefundPolicy?
    var eventLocation: EventLocation?
    var eventCoverImageObj: EventCoverImageObj?
    var eventDateObj: EventDateObj?
    var eventTagsObj: EventTagsObj?
    var paymentMode: PaymentMode?
    var isLike, isFollow: Bool?
    var totalFollower: Int?

    enum CodingKeys: String, CodingKey {
        case event
        case ticketOnwards = "ticket_onwards"
        case locationType = "location_type"
        case organizer
        case eventType = "event_type"
        case eventCategory = "event_category"
        case eventSubCategory = "event_sub_category"
        case eventRefundPolicy = "event_refund_policy"
        case eventLocation = "event_location"
        case eventCoverImageObj = "event_cover_image_obj"
        case eventDateObj = "event_date_obj"
        case eventTagsObj = "event_tags_obj"
        case paymentMode = "payment_mode"
        case isLike = "is_like"
        case isFollow = "is_follow"
        case totalFollower = "total_follower"
        case isMultiLocation = "is_multi_location"
    }
}

// MARK: - EventEventType
struct EventEventType: Codable {
    var createdAt: String?
    var id: Int?
    //var createdBy: JSONNull?
    var eventTypeTitle, updatedAt: String?
   // var updatedBy: JSONNull?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id
    //    case createdBy = "created_by"
        case eventTypeTitle = "event_type_title"
        case updatedAt = "updated_at"
  //      case updatedBy = "updated_by"
    }
}

// MARK: - EventCategory
struct EventCategory: Codable {
    var name, description: String?
    var image: String?
}

// MARK: - EventCoverImageObj
struct EventCoverImageObj: Codable {
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

// MARK: - EventDateObj
struct EventDateObj: Codable {
    var eventTimeZoneID, eventLanguageID: Int?
    var isRecurring, displayStartTime, displayEndTime: Bool?
    var eventStartDate, eventEndDate: String?
    var eventStartTime, eventEndTime: String?
    var weeklyOccurs: [JSONAny]?
    var dateOccurrence: String?
    var monthRepeatDateOrDay, eventEndCount: JSONNull?

    enum CodingKeys: String, CodingKey {
        case eventTimeZoneID = "event_time_zone_id"
        case eventLanguageID = "event_language_id"
        case isRecurring = "is_recurring"
        case displayStartTime = "display_start_time"
        case displayEndTime = "display_end_time"
        case eventStartDate = "event_start_date"
        case eventEndDate = "event_end_date"
        case eventStartTime = "event_start_time"
        case eventEndTime = "event_end_time"
        case weeklyOccurs = "weekly_occurs"
        case dateOccurrence = "date_occurrence"
        case monthRepeatDateOrDay = "month_repeat_date_or_day"
        case eventEndCount = "event_end_count"
    }
}

// MARK: - EventLocation
struct EventLocation: Codable {
    var virtualEventTitle, additionalCoverImage, virtualLinkTitle, toBeAnnouncedAddress: String?
    var isVirtual: Bool?
    var virtualTitleImage, virtualExternalDocument: String?
    var eventID: Int?
    var isAdditionalSettings: Bool?
    var virtualTitleVideo, addDetailsDescription: String?
    var eventAddress: String?
    var virtualImages: JSONNull?
    var isToBeAnnounced: Bool?
    var latitude: Double?
    var virtualEventHostLink, eventCountry: String?
    var longitude: Double?
    var virtualVideoLinks, eventState: String?
    var id: Int?
    var virtualLiveVideoURL, virtualVideoUrls, eventCity, locationDescription: String?
    var isAddressField: Bool?

    enum CodingKeys: String, CodingKey {
        case virtualEventTitle = "virtual_event_title"
        case additionalCoverImage = "additional_cover_image"
        case virtualLinkTitle = "virtual_link_title"
        case toBeAnnouncedAddress = "to_be_announced_address"
        case isVirtual = "is_virtual"
        case virtualTitleImage = "virtual_title_image"
        case virtualExternalDocument = "virtual_external_document"
        case eventID = "event_id"
        case isAdditionalSettings = "is_additional_settings"
        case virtualTitleVideo = "virtual_title_video"
        case addDetailsDescription = "add_details_description"
        case eventAddress = "event_address"
        case virtualImages = "virtual_images"
        case isToBeAnnounced = "is_to_be_announced"
        case latitude
        case virtualEventHostLink = "virtual_event_host_link"
        case eventCountry = "event_country"
        case longitude
        case virtualVideoLinks = "virtual_video_links"
        case eventState = "event_state"
        case id
        case virtualLiveVideoURL = "virtual_live_video_url"
        case virtualVideoUrls = "virtual_video_urls"
        case eventCity = "event_city"
        case locationDescription = "location_description"
        case isAddressField = "is_address_field"
    }
}

// MARK: - EventRefundPolicy
struct EventRefundPolicy: Codable {
    var policyName, policyDescription: String?

    enum CodingKeys: String, CodingKey {
        case policyName = "policy_name"
        case policyDescription = "policy_description"
    }
}

// MARK: - EventTagsObj
struct EventTagsObj: Codable {
    var eventTags: [String]?
    var eventTagline, tagsDescription: String?

    enum CodingKeys: String, CodingKey {
        case eventTags = "event_tags"
        case eventTagline = "event_tagline"
        case tagsDescription = "tags_description"
    }
}

// MARK: - DataEventType
struct DataEventType: Codable {
    var eventTypeTitle: String?

    enum CodingKeys: String, CodingKey {
        case eventTypeTitle = "event_type_title"
    }
}

// MARK: - Organizer
struct Organizer: Codable {
    var id: Int?
    var bio: String?
    var isActive: Bool?
    var eventDescription, createdAt, updatedAt, facebookID: String?
    var twitterID, name, instagramID: String?
    var profileImage: String?
    var isEmailOptIn: Bool?
    var userID: Int?
    var website: String?
    var followers: Int?
    var promoterEmail: String?

    enum CodingKeys: String, CodingKey {
        case id
        case bio
        case isActive = "is_active"
        case eventDescription = "event_description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case facebookID = "facebook_id"
        case twitterID = "twitter_id"
        case name
        case instagramID = "instagram_id"
        case profileImage = "profile_image"
        case isEmailOptIn = "is_email_opt_in"
        case userID = "user_id"
        case website, followers
        case promoterEmail = "promoter_email"
    }
}

// MARK: - PaymentMode
struct PaymentMode: Codable {
    var isFullPayment: Bool?
    var installmentMaxNo: JSONNull?
    var paymentModeDiscountType: String?
    var discountAmountValue, installmentLastDate: JSONNull?
    var emiPeriod: String?
    var partialPaymentFee: JSONNull?
    var isPerOrder, isPerTicket: Bool?

    enum CodingKeys: String, CodingKey {
        case isFullPayment = "is_full_payment"
        case installmentMaxNo = "installment_max_no"
        case paymentModeDiscountType = "payment_mode_discount_type"
        case discountAmountValue = "discount_amount_value"
        case installmentLastDate = "installment_last_date"
        case emiPeriod = "emi_period"
        case partialPaymentFee = "partial_payment_fee"
        case isPerOrder = "is_per_order"
        case isPerTicket = "is_per_ticket"
    }
}

// MARK: - MultiLocation
struct MultiLocation: Codable {
    var id: Int?
    var latitude, longitude, eventAddress, locationType: String?
    var eventCountry: String?

    enum CodingKeys: String, CodingKey {
        case id, latitude, longitude
        case eventAddress = "event_address"
        case locationType = "location_type"
        case eventCountry = "event_country"
    }
}

// MARK: - RecurringList
struct RecurringList: Codable {
    var eventOccurs: String?
    var eventID: Int?
    var isActive: Bool?
    var weeklyDays: [String]?
    var createdAt: String?
    var eventShowDate: [String]?
    var id: Int?
    var onDays: String?
    var updatedAt: String?
    var startDate: String?
    var isShowDate: Bool?
    var createdBy: String?
    var endDate: String?
    var showDate, updatedBy: String?
    var startTime: String?
    var onWeek: Int?
    var eventTimeZoneID: Int?
    var endTime: String?
    var showName: String?
    var eventLanguageID, eventLocationID: Int

    enum CodingKeys: String, CodingKey {
        case eventOccurs = "event_occurs"
        case eventID = "event_id"
        case isActive = "is_active"
        case weeklyDays = "weekly_days"
        case createdAt = "created_at"
        case eventShowDate = "event_show_date"
        case id
        case onDays = "on_days"
        case updatedAt = "updated_at"
        case startDate = "start_date"
        case isShowDate = "is_show_date"
        case createdBy = "created_by"
        case endDate = "end_date"
        case showDate = "show_date"
        case updatedBy = "updated_by"
        case startTime = "start_time"
        case onWeek = "on_week"
        case eventTimeZoneID = "event_time_zone_id"
        case endTime = "end_time"
        case showName = "show_name"
        case eventLanguageID = "event_language_id"
        case eventLocationID = "event_location_id"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        var container = try decoder.singleValueContainer()
        if !container.decodeNil() {
           // throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    var key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    var value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        var context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        var context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if var value = try? container.decode(Bool.self) {
            return value
        }
        if var value = try? container.decode(Int64.self) {
            return value
        }
        if var value = try? container.decode(Double.self) {
            return value
        }
        if var value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if var value = try? container.decode(Bool.self) {
            return value
        }
        if var value = try? container.decode(Int64.self) {
            return value
        }
        if var value = try? container.decode(Double.self) {
            return value
        }
        if var value = try? container.decode(String.self) {
            return value
        }
        if var value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if var value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if var value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if var value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if var value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if var value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            var value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            var value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if var value = value as? Bool {
                try container.encode(value)
            } else if var value = value as? Int64 {
                try container.encode(value)
            } else if var value = value as? Double {
                try container.encode(value)
            } else if var value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if var value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if var value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            var key = JSONCodingKey(stringValue: key)!
            if var value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if var value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if var value = value as? Double {
                try container.encode(value, forKey: key)
            } else if var value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if var value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if var value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if var value = value as? Bool {
            try container.encode(value)
        } else if var value = value as? Int64 {
            try container.encode(value)
        } else if var value = value as? Double {
            try container.encode(value)
        } else if var value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            var container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if var arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if var dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
