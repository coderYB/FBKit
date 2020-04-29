//
//  EDTAMapViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "EDTAMapTViewController.h"
#import <MAMapKit/MAMapKit.h>
@import EDTAMap;
@import CoreLocation;
@interface EDTAMapTViewController ()

@property (nonatomic ,strong ,readwrite) EDTAMapView *EDTMapView;

@property (nonatomic ,strong ,readwrite) EDTLocation *EDTLocation;

@end

@implementation EDTAMapTViewController

- (EDTAMapView *)EDTMapView {
    
    if (!_EDTMapView) {
        
        _EDTMapView = [[EDTAMapView alloc] initWithFrame:self.view.bounds];
        
        _EDTMapView.mapType = MAMapTypeStandard;
        
        _EDTMapView.showsUserLocation = true;
        
        _EDTMapView.showsScale = false;
        
        _EDTMapView.showsCompass = false;
        
        _EDTMapView.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        
        _EDTMapView.delegate = self;
        
        _EDTMapView.EDTLeftResp = 100;
    }
    return _EDTMapView;
}
- (EDTLocation *)EDTLocation {
    
    if (!_EDTLocation) {
        
        _EDTLocation = [EDTLocation new];
        
    }
    return _EDTLocation;
}

+ (instancetype)createAMapWithLat:(CLLocationDegrees )lat andLon:(CLLocationDegrees)lon {
    
    return [[self alloc] initWithLat:lat andLon:lon];
}
- (instancetype)initWithLat:(CLLocationDegrees )lat andLon:(CLLocationDegrees)lon {
    
    if (self = [super init]) {
        
        self.lat = lat;
        
        self.lon = lon;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.EDTMapView setZoomLevel:16.5f animated:false];
    
    __weak typeof(self) weakSelf = self;
    
#if TARGET_IPHONE_SIMULATOR //模拟器
    
    if (!self.lat && !self.lon) {
        
        self.lat = 40.976204;
        
        self.lon = 117.939152;
    }
    
    CLLocation *l = [[CLLocation alloc] initWithLatitude:self.lat longitude:self.lon];
    
    [weakSelf.EDTMapView setCenterCoordinate:l.coordinate animated:true];
    
    [weakSelf EDTFetchLocaiton:l];
    
#elif TARGET_OS_IPHONE //真机
    [self.EDTLocation EDTStartLocation:^(CLLocation * _Nonnull Location) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //            40.976204 117.939152
            
            [weakSelf.EDTMapView setCenterCoordinate:Location.coordinate animated:true];
            
            [weakSelf EDTFetchLocaiton:Location];
            
        });
        
    }];
#endif
}
- (void)EDTFetchLocaiton:(CLLocation *)Location {
    
    // MARK: Do something in child
}
-(void)addOwnSubViews {
    [super addOwnSubViews];
    
    [self.view addSubview:self.EDTMapView];
}

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    self.EDTMapView.frame = self.view.bounds;
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)mapView:(EDTAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    
}
- (void)mapView:(EDTAMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
    
}

- (void)mapView:(EDTAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    
}

@end

