//
//  SwitchPage.m
//  SwitchPage
//
//  Created by d2space on 16/1/12.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#define PROGRESS_COLOR LD_COLOR_ONE
#define PROGRESS_HEIGHT 2
#define TITLE_BTN_HEIGHT 40

#import "SwitchPage.h"
#import "MJRefresh.h"
@interface SwitchPage()
/**
 *  存放tableview
 */
@property (nonatomic, strong) UIScrollView *contentScrol;
/**
 *  存放滚动进度条
 */
@property (nonatomic, strong) UIScrollView *lineScrol;
/**
 *  存放顶部按钮
 */
@property (nonatomic, strong) UIScrollView *titleScrol;

@property (nonatomic, strong) UILabel      *colorLabel;
/**
 *  当前页（tableview）
 */
@property (nonatomic        ) NSInteger    index;
/**
 *  设置几列,default = 3
 */
@property (nonatomic, assign) NSInteger    columnNum;

@end

@implementation SwitchPage
#pragma mark ****************** Init Mehtod
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.columnNum = 3;
        return self;
    }
    return nil;
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    if (_titles.count <= 4)
    {
        self.columnNum = _titles.count;
    }
    else
    {
        self.columnNum = 4;
    }
    [self initHeaderButton];
}
- (void)setContents:(NSArray *)contents
{
    _contents= contents;
    [self initTableViews];
}
- (void)initScrollView
{
    /**
     tableView Scroll
     */
    _contentScrol = [[UIScrollView alloc]initWithFrame:self.bounds];
    _contentScrol.pagingEnabled = YES;
    _contentScrol.delegate = self;
    _contentScrol.bounces = NO;
    _contentScrol.showsHorizontalScrollIndicator = NO;
    _contentScrol.contentSize = CGSizeMake(self.frame.size.width*_titles.count, self.frame.size.height);
    [self addSubview:_contentScrol];
    
    /**
     lineScroll
     */
    _lineScrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, TITLE_BTN_HEIGHT, self.frame.size.width, PROGRESS_HEIGHT)];
    if (_titles.count <= 4)
    {
         _lineScrol .contentSize = CGSizeMake(self.frame.size.width, PROGRESS_HEIGHT);
    }
    else
    {
        _lineScrol.contentSize = CGSizeMake(self.frame.size.width/4*_titles.count, PROGRESS_HEIGHT);
    }
    _lineScrol.showsHorizontalScrollIndicator = NO;
    [self addSubview:_lineScrol];
    [_lineScrol scrollRectToVisible:CGRectMake(0, 0, self.frame.size.width, PROGRESS_HEIGHT) animated:NO];

    _colorLabel = [[UILabel alloc]init];
    if (_titles.count >= 4)
    {
        _colorLabel.frame = CGRectMake(0, 0, self.frame.size.width/self.columnNum, PROGRESS_HEIGHT);
    }
    else
    {
        _colorLabel.frame = CGRectMake(0, 0, self.frame.size.width/_titles.count, PROGRESS_HEIGHT);
    }
    _colorLabel.backgroundColor = PROGRESS_COLOR;
    [_lineScrol addSubview:_colorLabel];
    
    /**
     titleScroll
     */
    _titleScrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, TITLE_BTN_HEIGHT)];
    if (_titles.count <= 4)
    {
        _titleScrol .contentSize = CGSizeMake(self.frame.size.width, TITLE_BTN_HEIGHT);
    }
    else
    {
        _titleScrol.contentSize = CGSizeMake(self.frame.size.width/4*_titles.count, TITLE_BTN_HEIGHT);
    }
    _titleScrol.delegate = self;
    _titleScrol.showsHorizontalScrollIndicator = NO;
    [self addSubview:_titleScrol];

}

- (void)initHeaderButton
{
    if (_contentScrol == nil)
    {
        [self initScrollView];
    }
    for (int i = 0; i < _titles.count; i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
//        btn.titleLabel.textColor = 
        btn.tag = 3001+i;
        btn.titleLabel.font =LK_FONT_SIZE_FOUR;
        [btn setTitleColor:LD_COLOR_ELEVEN forState:UIControlStateNormal];
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(i*self.frame.size.width/self.columnNum, 0, self.frame.size.width/self.columnNum, TITLE_BTN_HEIGHT);
        [btn addTarget:self action:@selector(titleBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
        [_titleScrol addSubview:btn];
        if (i == 0)
        {
            [btn setTitleColor:LD_COLOR_ONE forState:UIControlStateNormal];
        }
    }
}

- (void)initTableViews
{
    if (_contentScrol == nil)
    {
        [self initScrollView];
    }
    __block NSMutableArray *pageCounts = [NSMutableArray array];
    for (int i = 0; i < _contents.count; i ++)
    {
        __block UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(i*self.frame.size.width, (TITLE_BTN_HEIGHT+PROGRESS_HEIGHT), self.frame.size.width, self.frame.size.height - (TITLE_BTN_HEIGHT+PROGRESS_HEIGHT)) style:UITableViewStylePlain];
        tableView.tag = 3101+i;
        tableView.dataSource = self;
        tableView.delegate = self;
        int p = 1;
        [pageCounts addObject:[NSNumber numberWithInt:p]];
        tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            pageCounts[tableView.tag - 3101] = [NSNumber numberWithInt:1];
            self.tableViewHeaderMethod(_index);
            [tableView.header endRefreshing];
        }];
        tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            pageCounts[tableView.tag - 3101] = [NSNumber numberWithInt:[pageCounts[tableView.tag - 3101] intValue]+1];

            self.tableViewFooterMethod(_index,[pageCounts[tableView.tag - 3101] intValue]);
            [tableView.footer endRefreshing];
        }];
        [_contentScrol addSubview:tableView];
    }
}


