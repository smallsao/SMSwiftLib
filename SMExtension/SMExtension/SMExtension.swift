//
//  SMCommonUtil.swift
//  SMCommonUtil
//
//  Created by smallsao on 16/7/13.
//

import Foundation
import UIKit


/// String
extension String {
    /**
     删除首位的空白（包含空格与换行）
     
     - author: smallsao
     - date: 16-07-18 16:07:28
     
     - returns: 去除之后的String
     */
    public func delWhiteSpace() -> String {
        let s = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return s
    }
    
    /**
     字符串截取
     
     - author: smallsao
     - date: 16-07-18 16:07:54
     
     - parameter from: 从Int
     - parameter to:   至Int
     
     - returns: 截取的String
     */
    public func findString(from:Int, to:Int) -> String {
        let begin = self.index(self.startIndex, offsetBy: from)
        let end = self.index(self.startIndex, offsetBy: to)
        var s = self.substring(to: end)
        s = s.substring(from: begin)
        return s
    }
    
    /**
     判断字符串是够为空
     
     - author: smallsao
     - date: 16-07-18 16:07:22
     
     - returns: Bool
     */
    public func isEmpty() -> Bool {
        var s = self.replacingOccurrences(of: " ", with: "")
        s = s.delWhiteSpace()
        if s.characters.count == 0 {
            return true
        }
        else {
            return false
        }
        
    }
    
    /**
     判断是否为数字，包含数字，整型，浮点型
     
     - author: smallsao
     - date: 16-07-13 13:07:13
     
     - returns: 是否为数字
     */
    public func isNumber() -> Bool {
        let s = self.delWhiteSpace()
        if s.isEmpty() == true {
            return false
        }
        else {
            var count = 0
            for index in 0 ..< s.characters.count {
                let c = s[s.index(self.startIndex, offsetBy: index)]
                if (c >= "0" && c <= "9") || (c == ".") {
                    if c == "." {
                        if (index == 0) || (index == s.characters.count - 1) {
                            // 如果以.开头或者结尾
                            return false;
                        }
                        else {
                            count = count + 1
                        }
                    }
                }
                else {
                    return false;
                }
            }
            
            if s.characters.count > 1 {
                let firstC = s[s.index(self.startIndex, offsetBy: 0)]
                let secondC = s[s.index(self.startIndex, offsetBy: 1)]
                if firstC == "0" && secondC != "." {
                    return false
                }
            }
            
            if count > 1 {
                return false
            }
            else {
                return true
            }
        }
    }
    
    /**
     判断是否为Int
     
     - author: smallsao
     - date: 16-07-18 16:07:47
     
     - returns: Bool
     */
    public func isInt() -> Bool{
        let s = self.delWhiteSpace()
        if s.characters.count == 0 {
            return false
        }
        else {
            for index in 0 ..< s.characters.count{
                let c = s[s.index(self.startIndex, offsetBy: index)]
                if c >= "0" && c <= "9" {
                    if c == "0" && index == 0 && self.characters.count > 1 {
                        return false
                    }
                }
                else {
                    return false
                }
            }
            return true
        }
    }
    
    

