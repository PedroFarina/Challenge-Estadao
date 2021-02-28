//
//  PreviewNews.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 28/02/21.
//

import Foundation

internal struct PreviewNews: Codable {
    var id_documento: String
    var chapeu: String
    var titulo: String
    var linha_fina: String
    var data_hora_publicacao: String
    var url: URL
    var imagem: URL
    var source: String
}
