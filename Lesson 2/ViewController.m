//
//  ViewController.m
//  Lesson 2
//
//  Created by PitGun on 04.05.15.
//  Copyright (c) 2015 Petr Zhitnikov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) UIView * someView;

@property (nonatomic, assign) CGPoint differencePoint;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
// рисуем доску
    
    int x;
    int y;
    for (int i = 1; i <= 8; i++) {
        x = i * 80;
        for (int j = 1; j <= 8; j++) {
            y = j * 80;
            if (j % 2) {
                if (i % 2) {
                    UIView *viewwhite = [[UIView alloc] initWithFrame:CGRectMake(x, y, 80, 80)];
                    viewwhite.backgroundColor = [UIColor whiteColor];
                    [self.view addSubview:viewwhite];
                    viewwhite.userInteractionEnabled = NO; //клетки обездвиживаем
                }
                else {
                    UIView *viewblack = [[UIView alloc] initWithFrame:CGRectMake(x, y, 80, 80)];
                    viewblack.backgroundColor = [UIColor grayColor];
                    [self.view addSubview:viewblack];
                    viewblack.userInteractionEnabled = NO;//клетки обездвиживаем
                }
            }
            else {
                if (i % 2) {
                    UIView *viewblack = [[UIView alloc] initWithFrame:CGRectMake(x, y, 80, 80)];
                    viewblack.backgroundColor = [UIColor grayColor];
                    [self.view addSubview:viewblack];
                viewblack.userInteractionEnabled = NO;}//клетки обездвиживаем
                else {
                    UIView *viewwhite = [[UIView alloc] initWithFrame:CGRectMake(x, y, 80, 80)];
                    viewwhite.backgroundColor = [UIColor whiteColor];
                    [self.view addSubview:viewwhite];
                    viewwhite.userInteractionEnabled = NO;}//клетки обездвиживаем
            }
        }
        
    }
    [self addFigures_To_Board];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// обозначиваем фигуру которую будем двигать

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch * touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self.view];
    
    UIView * someAnotherView = [self.view hitTest:point withEvent:event];
    
    if (![someAnotherView isEqual:self.view]) {
        
        self.someView = someAnotherView;
        
        [self.view bringSubviewToFront:self.someView];
        
        UITouch * touch = [touches anyObject];
        
        CGPoint point = [touch locationInView:self.someView];
        
//плавность движения фигуры

        self.differencePoint = CGPointMake(CGRectGetMidX(self.someView.bounds) - point.x, CGRectGetMidY(self.someView.bounds) - point.y);
        
//увеличиваем фигуру
        
        [UIView animateWithDuration:0.3 animations:^{
            self.someView.transform = CGAffineTransformMakeScale(1.3f, 1.3f);
            self.someView.alpha = 0.5;
        }];
    }
    
    else {
        self.someView = nil;
    }
}

// двигаем фигуру

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (self.someView) {
        
        UITouch * touch = [touches anyObject];
        
        CGPoint point = [touch locationInView:self.view];
        
        CGPoint mainPoint = CGPointMake(point.x + self.differencePoint.x, point.y + self.differencePoint.y);
        
        self.someView.center = mainPoint;
    }
}

//заканчиваем движение фигура принимает изначальный размер

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.someView.transform = CGAffineTransformIdentity;
        self.someView.alpha = 1.0;
    }];
}



#pragma mark - figures

//добавляем фигуры в массивы

-(void) addFigures_To_Board {
    
    NSMutableArray * images_b = [[NSMutableArray alloc] init];
    NSMutableArray * images_w = [[NSMutableArray alloc] init];
    UIImage * rook_b = [UIImage imageNamed: [NSString stringWithFormat:@"rook_b.png"]];
    UIImage * elep_b = [UIImage imageNamed: [NSString stringWithFormat:@"elep_b.png"]];
    UIImage * knight_b = [UIImage imageNamed: [NSString stringWithFormat:@"knight_b.png"]];
    UIImage * king_b = [UIImage imageNamed: [NSString stringWithFormat:@"king_b.png"]];
    UIImage * queen_b = [UIImage imageNamed: [NSString stringWithFormat:@"queen_b.png"]];
    
    UIImage * rook_w = [UIImage imageNamed: [NSString stringWithFormat:@"rook_w.png"]];
    UIImage * elep_w = [UIImage imageNamed: [NSString stringWithFormat:@"elep_w.png"]];
    UIImage * knight_w = [UIImage imageNamed: [NSString stringWithFormat:@"knight_w.png"]];
    UIImage * king_w = [UIImage imageNamed: [NSString stringWithFormat:@"king_w.png"]];
    UIImage * queen_w = [UIImage imageNamed: [NSString stringWithFormat:@"queen_w.png"]];
    
    
    [images_b addObject:rook_b];
    [images_b addObject:elep_b];
    [images_b addObject:knight_b];
    [images_b addObject:king_b];
    [images_b addObject:queen_b];
    [images_b addObject:knight_b];
    [images_b addObject:elep_b];
    [images_b addObject:rook_b];
    
    [images_w addObject:rook_w];
    [images_w addObject:elep_w];
    [images_w addObject:knight_w];
    [images_w addObject:king_w];
    [images_w addObject:queen_w];
    [images_w addObject:knight_w];
    [images_w addObject:elep_w];
    [images_w addObject:rook_w];
    
//добавляем черные фигуры на доску

    for (int i = 0; i < images_b.count; ++i){
        UIView *figureView = [[UIView alloc] initWithFrame:CGRectMake(i * 80+80, 80, 80, 80)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:figureView.bounds];
        imageView.image = [images_b objectAtIndex:i];
        [figureView addSubview:imageView];
        [self.view addSubview:figureView];
    }
    
//добавляем белые фигуры на доску
    
    for (int i = 0; i < images_w.count; ++i){
        UIView *figureView = [[UIView alloc] initWithFrame:CGRectMake(i * 80+80, 640, 80, 80)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:figureView.bounds];
        imageView.image = [images_w objectAtIndex:i];
        [figureView addSubview:imageView];
        [self.view addSubview:figureView];
    }
 
//добавляем черные пешки на доску
    
    for (int i = 1; i < 9; i++) {
        UIView *figureView = [[UIView alloc] initWithFrame:CGRectMake(i * 80, 160, 80, 80)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:figureView.bounds];
        imageView.image = [UIImage imageNamed: [NSString stringWithFormat:@"pawn_b.png"]];
        [figureView addSubview:imageView];
        [self.view addSubview:figureView];
    }
    
//добавляем белые пешки на доску
    
    for (int i = 1; i < 9; i++) {
        UIView *figureView = [[UIView alloc] initWithFrame:CGRectMake(i * 80, 560, 80, 80)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:figureView.bounds];
        imageView.image = [UIImage imageNamed: [NSString stringWithFormat:@"pawn_w.png"]];
        [figureView addSubview:imageView];
        [self.view addSubview:figureView];
    }
}

@end
