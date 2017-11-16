#import <UIKit/UIKit.h>

@interface mbScrollV : UIViewController <UITextFieldDelegate>
{
    UIScrollView* scrollView; //  указатель на наш UIScrollView
    UITextField* activeField; // указывает на активный элемент ввода
}

@end
