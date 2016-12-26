// https://www.zhihu.com/question/20387257
//5,QR标准下最大尺寸是Version40,即尺寸为177*177的二维码,容量请自行换算.
#import "QRCodeCreate.h"


//http://www.cocoachina.com/ios/20140812/9363.html
#define Mask8(x) ( (x) & 0xFF )
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )
#define A(x) ( Mask8(x >> 24) )
#define RGBAMake(r, g, b, a) ( Mask8(r) | Mask8(g) << 8 | Mask8(b) << 16 | Mask8(a) << 24 )

static QRCodeCreate *QRCodeCreateShare;


@implementation QRCodeCreate{
    NSMutableArray<NSMutableArray<UIColor*>*> *imageColorArr;
 
}





+(instancetype)share{
    @synchronized(self){  //为了确保多线程情况下，仍然确保实体的唯一性
        if (!QRCodeCreateShare) {
            QRCodeCreateShare = [[self alloc] init];
        }
    }
    return QRCodeCreateShare;
}


//  http://blog.sina.com.cn/s/blog_693de6100102vtjk.html
-(UIImage*)QRCodeImageCreate:(NSString*)str{
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复默认
    [filter setDefaults];
    
    // 给过滤器添加数据
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 设置纠错级别
    [filter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    
    
    //获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    //防止生成的UIImage  的CGImage为空
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    return [[UIImage alloc] initWithCGImage:cgImage];

}

-(UInt8*)getQRCodeDataArr:(NSString*)str{
    UIImage *image = [self QRCodeImageCreate:str];
    UInt32* imageArr = [self getColorArr:image];
    CGImageRef inputCGimage = [image CGImage];
    NSUInteger width = CGImageGetWidth(inputCGimage);
    NSUInteger height = CGImageGetWidth(inputCGimage);
    
    
    
    UInt8* dataArr = (UInt8*)calloc(height*width, sizeof(UInt8));
    
    UInt32* imageArr_head = imageArr;
    for (NSUInteger j = 0; j < height; j++) {
        for (NSUInteger i = 0; i < width; i++) {
            UInt32 color = *imageArr;
            *dataArr = R(color)+G(color)+B(color)/3.0>100?1:0;
            dataArr++;
            imageArr++;
        }
    }
    free(imageArr_head);
    
    return dataArr;
}




//-----获取图片像素数组-----
-(UInt32 *)getColorArr:(UIImage*)image{
    
    
    /**
     *  主要分两步一步时
     *  1.创建一个空的位图然后保存指针，
     *  2.将图image填充到创建的位图中。
     */
    
    CGImageRef inputCGimage = [image CGImage];
    NSUInteger width = CGImageGetWidth(inputCGimage);
    NSUInteger height = CGImageGetWidth(inputCGimage);
    NSLog(@"width:%f,hieght:%f",image.size.width,image.size.height);
    
    
    imageColorArr = [[NSMutableArray alloc] initWithCapacity:height];
    for (int i = 0; i < width; ++i) {
        imageColorArr[i] = [[NSMutableArray alloc] initWithCapacity:width];
    }
    
    //NSLog(@"内存占用大小%ld",sizeof(UInt32)*width*height);
    NSUInteger bytesPerPixel = 4;//每像素大小
    NSUInteger bytesPerRow = bytesPerPixel * width;//每行有多大
    NSUInteger bitsPerComponent = 8;//每个颜色通道大小(256)
    
    //创建一个RGB模式的颜色空间CGColorSpace和一个容器CGBitmapContext,将像素指针参数传递到容器中缓存进行存储。
    UInt32 * pixels = (UInt32*)calloc(height*width, sizeof(UInt32));
    
    //http://www.devdiv.com/forum.php?mod=viewthread&tid=208309&highlight=
    CGColorSpaceRef colorSpace =     CGColorSpaceCreateDeviceRGB();//创建RGB色彩空间
    //创建位图
    CGContextRef context =  CGBitmapContextCreate(pixels, width, height, bitsPerComponent, bytesPerRow, colorSpace,     kCGImageAlphaPremultipliedLast |     kCGBitmapByteOrder32Big);
    //把缓存中的图形绘制到创建的位图上
    CGContextDrawImage(context, CGRectMake(0,0, width, height), inputCGimage);

    //保存指针头
    UInt32 * pixels_head = pixels;
//    for (NSUInteger j = 0; j < height; j++) {
//        for (NSUInteger i = 0; i < width; i++) {
//            // 3.
//            UInt32 color = *pixels;
//            printf("%3.0f ",     (R(color)+G(color)+B(color))/3.0);//打印出亮度
//            //imageColorArr[j][i] = [UIColor colorWithRed:R(color)/255.0 green:G(color)/255.0 blue:B(color)/255.0 alpha:A(color)/255.0];
//            pixels++;
//        }
//        printf("\n");
//    }
    //清除colorSpace和context.
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    return pixels_head;
}
//根据颜色数组创建图片
-(UIImage*)createImage:(UInt32*)colorArr width:(int)width height:(int)height scale:(int)scale{
//    int scale = 20;
   UInt32 * pixels = (UInt32*)calloc(height*width*scale*scale, sizeof(UInt32));
   UInt32 * pixels_head = pixels; //保存指针
   //UInt32 * colorArr_head = colorArr;
    
    for (int y = 0; y < height; ++y) {
        for (int iy = 0; iy < scale; ++iy) {
            
            for (int x = 0; x < width; ++x) {
                for (int ix = 0; ix < scale; ++ix) {
                    *pixels = *colorArr;
                    pixels++;
                }
                colorArr++;
            }
            if(iy < scale - 1)colorArr-=width;
        }
    }
    
    //创建位图
    NSUInteger bytesPerPixel = 4;//每像素大小
    NSUInteger bytesPerRow = bytesPerPixel * width * scale;//每行有多大
    NSUInteger bitsPerComponent = 8;//每个颜色通道大小(256)
    CGColorSpaceRef colorSpace =     CGColorSpaceCreateDeviceRGB();//创建RGB色彩空间
    CGContextRef context =  CGBitmapContextCreate(pixels_head, width*scale, height*scale, bitsPerComponent, bytesPerRow, colorSpace,  kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    UIImage * processedImage = [UIImage imageWithCGImage:newCGImage];
    
    //释放内存
    //清除colorSpace和context.
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    free(pixels_head);
   return processedImage;
}
@end
