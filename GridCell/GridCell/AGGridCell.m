//
//  AGGridCell.m
//  GridCell
//
//  Created by Yang Han on 15/3/28.
//  Copyright (c) 2015 Yang Han. All rights reserved.
//

#import "AGGridCell.h"
#import "Masonry.h"

@implementation AGGridCell {
  UITextView *_textView;
  UIView *_photoView;
  UIView *_maskView;
  
  UIButton *_addButton;
  
  CGFloat _itemOffset;
  NSUInteger _rowCount;
}

- (void)awakeFromNib {
  self.photos = [[NSMutableArray alloc] init];
  
  [self _initSubviews];
  
  __weak typeof(self) weakSelf = self;
  
  CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
  CGFloat itemWidth = (width - 40) / 4;
  _itemOffset = 0;
  _rowCount = 0;
  
  [_photoView mas_makeConstraints: ^(MASConstraintMaker *maker) {
    maker.top.equalTo(weakSelf.contentView).with.offset(8);
    maker.left.equalTo(weakSelf.contentView).with.offset(8);
    maker.right.equalTo(weakSelf.contentView).with.offset(-8);
    maker.bottom.equalTo(weakSelf.contentView).with.offset(-8);
    maker.height.mas_greaterThanOrEqualTo(itemWidth);
  }];
  
  [_addButton mas_makeConstraints: ^(MASConstraintMaker *maker) {
    maker.size.mas_equalTo(CGSizeMake(itemWidth, itemWidth));
    maker.top.equalTo(_photoView);
    maker.leading.equalTo(_photoView);
  }];
}

- (void)_initSubviews {
  _photoView = [[UIView alloc] init];
  _photoView.backgroundColor = [UIColor orangeColor];
  
  [self.contentView addSubview:_photoView];
  
  _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
  _addButton.backgroundColor = [UIColor purpleColor];
  
  [_photoView addSubview:_addButton];
}

- (void)appendPhoto:(UIImage *)photo {
  if (!photo) {
    return;
  }
  
  [self.photos addObject:photo];
  
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:_addButton.frame];
  imageView.image = photo;
  imageView.tag = self.photos.count - 1;
  imageView.clipsToBounds = YES;
  imageView.contentMode = UIViewContentModeScaleAspectFill;
  imageView.backgroundColor = [UIColor grayColor];
  [_photoView addSubview:imageView];
  
  [self _moveAddButton];
  
  if (self.photos.count % 4 == 0) {
    _itemOffset = 0;
    
    [self _appendRow];
    [self _changeRow];
    
    return;
  }
}

- (void)_moveAddButton {
  CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
  CGFloat itemWidth = (width - 40) / 4;
  
  _itemOffset = _itemOffset + itemWidth + 8;
  
  NSLog(@"%@", @(_itemOffset));
  
  
  [_addButton mas_updateConstraints: ^(MASConstraintMaker *maker) {
    maker.leading.equalTo(_photoView).with.offset(_itemOffset);
  }];
}

- (void)_changeRow {
  CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
  CGFloat itemWidth = (width - 40) / 4;
  
  [_addButton mas_updateConstraints: ^(MASConstraintMaker *maker) {
    maker.top.equalTo(_photoView).with.offset(itemWidth * _rowCount + 8 * _rowCount);
    maker.leading.equalTo(_photoView);
  }];
}

- (void)_appendRow {
  _rowCount = _rowCount + 1;
  
  CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
  CGFloat itemWidth = (width - 40) / 4;
  
  CGRect frame = _photoView.frame;
  CGSize newSize = CGSizeMake(frame.size.width, frame.size.height + itemWidth + 8);
  
  [_photoView mas_updateConstraints: ^(MASConstraintMaker *maker) {
    maker.height.mas_greaterThanOrEqualTo(newSize.height);
  }];
  
  UITableView *tabel = [self tableView];
  [tabel beginUpdates];
  [tabel endUpdates];
}

- (UITableView *)tableView {
  UIView *tableView = self.superview;
  
  while (![tableView isKindOfClass:[UITableView class]] && tableView) {
    tableView = tableView.superview;
  }
  
  return (UITableView *)tableView;
}

@end
