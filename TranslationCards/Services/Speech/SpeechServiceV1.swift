//
//  SpeechServiceV1.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 09.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import AVFoundation

final class SpeechServiceV1: SpeechService {
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    func speakText(withSpeechData speechData: SpeechData) {
        if let lenguage = speechData.language {
            let speechType = SpeechLanguageType.initWithLanguage(language: lenguage)
            speakText(speechData.text, languageIdentifier: speechType.identifier)
            return
        }
        
        guard let detectedLanguageIdentifier = speechData.text.detectLanguage(),
            let speechLangTyppe = SpeechLanguageType.initWithLanguageDetectedIdentifier(detectedLanguageIdentifier) else {
            return
        }
        speakText(speechData.text, languageIdentifier: speechLangTyppe.identifier)
    }
    
    func stopSpeaking() {
        speechSynthesizer.stopSpeaking(at: .word)
    }
    
    //MARK: - Private
    private func speakText(_ text: String, languageIdentifier: String) {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error \(error).")
        }
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: languageIdentifier)

        speechSynthesizer.stopSpeaking(at: .word)
        speechSynthesizer.speak(utterance)
    }
}
