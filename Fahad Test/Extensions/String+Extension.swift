//
//  Data+Extension.swift
//  Fahad Test
//
//  Created by Mac on 15/11/2022.
//

import Foundation
import UIKit
import AVKit
import CommonCrypto

extension String {
    func convertDateFormatter(givenFormat: String, desiredFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = givenFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let convertedDate = dateFormatter.date(from: self)
        
        guard dateFormatter.date(from: self) != nil else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = desiredFormat
        let timeStamp = dateFormatter.string(from: convertedDate!)
        return timeStamp
    }
    
    func convertStringToDate(givenFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = givenFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let convertedDate = dateFormatter.date(from: self)
        return convertedDate!
    }
    
    func convertLocalDateToUTCDate(desiredFormat: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = desiredFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        // dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let date = dateFormatter.date(from: self)
        return date!
    }
    
    func convertTimeFrom24To12HoursFormat() -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "HH:mm:ss"

        let date = df.date(from: self)
        df.dateFormat = "h:mm a"

        let time12 = df.string(from: date!)
        return time12
    }
    
    func convertTimeFrom12To24HoursFormat(givenTimeFormat: String = "h:mma") -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = givenTimeFormat

        let date = df.date(from: self)
        df.dateFormat = "HH:mm:ss"

        let time24 = df.string(from: date!)
        return time24
    }
    
    func textToImage() -> UIImage? {
        let nsString = (self as NSString)
        let font = UIFont.systemFont(ofSize: 50) // you can change your font size here
        let stringAttributes = [NSAttributedString.Key.font: font]
        let imageSize = nsString.size(withAttributes: stringAttributes)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0) //  begin image context
        UIColor.clear.set() // clear background
        UIRectFill(CGRect(origin: CGPoint(), size: imageSize)) // set rect size
        nsString.draw(at: CGPoint.zero, withAttributes: stringAttributes) // draw text within rect
        let image = UIGraphicsGetImageFromCurrentImageContext() // create image from context
        UIGraphicsEndImageContext() //  end image context
        
        return image ?? UIImage()
    }
    
    func convertUtcStringToDate(desiredFormat: String) -> Date {
        let format = DateFormatter()
        format.locale = Locale(identifier: "en_US_POSIX")
        format.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        format.dateFormat = desiredFormat
        let date = format.date(from: self)
        return date!
    }
    
    func getThumbnail() -> UIImage? {
        
        let asset = AVURLAsset(url: NSURL(fileURLWithPath: self) as URL, options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        imgGenerator.appliesPreferredTrackTransform = true
        
        if let cgImage = try? imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil) {
            
            let uiImage = UIImage(cgImage: cgImage)
            return uiImage
            
        } else {
            return nil
        }
    }
    
    func convertLocalDateToUTCDate(givenFormat: String, desiredFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = givenFormat
        let convertedDate = dateFormatter.date(from: self)
        
        guard dateFormatter.date(from: self) != nil else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = desiredFormat
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)
        return timeStamp
    }
    
    func convertUTCDateToLocalDate(givenFormat: String, desiredFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = givenFormat
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let convertedDate = dateFormatter.date(from: self)
        
        guard dateFormatter.date(from: self) != nil else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = desiredFormat
        dateFormatter.timeZone = NSTimeZone.local
        let timeStamp = dateFormatter.string(from: convertedDate!)
        return timeStamp
    }
    
    func numberOfSeconds() -> Int {
        let components: Array = self.components(separatedBy: ":")
        let hours = Int(components[0]) ?? 0
        let minutes = Int(components[1]) ?? 0
        return (hours * 3600) + (minutes * 60)
    }
    
    func date(fromFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)!
        return dateFormatter.date(from: self)
    }
    
    func hasOnlyEmptySpaces() -> Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func separatedPath() -> String {
        return self.components(separatedBy: "/").last ?? ""
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func underLine(font: UIFont) -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, self.count))
        return attributeString
    }
    
    var decodeBase64: String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func trunctateString(charCount: Int) -> String {
        var str = self
        if str.count > charCount {
            str = str.prefix(charCount) + "..."
        }
        return str
    }
    
    func isFavorite() -> Bool {
        return self == "favorite"   // second case "unfavorite"
    }
    
    func convertHoursMinsShortString() -> String {
        if self == "hours" || self == "hr" || self == "ساعة" {
            return "hr"
        } else {
            return "min"
        }
    }
    
    func convertHoursMinsFullString() -> String {
        if self == "hours" || self == "hr" || self == "ساعة" {
            return "hours"
        } else {
            return "minutes"
        }
    }
    
    func before(first delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            let before = prefix(upTo: index)
            return String(before)
        }
        return ""
    }
    
    func after(first delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            let after = suffix(from: index).dropFirst()
            return String(after)
        }
        return ""
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
         let fontAttributes = [NSAttributedString.Key.font: font]
         let size = self.size(withAttributes: fontAttributes)
         return size.width
     }
}

extension NSMutableAttributedString {
    // If no text is send, then the style will be applied to full text
    func setColorForText(_ textToFind: String?, with color: UIColor) {
        
        let range: NSRange?
        if let text = textToFind {
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        } else {
            range = NSRange(location: 0, length: self.length)//NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range!)
        }
    }
}
