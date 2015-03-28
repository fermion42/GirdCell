//
//  ViewController.m
//  GridCell
//
//  Created by Yang Han on 15/3/28.
//  Copyright (c) 2015年 Yang Han. All rights reserved.
//

#import "ViewController.h"
#import "AGGridCell.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController {
  AGGridCell *_gridCell;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UINib *nib = [UINib nibWithNibName:@"AGGridCell" bundle:nil];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"AGGridCell"];
  //  self.tableView.scrollEnabled = NO;
  self.tableView.estimatedRowHeight = 100;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  AGGridCell *cell;
  
  if (indexPath.row == 0) {
    cell = [tableView dequeueReusableCellWithIdentifier:@"AGGridCell"];
    [cell.addButton addTarget:self action:@selector(appendPhoto) forControlEvents:UIControlEventTouchUpInside];
    _gridCell = cell;
  }
  
  return cell;
}

- (void)appendPhoto {
  if (_gridCell.photos.count == 9) {
    return;
  }
  
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
  imagePicker.delegate = self;
  
  [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
  NSLog(@"%@", image);
  [_gridCell appendPhoto:image];
  
  [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
