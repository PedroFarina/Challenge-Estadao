//
//  FullNews.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 28/02/21.
//

import Foundation

internal struct FullNews: Codable {
    var documento: Document
}

internal struct Document: Codable {
    var url: URL
    var source: String
    var produto: String
    var editoria: String
    var subeditoria: String
    var titulo: String
    var credito: String
    var datapub: String
    var horapub: String
    var linhafina: String
    var imagem: URL
    var thumbnail: URL
    var creditoImagem: String
    private var legendaImagem: String
    var origem: String
    var id: String
    private var corpoformatado: String

    func getLegenda() -> NSAttributedString {
        legendaImagem.toHTML()
    }

    func getCorpoFormatado() -> NSAttributedString {
        corpoformatado.toHTML()
    }
}
