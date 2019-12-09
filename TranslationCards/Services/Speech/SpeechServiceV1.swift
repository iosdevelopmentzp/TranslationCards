//
//  SpeechServiceV1.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 09.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import AVFoundation

class SpeechServiceV1: SpeechService {
    
    fileprivate let speechSynthesizer = AVSpeechSynthesizer()
    
    func speakText(_ inputData: SpeechData) {
        if let lenguage = inputData.language {
            let speechType = SpeechLanguageType.initWithLanguage(language: lenguage)
            speakText(inputData.text, languageIdentifier: speechType.identifier)
            return
        }
        
        guard let detectedLanguageIdentifier = inputData.text.detectLanguage(),
            let speechLangTyppe = SpeechLanguageType.initWithLanguageDetectedIdentifier(detectedLanguageIdentifier) else {
            return
        }
        speakText(inputData.text, languageIdentifier: speechLangTyppe.identifier)
    }
    
    func stopSpeaking() {
        speechSynthesizer.stopSpeaking(at: .word)
    }
    
    //MARK: - Private
    fileprivate func speakText(_ text: String, languageIdentifier: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: languageIdentifier)

        speechSynthesizer.stopSpeaking(at: .word)
        speechSynthesizer.speak(utterance)
    }
}
