//
//  AuthResponse.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/5/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
struct AuthResponse: Codable {
    let accessToken: String?
    let tokenType: String?
    let expiresIn: Int64?
    let createdAt: Int64?

    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case createdAt = "created_at"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try container.decode(String.self, forKey: .accessToken)
        tokenType = try container.decode(String.self, forKey: .tokenType)
        expiresIn = try container.decode(Int64.self, forKey: .expiresIn)
        createdAt = try container.decode(Int64.self, forKey: .createdAt)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(accessToken, forKey: .accessToken)
        try? container.encode(tokenType, forKey: .tokenType)
        try? container.encode(expiresIn, forKey: .expiresIn)
        try? container.encode(createdAt, forKey: .createdAt)
    }

}
