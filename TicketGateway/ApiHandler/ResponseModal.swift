//
//  ResponseModal.swift
//  TicketGateway
//
//  Created by Apple  on 10/04/23.

import Foundation
struct ResponseModal<T: Codable>: Codable {
    var message, status: String?
    var statusCode: Int?
    var success: Bool?
    var data: T?
    var total, page, size: Int?
    private enum CodingKeys: String, CodingKey {
        case status, message, data, success, total, page, size
        case statusCode = "status_code"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decodeIfPresent(String.self, forKey: .status)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
        statusCode = try? values.decodeIfPresent(Int.self, forKey: .statusCode)
        success = try? values.decodeIfPresent(Bool.self, forKey: .success)
        total = try? values.decodeIfPresent(Int.self, forKey: .total)
        page = try? values.decodeIfPresent(Int.self, forKey: .page)
        size = try? values.decodeIfPresent(Int.self, forKey: .size)

        do {
              data = try values.decodeIfPresent(T.self, forKey: .data)
            } catch {
              print(error)
              data = nil
            }
    }
}
