//
//  MySourcePublicTimeChooseView.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/19/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MySourcePublicTimeChooseView.h"
#import "NSDate+Helper.h"

@interface MySourcePublicTimeChooseView ()

@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;

@end

@implementation MySourcePublicTimeChooseView

- (IBAction)startTime:(id)sender {
    NSLog(@"TODO:// choose start time");
    if (self.startTimeCallback) {
        NSDate *date = self.startDate == nil ? [NSDate date] : self.startDate;
        self.startTimeCallback(date);
    }
}

- (IBAction)endTime:(id)sender {
    if (self.endTimeCallback) {
        NSDate *date = self.endDate == nil ? [NSDate date] : self.endDate;
        self.endTimeCallback(date);
    }
}

- (void)setStartDate:(NSDate *)startDate {
    _startDate = startDate;
    self.startTimeLabel.text = [self strWithDate:startDate];
}

- (void)setEndDate:(NSDate *)endDate {
    _endDate = endDate;
    self.endTimeLabel.text = [self strWithDate:endDate];
}

- (NSString *)strWithDate:(NSDate *)date {
    NSString *str = nil;
    if (date) {
        str = [date toString];
    } else {
        str = nil; // [[NSDate date] toString];
    }
    return str;
}

@end
