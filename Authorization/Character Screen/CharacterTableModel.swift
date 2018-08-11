//
//  CharacterTableModel.swift
//  Authorization
//
//  Created by Рома Сорока on 11.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

class CharacterTableModel {
    var urlSession = URLSession.shared
    
    let localeCodes = ["bg_BG", "da_DK", "el_GR", "en_NG", "en_ZA", "fi_FI", "he_IL", "ka_GE", "me_ME", "nl_NL", "pt_PT", "sr_Cyrl_RS", "tr_TR", "zh_TW", "ar_JO", "en_AU", "en_NZ", "es_AR", "hr_HR", "kk_KZ", "ro_MD", "sr_Latn_RS", "uk_UA", "ar_SA", "bn_BD", "de_AT", "en_CA", "en_PH", "es_ES", "fr_BE", "is_IS", "ko_KR", "mn_MN", "ro_RO", "sr_RS", "at_AT", "de_CH", "en_GB", "en_SG", "es_PE", "fr_CA", "hu_HU", "it_CH", "nb_NO", "ru_RU", "sv_SE", "de_DE", "en_HK", "en_UG", "es_VE", "fr_CH", "hy_AM", "it_IT", "lt_LT", "ne_NP", "pl_PL", "sk_SK", "vi_VN", "cs_CZ", "el_CY", "en_IN", "en_US", "fa_IR", "fr_FR", "id_ID", "ja_JP", "lv_LV", "nl_BE", "pt_BR", "sl_SI", "th_TH", "zh_CN"]
    lazy var chosenLocale = { localeCodes[0] }()
    var characterCount = [Character: Int]()
    var sortedArray = [Character]()
    
    func loadChars(locale: String? = nil, complition: @escaping (RespoceError?) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.chosenLocale = locale ?? self.localeCodes[0]
            let req = ServerDefaults.shared.getText(locale: self.chosenLocale)
            self.urlSession.dataTask(with: req) { (data, responce, error) in
                guard let httpResp = responce as? HTTPURLResponse,
                    httpResp.statusCode == 200
                    else {
                        print(String.init(data: data!, encoding: .utf8)!)
                        complition(RespoceError.unknown)
                        return
                }
                let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                self.parse(text: json["data"] as! String)
                
                complition(nil)
                
            }.resume()
            
        }
    }
    
    func parse(text: String) {
        for char in text {
            if characterCount[char] != nil {
                characterCount[char]! += 1
            } else {
                characterCount[char] = 1
                sortedArray.append(char)
            }
        }
        sortedArray.sort()
    }
    
}








