//
//  FBAMapViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//
#import <MAMapKit/MAMapKit.h>
@import AMapFoundationKit;
NS_ASSUME_NONNULL_BEGIN


#pragma mark ---- FBAMap
NS_SWIFT_NAME(FBAMap)
@interface FBAMap : NSObject

+ (void)registerApiKey:(NSString *)apiKey;

@end

#pragma mark ---- FBSearch
@import AMapSearchKit;

typedef void(^FBRegeoSearchBlock)(NSString *city,NSString *street);

typedef void(^FBTipSearchBlock)(NSArray<AMapTip *> *tips);
NS_SWIFT_NAME(FBSearch)
@interface FBSearch : NSObject

- (void)FBGeoSearchResp:(AMapGeoPoint *)location andResp:(FBRegeoSearchBlock) resp;

/* 根据关键字来搜索POI. */
- (void)onTipSearchRespWithKeywords:(NSString *) keywords andCity:(NSString *)city andResp:(FBTipSearchBlock) resp;

/* 根据ID来搜索POI. */
- (void)FBTipSearchRespWithID:(NSString *)uid;

@property (nonatomic ,strong ,readonly) AMapSearchAPI *searchApi;

@end

#pragma mark ---- FBLocation
@import AMapLocationKit;
@import CoreLocation;
typedef void(^FBLocationBlock)(CLLocation *_Nullable location);
NS_SWIFT_NAME(FBLocation)
@interface FBLocation : NSObject

@property (nonatomic ,strong ,readonly) AMapLocationManager *FBAmlocation;

@property (nonatomic ,strong ,readonly) CLLocationManager *cllocation;

- (void)requestLocationWithReGeocodeWithCompletionBlock:(AMapLocatingCompletionBlock)completionBlock;

@property (nonatomic ,assign) CLAuthorizationStatus authStatus;

// 开始定位
- (void)FBStartLocation:(FBLocationBlock )location;

// 停止定位
- (void)FBStopLocation;

@end
#pragma mark ---- FBAMapView


NS_SWIFT_NAME(FBAMapView)
@interface FBAMapView : MAMapView

@property (nonatomic ,assign) CGFloat FBLeftResp;

@end

#pragma mark ---- FBAMapViewController
@import FBTransition;


typedef NS_ENUM(NSInteger ,FBAMapLoadType) {
    
    FBAMapLoadTypeLocationLoading,
    
    FBAMapLoadTypeLocationNoneLoading
};

NS_SWIFT_NAME(FBAMapViewController)
@interface FBAMapViewController : FBTViewController <MAMapViewDelegate>

+ (instancetype)createAMapWithLat:(CLLocationDegrees )lat andLon:(CLLocationDegrees)lon andMapLoadType:(FBAMapLoadType )loadType;

@property (nonatomic ,strong ,readonly) FBAMapView *FBMapView;

@property (nonatomic ,strong ,readonly) FBLocation *FBLocation;

@property (nonatomic ,assign) CLLocationDegrees lat;

@property (nonatomic ,assign) CLLocationDegrees lon;

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation;

- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated;

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views;

- (void)FBFetchLocaiton:(CLLocation *)location;

@end

NS_ASSUME_NONNULL_END