#pragma mark ****************** ScrollView Mehtod
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _contentScrol)
    {
        CGFloat ratio =  scrollView.contentOffset.x/self.frame.size.width;
        _index = floor((scrollView.contentOffset.x - scrollView.frame.size.width/(self.columnNum+2))/scrollView.frame.size.width)+1;
        if (_titles.count >= 4)
        {
            _colorLabel.frame = CGRectMake(_lineScrol.contentSize.width/_titles.count*ratio, 0, self.frame.size.width/4, PROGRESS_HEIGHT);
        }
        else
        {
           _colorLabel.frame = CGRectMake(_lineScrol.contentSize.width/_titles.count*ratio, 0, self.frame.size.width/_titles.count, PROGRESS_HEIGHT);
        }
        
    }
    else if (scrollView == _titleScrol)
    {
        _lineScrol.contentOffset = _titleScrol.contentOffset;
    }
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _contentScrol)
    {
        UIButton *btn = [[UIButton alloc]init];
        btn = [_titleScrol viewWithTag:(3001+_index)];
        [self titleBtnMethod:btn];
    }
}

#pragma mark ****************** TableView Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = _contents[tableView.tag - 3101];
    FMLog(@"%ld",tableView.tag - 3101);
    FMLog(@"arr.count == %lu",(unsigned long)arr.count);
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
//    TestModel *tm = [self currentModel:tableView WithIndexPath:indexPath];
    VipAddModel * tm = [self currentModel:tableView WithIndexPath:indexPath];
    cell.textLabel.text = tm.associator_phone;
    cell.textLabel.font = LK_FONT_SIZE_FOUR;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VipAddModel *tm = [self currentModel:tableView WithIndexPath:indexPath];
    self.selectedModel(tm);
}

#pragma mark ****************** Private Method
- (void)titleBtnMethod:(UIButton *)btn
{
    FMLog(@"%@",App_User_Info.myInfo.userModel.defaultBusiness);
    for (int i = 3001; i <(3001+_titles.count); i++)
    {
        UIButton *titleBtn = [_titleScrol viewWithTag:i];

        [titleBtn setTitleColor:LD_COLOR_ELEVEN forState:UIControlStateNormal];
    }
    [btn setTitleColor:LD_COLOR_ONE forState:UIControlStateNormal
     ];
    [_contentScrol scrollRectToVisible:CGRectMake(self.frame.size.width*(btn.tag - 3001), 0, self.frame.size.width, self.frame.size.height) animated:YES];
    if (self.titles.count > 4)
    {
        _colorLabel.frame = CGRectMake(self.frame.size.width/self.columnNum*(btn.tag - 3001), 0, self.frame.size.width/self.columnNum, PROGRESS_HEIGHT);
        if ((btn.tag - 3001) > 3)
        {
//            [_titleScrol scrollRectToVisible:CGRectMake(self.frame.size.width/4 *(btn.tag - 3001+1), 0, self.frame.size.width/4, TITLE_BTN_HEIGHT) animated:YES];
            [_titleScrol setContentOffset:CGPointMake((self.frame.size.width/4)*(self.titles.count - 4), 0) animated:YES];
            [_lineScrol scrollRectToVisible:CGRectMake(self.frame.size.width/4*(btn.tag - 3001+1),0,self.frame.size.width/4,PROGRESS_HEIGHT) animated:YES];
        }
        else
        {
            [_titleScrol scrollRectToVisible:CGRectMake(0, 0, self.frame.size.width/4, TITLE_BTN_HEIGHT) animated:YES];
            [_lineScrol scrollRectToVisible:CGRectMake(0,0,self.frame.size.width/4,PROGRESS_HEIGHT) animated:YES];
        }
    }
    if (self.indexSelected) {
        _indexSelected(btn.tag-3001);
    }
}
- (id)currentModel:(UITableView *)tableView WithIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = _contents[tableView.tag- 3101];
    return arr[indexPath.row];
}



@end
