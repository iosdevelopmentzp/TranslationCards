//
//  sdf.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 09.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

enum SpeechLanguageType: String {
    case rus
    case eng
    case spa
    case deu
    
    static func initWithLanguage(language: Language) -> Self {
        switch language {
        case .rus:
            return .rus
        case .eng:
            return .eng
        case .spa:
            return .spa
        case .deu:
            return .deu
        }
    }
   
    static func initWithLanguageDetectedIdentifier(_ identifier: String) -> Self? {
        switch identifier {
        case "English":
            return  SpeechLanguageType.eng
        case "Russian":
            return  SpeechLanguageType.rus
        case "Spanish":
            return SpeechLanguageType.spa
        case "German":
            return SpeechLanguageType.deu
        default: return nil
        }
    }
    
    var identifier: String {
        switch self {
        case .rus:
            return "ru-RU"
        case .eng:
            return "en-GB"
        case .spa:
            return "es-ES"
        case .deu:
            return "de-DE"
        }
    }
}

/*
 Arabic (Saudi Arabia) - ar-SA
 Chinese (China) - zh-CN
 Chinese (Hong Kong SAR China) - zh-HK
 Chinese (Taiwan) - zh-TW
 Czech (Czech Republic) - cs-CZ
 Danish (Denmark) - da-DK
 Dutch (Belgium) - nl-BE
 Dutch (Netherlands) - nl-NL
 English (Australia) - en-AU
 English (Ireland) - en-IE
 English (South Africa) - en-ZA
 English (United Kingdom) - en-GB
 English (United States) - en-US
 Finnish (Finland) - fi-FI
 French (Canada) - fr-CA
 French (France) - fr-FR
 German (Germany) - de-DE
 Greek (Greece) - el-GR
 Hebrew (Israel) - he-IL
 Hindi (India) - hi-IN
 Hungarian (Hungary) - hu-HU
 Indonesian (Indonesia) - id-ID
 Italian (Italy) - it-IT
 Japanese (Japan) - ja-JP
 Korean (South Korea) - ko-KR
 Norwegian (Norway) - no-NO
 Polish (Poland) - pl-PL
 Portuguese (Brazil) - pt-BR
 Portuguese (Portugal) - pt-PT
 Romanian (Romania) - ro-RO
 Russian (Russia) - ru-RU
 Slovak (Slovakia) - sk-SK
 Spanish (Mexico) - es-MX
 Spanish (Spain) - es-ES
 Swedish (Sweden) - sv-SE
 Thai (Thailand) - th-TH
 Turkish (Turkey) - tr-TR
 */
