//
//  ResponseModal.swift
//  TicketGateway
//
//  Created by Apple  on 10/04/23.
// swiftlint: disable identifier_name
// swiftlint: disable force_try
import Foundation
struct ResponseModal<T: Codable>: Codable {
    let message, status: String?
    let status_code: Int?
    let success: Bool
    let data: T?
    private enum CodingKeys: String, CodingKey {
        case status, message, data, status_code, success
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decodeIfPresent(String.self, forKey: .status)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
        status_code = try? values.decodeIfPresent(Int.self, forKey: .status_code)
        success = try! values.decodeIfPresent(Bool.self, forKey: .success) ?? false
        do {
              data = try values.decodeIfPresent(T.self, forKey: .data)
            } catch {
              print(error)
              data = nil
            }
    }
}
