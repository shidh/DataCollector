//
//  NewItermViewController.m
//  DataCollector
//
//  Created by allen on 19/03/15.
//  Copyright (c) 2015 allen. All rights reserved.
//
#import <MapKit/MapKit.h>
#import "NewItermViewController.h"
#import "CLLocationValueTrasformer.h"
//#import "CustomSelectorsFormViewController.h"
//#import "DynamicSelectorsFormViewController.h"

NSString *const kSelectorPush = @"selectorPush";
NSString *const kSelectorPopover = @"selectorPopover";
NSString *const kSelectorActionSheet = @"selectorActionSheet";
NSString *const kSelectorAlertView = @"selectorAlertView";
NSString *const kSelectorLeftRight = @"selectorLeftRight";
NSString *const kSelectorPushDisabled = @"selectorPushDisabled";
NSString *const kSelectorActionSheetDisabled = @"selectorActionSheetDisabled";
NSString *const kSelectorLeftRightDisabled = @"selectorLeftRightDisabled";
NSString *const kSelectorPickerView = @"selectorPickerView";
NSString *const kSelectorPickerViewInline = @"selectorPickerViewInline";
NSString *const kMultipleSelector = @"multipleSelector";
NSString *const kMultipleSelectorPopover = @"multipleSelectorPopover";
NSString *const kDynamicSelectors = @"dynamicSelectors";
NSString *const kCustomSelectors = @"customSelectors";
NSString *const kPickerView = @"pickerView";
NSString *const kSelectorWithSegueId = @"selectorWithSegueId";
NSString *const kSelectorWithSegueClass = @"selectorWithSegueClass";
NSString *const kSelectorWithNibName = @"selectorWithNibName";
NSString *const kSelectorWithStoryboardId = @"selectorWithStoryboardId";
NSString *const XLFormRowDescriptorTypeSelectorPickerViewInline = @"selectorPickerViewInline";

@interface NewItermViewController ()
@end



#pragma mark - NSValueTransformer

@interface NSArrayValueTrasformer : NSValueTransformer
@end

@implementation NSArrayValueTrasformer

+ (Class)transformedValueClass
{
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)value
{
    if (!value) return nil;
    if ([value isKindOfClass:[NSArray class]]){
        NSArray * array = (NSArray *)value;
        return [NSString stringWithFormat:@"%@ Item%@", @(array.count), array.count > 1 ? @"s" : @""];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [NSString stringWithFormat:@"%@ - ;) - Transformed", value];
    }
    return nil;
}

@end


@interface ISOLanguageCodesValueTranformer : NSValueTransformer
@end

@implementation ISOLanguageCodesValueTranformer

+ (Class)transformedValueClass
{
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)value
{
    if (!value) return nil;
    if ([value isKindOfClass:[NSString class]]){
        return [[NSLocale currentLocale] displayNameForKey:NSLocaleLanguageCode value:value];
    }
    return nil;
}

@end




@implementation NewItermViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeForm];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeForm];
    }
    return self;
}