    /**
     获取字符串中的某个位置的Char
     
     - author: smallsao
     - date: 16-07-18 16:07:09
     
     - parameter index: 位置
     
     - returns: Char
     */
    public func charInString(index:Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
    
    /**
     获取字符串中的某个位置的String
     
     - author: smallsao
     - date: 16-07-18 16:07:18
     
     - parameter index: 位置
     
     - returns: String
     */
    public func stringInString(index:Int) -> String {
        return String(self.charInString(index: index))
    }
    
    /**
     根据字符串、字体、展示范围、计算真实范围
     
     - author: smallsao
     - date: 16-07-18 16:07:42
     
     - parameter font: 字体
     - parameter size: 展示范围
     
     - returns: 真实范围
     */
    public func smSize(font:UIFont, size:CGSize) -> CGSize{
        var attributes = [NSFontAttributeName: font]
        var option = NSStringDrawingOptions(rawValue: 1)
        let rect:CGRect = self.boundingRect(with: size, options:option, attributes: attributes, context: nil)
        return CGSize(width: rect.width, height: rect.height)
    }

    /**
     将字符串转换成列表
     iam周方涛👌  ===>   ['i','a','m','周','方','涛','👌']
     
     - author: smallsao
     - date: 16-07-18 16:07:26
     
     - returns: Array
     */
    public func chineseWords() -> Array<String> {
        var words = Array<String>()
        let str = self.cString(using: .utf8)!
        
        for (_, value) in self.characters.enumerated() {
            
            let s = String(value)
            words.append(s)
        }
        return words
    }
    
    /**
     获取字符串长度 
     英文，空格、数字为0.5
     中文为 1
     
     - author: smallsao
     - date: 16-07-18 16:07:10
     
     - returns: 长度
     */
    public func chineseWordsLength() -> Float {
        let words = self.chineseWords()
        
        var count:Float = 0.0
        
        for word in words {
            
            let char = word[word.startIndex]
            
            if ("\u{4E00}" <= char  && char <= "\u{9FA5}") {
                count = count + 1
            }
            else {
                count = count + 0.5
            }
        }
        return count
    }
    
    
    /**
     进行base64机密
     
     - author: smallsao
     - date: 16-07-19 15:07:31
     
     - returns: base64String
     */
    public func base64Encode() -> String {
        let data = self.data(using: .utf8)
        let base64Sting = data?.base64EncodedString(options: .lineLength64Characters)
        
        return base64Sting!
    }
    
    
    /**
     进行base64解密
     
     - author: smallsao
     - date: 16-07-19 15:07:43
     
     - returns: string
     */
    public func base64Decode() -> String {
        let data = Data(base64Encoded: self, options: .lineLength64Characters)
        let s = String(data: data!, encoding: .utf8)
        
        return s!
    }
    
    
    /**
     根据string 获取 int
     
     - author: smallsao
     - date: 16-07-19 15:07:18
     
     - returns: int
     */
    public func intValue() -> Int {
        if let f = Float(self) {
            return Int(f)
        }
        else if let f = Double(self) {
            return Int(f)
        }
        else {
            let k:Int? = Int(self)
            if k == nil {
                return 0;
            }
            return k!
        }
    }
    
    /**
     根据 String 获取 Float
     
     - author: smallsao
     - date: 16-07-19 15:07:36
     
     - returns: Float
     */
    public func floatValue() -> Float{
        let k:Float? = Float(self)
        if k == nil {
            return 0.0;
        }
        
        return k!
    }
    
    /**
     根据 String 获取 Double
     
     - author: smallsao
     - date: 16-07-19 15:07:50
     
     - returns: Double
     */
    public func doubleValue() -> Double {
        let k:Double? = Double(self)
        if k == nil {
            return 0.0;
        }
        
        return k!
    }
    
    /**
     根据 String 获取 Bool
     
     - author: smallsao
     - date: 16-07-19 15:07:07
     
     - returns: Bool
     */
    public func boolValue() -> Bool {
        return Bool(self.intValue())
    }
    
    /**
     获取字符串长度
     
     - author: smallsao
     - date: 16-07-20 16:07:33
     
     - returns: 长度
     */
    public func length() -> Int {
        return self.characters.count
    }
}


/**
 AnyObject to String
 
 - author: smallsao
 - date: 16-07-19 15:07:20
 
 - parameter obj: AnyObject
 
 - returns: String
 */
public func obj2Str(obj: AnyObject) -> String? {
    if obj is String {
        return obj as! String;
    }
    else if obj is Int {
        return String(obj as! Int)
    }
    else if obj is Float {
        return String(obj as! Float)
    }
    else if obj is Double {
        return String(obj as! Double)
    }
    else if obj is Array<AnyObject>{
        let array = obj as! Array<AnyObject>
        let k:String = array.description
        return k
    }
    else {
        return obj.description
    }
}




/// Data






/// Array
extension Array {
    public func stringValue(index:Int) -> String {
        if index < self.count {
            let value = self[index]
            return obj2Str(obj: value as! AnyObject)!
        }
        else {
            return ""
        }
    }
}



/// Dictionary
extension Dictionary {
    
    /**
     从字典中获取String类型的value
     
     - author: smallsao
     - date: 16-07-13 13:07:32
     
     - parameter key: key
     
     - returns: value
     */
    public func stringValue(key:Key) -> String {
        let value = self[key]
        if value == nil {
            return ""
        }
        else {
            return obj2Str(obj: value as! AnyObject)!
        }
    }
    
    /**
     从字典中获取Int类型的value
     
     - author: smallsao
     - date: 16-07-13 13:07:13
     
     - parameter key: key
     
     - returns: value
     */
    public func intValue(key:Key) -> Int {
        let value:String! = self.stringValue(key:key)
        if value != "" {
            return value.intValue()
        }
        else {
            return 0
        }
    }
    
    
    /**
     从字典中获取Array类型的value
     
     - author: smallsao
     - date: 16-07-13 13:07:20
     
     - parameter key: key
     
     - returns: value
     */
    public func arrayValue(key:Key) -> Array<AnyObject> {
        let value = self[key]
        if value == nil {
            return Array()
        }
        else if value is Array<AnyObject> {
            return value as! Array<AnyObject>;
        }
        else {
            return Array()
        }
    }
    
    /**
     从字典中获取Dictionary类型的value
     
     - author: smallsao
     - date: 16-07-13 13:07:39
     
     - parameter key: key
     
     - returns: value
     */
    public func dictionaryValue(key:Key) -> Dictionary {
        let value = self[key]
        if value == nil {
            return Dictionary()
        }
        else if value is Dictionary {
            return value as! Dictionary
        }
        else {
            return Dictionary()
        }
    }
    
    /**
     从字典中获取Float类型的value
     
     - author: smallsao
     - date: 16-07-13 13:07:02
     
     - parameter key: key
     
     - returns: value
     */
    public func floatValue(key:Key) -> Float {
        let value:String! = self.stringValue(key: key)
        if value != "" {
            return value.floatValue()
        }
        else {
            return 0.0
        }
    }
    
    /**
     从字典中获取Double类型的数据
     
     - author: smallsao
     - date: 16-07-13 13:07:18
     
     - parameter key: key
     
     - returns: value
     */
    public func doubleValue(key:Key) -> Double {
        let value:String! = self.stringValue(key: key)
        if value != "" {
            return value.doubleValue()
        }
        else {
            return 0.0
        }
    }
    
    /**
     从字典中获取Bool类型的数据
     
     - author: smallsao
     - date: 16-07-13 13:07:28
     
     - parameter key: key
     
     - returns: value
     */
    public func boolValue(key:Key) -> Bool {
        return Bool(self.intValue(key: key))
    }    
}


public func SMRGB(_ rgbValue:UInt) -> UIColor{
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

public func SMFont(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

public func SMBFont(_ size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
}


