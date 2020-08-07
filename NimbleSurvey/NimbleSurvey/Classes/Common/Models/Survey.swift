//
//  Survey.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/5/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation

struct Survey: Codable {
    let title: String?
    let description: String?
    let coverImageUrl: String?
    let thankEmail: String?

    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case coverImageUrl = "cover_image_url"
        case thankEmail = "thank_email_above_threshold"
    }
    
    public init(title: String, des: String, url: String) {
        self.title = title
        self.description = des
        self.coverImageUrl = url
        self.thankEmail = ""
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        coverImageUrl = try container.decode(String.self, forKey: .coverImageUrl)
        thankEmail = try container.decode(String.self, forKey: .thankEmail)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(title, forKey: .title)
        try? container.encode(description, forKey: .description)
        try? container.encode(coverImageUrl, forKey: .coverImageUrl)
        try? container.encode(thankEmail, forKey: .thankEmail)
    }

}