- (void)initializeForm
{
    XLFormDescriptor * form = [XLFormDescriptor formDescriptorWithTitle:@"Selectors"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    // Basic Information
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Selectors"];
    section.footerTitle = @"SelectorsFormViewController.h";
    [form addFormSection:section];
    
    
    // Selector Push
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectorPush rowType:XLFormRowDescriptorTypeSelectorPush title:@"Push"];
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Option 1"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Option 3"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Option 4"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"Option 5"]
                            ];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"];
    [section addFormRow:row];
    
    // Selector Popover
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectorPopover rowType:XLFormRowDescriptorTypeSelectorPopover title:@"PopOver"];
        row.selectorOptions = @[@"Option 1", @"Option 2", @"Option 3", @"Option 4", @"Option 5", @"Option 6"];
        row.value = @"Option 2";
        [section addFormRow:row];
    }
    
    // Selector Action Sheet
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectorActionSheet rowType:XLFormRowDescriptorTypeSelectorActionSheet title:@"Sheet"];
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Option 1"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Option 3"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Option 4"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"Option 5"]
                            ];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Option 3"];
    [section addFormRow:row];
    
    
    
    
    // Selector Alert View
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectorAlertView rowType:XLFormRowDescriptorTypeSelectorAlertView title:@"Alert View"];
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Option 1"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Option 3"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Option 4"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"Option 5"]
                            ];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Option 3"];
    [section addFormRow:row];
    
    
    
    // Selector Left Right
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectorLeftRight rowType:XLFormRowDescriptorTypeSelectorLeftRight title:@"Left Right"];
    row.leftRightSelectorLeftOptionSelected = [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"];
    
    NSArray * rightOptions =  @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Right Option 1"],
                                [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Right Option 2"],
                                [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Right Option 3"],
                                [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Right Option 4"],
                                [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"Right Option 5"]
                                ];
    
    // create right selectors
    NSMutableArray * leftRightSelectorOptions = [[NSMutableArray alloc] init];
    NSMutableArray * mutableRightOptions = [rightOptions mutableCopy];
    [mutableRightOptions removeObjectAtIndex:0];
    XLFormLeftRightSelectorOption * leftRightSelectorOption = [XLFormLeftRightSelectorOption formLeftRightSelectorOptionWithLeftValue:[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Option 1"] httpParameterKey:@"option_1" rightOptions:mutableRightOptions];
    [leftRightSelectorOptions addObject:leftRightSelectorOption];
    
    mutableRightOptions = [rightOptions mutableCopy];
    [mutableRightOptions removeObjectAtIndex:1];
    leftRightSelectorOption = [XLFormLeftRightSelectorOption formLeftRightSelectorOptionWithLeftValue:[XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"] httpParameterKey:@"option_2" rightOptions:mutableRightOptions];
    [leftRightSelectorOptions addObject:leftRightSelectorOption];
    
    mutableRightOptions = [rightOptions mutableCopy];
    [mutableRightOptions removeObjectAtIndex:2];
    leftRightSelectorOption = [XLFormLeftRightSelectorOption formLeftRightSelectorOptionWithLeftValue:[XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Option 3"]  httpParameterKey:@"option_3" rightOptions:mutableRightOptions];
    [leftRightSelectorOptions addObject:leftRightSelectorOption];
    
    mutableRightOptions = [rightOptions mutableCopy];
    [mutableRightOptions removeObjectAtIndex:3];
    leftRightSelectorOption = [XLFormLeftRightSelectorOption formLeftRightSelectorOptionWithLeftValue:[XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Option 4"] httpParameterKey:@"option_4" rightOptions:mutableRightOptions];
    [leftRightSelectorOptions addObject:leftRightSelectorOption];
    
    mutableRightOptions = [rightOptions mutableCopy];
    [mutableRightOptions removeObjectAtIndex:4];
    leftRightSelectorOption = [XLFormLeftRightSelectorOption formLeftRightSelectorOptionWithLeftValue:[XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"Option 5"] httpParameterKey:@"option_5" rightOptions:mutableRightOptions];
    [leftRightSelectorOptions addObject:leftRightSelectorOption];
    
    row.selectorOptions  = leftRightSelectorOptions;
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Right Option 4"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectorPickerView rowType:XLFormRowDescriptorTypeSelectorPickerView title:@"Picker View"];
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Option 1"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Option 3"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Option 4"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"Option 5"]
                            ];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Option 4"];
    [section addFormRow:row];
    
    
    
    // --------- Fixed Controls
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Fixed Controls"];
    [form addFormSection:section];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPickerView rowType:XLFormRowDescriptorTypePicker];
    row.selectorOptions = @[@"Option 1", @"Option 2", @"Option 3", @"Option 4", @"Option 5", @"Option 6"];
    row.value = @"Option 1";
    [section addFormRow:row];
    
    
    
    // --------- Inline Selectors
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Inline Selectors"];
    [form addFormSection:section];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeSelectorPickerViewInline title:@"Inline Picker View"];
    row.selectorOptions = @[@"Option 1", @"Option 2", @"Option 3", @"Option 4", @"Option 5", @"Option 6"];
    row.value = @"Option 6";
    [section addFormRow:row];
    
    // --------- MultipleSelector
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Multiple Selectors"];
    [form addFormSection:section];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Multiple Selector"];
    row.selectorOptions = @[@"Option 1", @"Option 2", @"Option 3", @"Option 4", @"Option 5", @"Option 6"];
    row.value = @[@"Option 1", @"Option 3", @"Option 4", @"Option 5", @"Option 6"];
    [section addFormRow:row];
    
    
    // Multiple selector with value tranformer
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Multiple Selector"];
    row.selectorOptions = @[@"Option 1", @"Option 2", @"Option 3", @"Option 4", @"Option 5", @"Option 6"];
    row.value = @[@"Option 1", @"Option 3", @"Option 4", @"Option 5", @"Option 6"];
    row.valueTransformer = [NSArrayValueTrasformer class];
    [section addFormRow:row];
    
    
    // Language multiple selector
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Multiple Selector"];
    row.selectorOptions = [NSLocale ISOLanguageCodes];
    row.selectorTitle = @"Languages";
    row.valueTransformer = [ISOLanguageCodesValueTranformer class];
    row.value = [NSLocale preferredLanguages];
    [section addFormRow:row];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        // Language multiple selector popover
        row = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelectorPopover rowType:XLFormRowDescriptorTypeMultipleSelectorPopover title:@"Multiple Selector PopOver"];
        row.selectorOptions = [NSLocale ISOLanguageCodes];
        row.valueTransformer = [ISOLanguageCodesValueTranformer class];
        row.value = [NSLocale preferredLanguages];
        [section addFormRow:row];
    }
    
    
    // --------- Dynamic Selectors
    
//    section = [XLFormSectionDescriptor formSectionWithTitle:@"Dynamic Selectors"];
//    [form addFormSection:section];
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDynamicSelectors rowType:XLFormRowDescriptorTypeButton title:@"Dynamic Selectors"];
//    row.action.viewControllerClass = [DynamicSelectorsFormViewController class];
//    [section addFormRow:row];
//    
//    // --------- Custom Selectors
//    
//    section = [XLFormSectionDescriptor formSectionWithTitle:@"Custom Selectors"];
//    [form addFormSection:section];
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomSelectors rowType:XLFormRowDescriptorTypeButton title:@"Custom Selectors"];
//    row.action.viewControllerClass = [CustomSelectorsFormViewController class];
//    [section addFormRow:row];
//    
//    section = [XLFormSectionDescriptor formSectionWithTitle:@"Disabled & Required Selectors"];
//    [form addFormSection:section];
    
    
    
    // Disabled Selector Push
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectorPushDisabled rowType:XLFormRowDescriptorTypeSelectorPush title:@"Push"];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"];
    row.disabled = YES;
    [section addFormRow:row];
    
    
    
    // --------- Disabled Selector Action Sheet
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectorActionSheetDisabled rowType:XLFormRowDescriptorTypeSelectorActionSheet title:@"Sheet"];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Option 3"];
    row.disabled = YES;
    [section addFormRow:row];
    
    // --------- Disabled Selector Left Right
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectorLeftRightDisabled rowType:XLFormRowDescriptorTypeSelectorLeftRight title:@"Left Right"];
    row.leftRightSelectorLeftOptionSelected = [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Right Option 4"];
    row.disabled = YES;
    [section addFormRow:row];
    
    
    // --------- Selector definition types
    
//    section = [XLFormSectionDescriptor formSectionWithTitle:@"Selectors"];
//    [form addFormSection:section];
//    
//    // selector with segue class
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectorWithSegueClass rowType:XLFormRowDescriptorTypeSelectorPush title:@"Selector with Segue Class"];
//    row.action.formSegueClass = NSClassFromString(@"UIStoryboardPushSegue");
//    row.action.viewControllerClass = [MapViewController class];
//    row.valueTransformer = [CLLocationValueTrasformer class];
//    row.value = [[CLLocation alloc] initWithLatitude:-33 longitude:-56];
//    [section addFormRow:row];
//    
//    // selector with SegueId
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectorWithSegueClass rowType:XLFormRowDescriptorTypeSelectorPush title:@"Selector with Segue Idenfifier"];
//    row.action.formSegueIdenfifier = @"MapViewControllerSegue";
//    row.valueTransformer = [CLLocationValueTrasformer class];
//    row.value = [[CLLocation alloc] initWithLatitude:-33 longitude:-56];
//    [section addFormRow:row];
//    
//    // selector using StoryboardId
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectorWithStoryboardId rowType:XLFormRowDescriptorTypeSelectorPush title:@"Selector with StoryboardId"];
//    row.action.viewControllerStoryboardId = @"MapViewController";
//    row.valueTransformer = [CLLocationValueTrasformer class];
//    row.value = [[CLLocation alloc] initWithLatitude:-33 longitude:-56];
//    [section addFormRow:row];
//    
//    // selector with NibName
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectorWithNibName rowType:XLFormRowDescriptorTypeSelectorPush title:@"Selector with NibName"];
//    row.action.viewControllerNibName = @"MapViewController";
//    row.valueTransformer = [CLLocationValueTrasformer class];
//    row.value = [[CLLocation alloc] initWithLatitude:-33 longitude:-56];
//    [section addFormRow:row];
    
    
    
    self.form = form;
}


