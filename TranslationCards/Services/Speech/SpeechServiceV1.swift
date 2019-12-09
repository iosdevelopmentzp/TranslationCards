//
//  SpeechServiceV1.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 09.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import AVFoundation

class SpeechServiceV1: SpeechService {
    func speakText(_ text: String, language: SpeechLanguageType? = nil) {
        if let lenguage = language {
            speakText(text, languageIdentifier: lenguage.identifier)
            return
        }
        
        guard let detectedLanguageIdentifier = text.detectLanguage(),
            let speechLangTyppe = SpeechLanguageType.initWithLanguageDetectedIdentifier(detectedLanguageIdentifier) else {
            return
        }
        speakText(text, languageIdentifier: speechLangTyppe.identifier)
    }
    
    //MARK: - Private
    fileprivate func speakText(_ text: String, languageIdentifier: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: languageIdentifier)

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
}
