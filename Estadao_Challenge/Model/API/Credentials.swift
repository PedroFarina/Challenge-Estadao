//
//  Credentials.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 28/02/21.
//

internal struct Credentials: Codable {
    internal static let defaultEstadao = Credentials(user: "devmobile", pass: "uC&+}H4wg?rYbF:")

    var user: String
    var pass: String
}