-(UIStoryboard *)storyboardForRow:(XLFormRowDescriptor *)formRow
{
    return [UIStoryboard storyboardWithName:@"iPhoneStoryboard" bundle:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    
//    XLFormDescriptor * form;
//    XLFormSectionDescriptor * section;
//    XLFormRowDescriptor * row;
//    
//    form = [XLFormDescriptor formDescriptorWithTitle:@"Add Event"];
//    
//    // First section
//    section = [XLFormSectionDescriptor formSection];
//    [form addFormSection:section];
//    
//    // Title
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"title" rowType:XLFormRowDescriptorTypeText];
//    [row.cellConfigAtConfigure setObject:@"Title" forKey:@"textField.placeholder"];
//    [section addFormRow:row];
//    
//    // Location
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"location" rowType:XLFormRowDescriptorTypeText];
//    [row.cellConfigAtConfigure setObject:@"Location" forKey:@"textField.placeholder"];
//    [section addFormRow:row];
//    
//    // Second Section
//    section = [XLFormSectionDescriptor formSection];
//    [form addFormSection:section];
//    
//    // All-day
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"all-day" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"All-day"];
//    [section addFormRow:row];
//    
//    // Starts
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"starts" rowType:XLFormRowDescriptorTypeDateTimeInline title:@"Starts"];
//    row.value = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
//    [section addFormRow:row];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
