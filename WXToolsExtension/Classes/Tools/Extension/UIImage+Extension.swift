//
//  UIImage+Extension.swift
//  DoctorProject
//
//  Created by wangxu on 2020/7/23.
//  Copyright © 2020 Ly. All rights reserved.
//

import UIKit

extension UIImage{
    func imageWithTintColor(color : UIColor) -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)//kCGBlendModeNormal
        context?.setBlendMode(.normal)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.clip(to: rect, mask: self.cgImage!);
        color.setFill()
        context?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // 压缩图片尺寸
    func scaleImageToSize(_ newSize: CGSize) -> UIImage {
        if newSize.equalTo(self.size) {
            return self
        }
        
        // Create a graphics image context
        UIGraphicsBeginImageContextWithOptions(newSize, true, UIScreen.main.scale)
        
        // new size
        self.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        
        // Get the new image from the context
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context
        UIGraphicsEndImageContext()
        // Return the new image.
        return newImage!
    }
    //压缩图片质量
    func reduceImageWithPercent(_ percent: CGFloat) -> UIImage? {
        if let imageData = self.jpegData(compressionQuality: percent){
            let newImage =  UIImage(data: imageData)
            return newImage
        } else {
            return nil
        }
    }
    // 获取启动图片
    static var launchImage: UIImage? {
        let imagesDict = Bundle.main.infoDictionary?["UILaunchImages"] as? [[String : String]]
        if let index = imagesDict?.index(where: {
            if let imageSizeStr = $0["UILaunchImageSize"] {
                if NSCoder.cgSize(for: imageSizeStr) == CGSize(width: screenWidth, height: screenHeight) {
                    return true
                }
            }
            return false
        }) {
            if let imgName = imagesDict?[index]["UILaunchImageName"] {
                return UIImage(named: imgName)
            }
        }
        
        return nil
    }
    // 默认的缩略图，上传服务器用
    var defaultThumbImageData: Data? {
        return self.scaleImageToSize(self.defaultTargetSize).jpegData(compressionQuality: 0.6)//UIImageJPEGRepresentation(self.scaleImageToSize(self.defaultTargetSize), 0.6)
    }
    
    // 默认的缩略图，上传服务器用
    var defaultThumbnailImage: UIImage? {
        return self.scaleImageToSize(self.defaultTargetSize).reduceImageWithPercent(0.6)
    }
    // iPhone不模糊的尺寸
    var defaultTargetSize: CGSize {
        let originSize = self.size;
        var targetSize = CGSize.zero;
        
        if (originSize.width > 1242) {
            targetSize.width = 1242;
            targetSize.height = ceil(targetSize.width*originSize.height/originSize.width);
            
        } else {
            targetSize = originSize;
        }
        
        return targetSize;
    }
    // 修正UIImage图像方向
    // 使用 UIImagePicker 调用手机相机拍照或者图库中的照片，到了 UIImage 中显示都是横七竖八的，
    // 这样导致显示到 View 或者上传到服务器的图片跟实际的不一样。
    var fixOrientationImage: UIImage {
        if (self.imageOrientation == .up) {
            return self
        }
        
        var transform = CGAffineTransform.identity
        
        switch (self.imageOrientation) {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat.pi)
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi/2)
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -CGFloat.pi/2)
            
        default:
            break
        }
        
        switch (self.imageOrientation) {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        default:
            break
        }
        
        let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height),
                            bitsPerComponent: (self.cgImage?.bitsPerComponent)!, bytesPerRow: 0,
                            space: (self.cgImage?.colorSpace!)!,
                            bitmapInfo: (self.cgImage?.bitmapInfo.rawValue)!)
        ctx?.concatenate(transform)
        
        switch (self.imageOrientation) {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.height,height: self.size.width))
            
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.width,height: self.size.height))
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg = ctx?.makeImage()
        return UIImage(cgImage: cgimg!)
    }
}
