//
//  EDTAMapViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import EDTTransition;
#import "EDTConfig.h"
NS_ASSUME_NONNULL_BEGIN
@import EDTAMap;
@class EDTAMapView;
@class EDTLocation;
@import CoreLocation;

NS_SWIFT_NAME(EDTAMapViewController)
@interface EDTAMapTViewController : EDTTViewController <EDTAMapViewDelegate>

+ (instancetype)createAMapWithLat:(CLLocationDegrees )lat andLon:(CLLocationDegrees)lon;

@property (nonatomic ,strong ,readonly) EDTAMapView *EDTMapView;

@property (nonatomic ,strong ,readonly) EDTLocation *EDTLocation;

@property (nonatomic ,assign) CLLocationDegrees lat;

@property (nonatomic ,assign) CLLocationDegrees lon;

- (void)mapView:(EDTAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation;

- (void)mapView:(EDTAMapView *)mapView regionWillChangeAnimated:(BOOL)animated;

- (void)mapView:(EDTAMapView *)mapView didAddAnnotationViews:(NSArray *)views;

- (void)EDTFetchLocaiton:(CLLocation *)Location;

@end

NS_ASSUME_NONNULL_END
