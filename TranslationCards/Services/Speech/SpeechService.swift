//
//  SpeechService.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 09.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

protocol SpeechService: Service {
    func speakText(_ text: String, language: SpeechLanguageType?)
}
