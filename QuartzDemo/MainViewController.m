//
//  ViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 21/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "MainViewController.h"
#import "ConicalViewController.h"
#import "LinesViewController.h"
#import "ArcsViewController.h"
#import "EllipsesViewController.h"
#import "RectanglesViewController.h"
#import "PathViewController.h"

#import "Scene.h"

static NSString * const sCellId = @"cell";

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *chapters;
@property (nonatomic) NSDictionary *scenes;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    [self configureConstraintsForTableView];
}

- (void)configureConstraintsForTableView
{
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.chapters.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *chapterName = self.chapters[section];
    
    NSArray *scene = self.scenes[chapterName];
    return scene.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sCellId forIndexPath:indexPath];
    
    NSString *chapterName = self.chapters[indexPath.section];
    
    NSArray *scene = self.scenes[chapterName];
    
    Scene *s = scene[indexPath.row];
    
    cell.textLabel.text = s.title;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.chapters[section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *chapterName = self.chapters[indexPath.section];
    
    NSArray *scene = self.scenes[chapterName];
    
    Scene *s = scene[indexPath.row];
    
    UIViewController *vc = [s.clz new];
    vc.title = s.title;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:sCellId];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

static NSString *const sChapterPaths = @"Paths";
static NSString *const sChapterColorAndColorSpaces = @"Color and Color Spaces";
static NSString *const sChapterTransforms = @"Transforms";
static NSString *const sChapterPatterns = @"Patterns";
static NSString *const sChapterShadows = @"Shadows";
static NSString *const sChapterGradients = @"Gradients";
static NSString *const sChapterTransparencyLayers = @"Transparency Layers";
static NSString *const sChapterBitmapImagesAndImageMasks = @"Bitmap Images and Image Masks";
static NSString *const sChapterCoreGraphicsLayerDrawing = @"Core Graphics Layer Drawing";

- (NSArray *)chapters
{
    if (!_chapters) {
        _chapters = @[
                      sChapterPaths,
                      sChapterColorAndColorSpaces,
                      sChapterTransforms,
                      sChapterPatterns,
                      sChapterShadows,
                      sChapterGradients,
                      sChapterTransparencyLayers,
                      sChapterBitmapImagesAndImageMasks,
                      sChapterCoreGraphicsLayerDrawing
                      ];
    }
    return _chapters;
}

- (NSDictionary *)scenes
{
    if (!_scenes) {
        _scenes = @{
                    sChapterPaths: @[
                            [[Scene alloc] initWithTitle:@"Lines" class:[LinesViewController class]],
                            [[Scene alloc] initWithTitle:@"Arcs" class:[ArcsViewController class]],
                            [[Scene alloc] initWithTitle:@"Curves" class:[UIViewController class]],
                            [[Scene alloc] initWithTitle:@"Ellipses" class:[EllipsesViewController class]],
                            [[Scene alloc] initWithTitle:@"Rectangles" class:[RectanglesViewController class]],
                            [[Scene alloc] initWithTitle:@"Path" class:[PathViewController class]]
                            ],
                    sChapterColorAndColorSpaces: @[
                            [[Scene alloc] initWithTitle:@"Device Color Spaces" class:[UIViewController class]]
                            ],
                    sChapterTransforms: @[
                            [[Scene alloc] initWithTitle:@"Transforms" class:[UIViewController class]]
                            ],
                    sChapterPatterns: @[
                            [[Scene alloc] initWithTitle:@"Colored Patterns" class:[UIViewController class]],
                            [[Scene alloc] initWithTitle:@"Stencil Patterns" class:[UIViewController class]]
                            ],
                    sChapterShadows: @[
                            [[Scene alloc] initWithTitle:@"Shadows" class:[UIViewController class]]
                            ],
                    
                    sChapterGradients: @[
                            [[Scene alloc] initWithTitle:@"Axial" class:[UIViewController class]],
                            [[Scene alloc] initWithTitle:@"Radial" class:[UIViewController class]],
                            [[Scene alloc] initWithTitle:@"Conical" class:[ConicalViewController class]],
                            ],
                    
                    sChapterTransparencyLayers: @[
                            [[Scene alloc] initWithTitle:@"Transparency Layers" class:[UIViewController class]]
                            ],
                    sChapterBitmapImagesAndImageMasks: @[
                            [[Scene alloc] initWithTitle:@"Image Mask" class:[UIViewController class]],
                            [[Scene alloc] initWithTitle:@"Image" class:[UIViewController class]],
                            [[Scene alloc] initWithTitle:@"Color" class:[UIViewController class]],
                            [[Scene alloc] initWithTitle:@"Clipping Context" class:[UIViewController class]]
                            ],
                    sChapterCoreGraphicsLayerDrawing: @[
                            [[Scene alloc] initWithTitle:@"Core Graphics Layer Drawing" class:[UIViewController class]]
                            ]
                    };
    }
    return _scenes;
}

@end
