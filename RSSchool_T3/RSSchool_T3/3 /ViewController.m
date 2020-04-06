#import "ViewController.h"
#import <UIKit/UIKit.h>

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, weak) UILabel *hexLabel;
@property (nonatomic, weak) UIView *colorView;
@property (nonatomic, weak) UITextField *redTextField;
@property (nonatomic, weak) UITextField *blueTextField;
@property (nonatomic, weak) UITextField *greenTextField;

@end

@implementation ViewController

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupUI];
}


- (void)setupUI
{
    self.hexLabel = [UILabel new];
    self.hexLabel.text = @"Color";

    self.colorView = [UIView new];
    self.colorView.backgroundColor = [UIColor blueColor];

    UIStackView *stackView = [UIStackView new];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;

    [stackView addArrangedSubview:self.hexLabel];
    [stackView addArrangedSubview:self.colorView];
    stackView.spacing = 20;

    [self.view addSubview:stackView];

    [NSLayoutConstraint activateConstraints:@[
        [stackView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100],
        [stackView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20],
        [stackView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20],
        [stackView.heightAnchor constraintEqualToConstant:50],
        [self.hexLabel.widthAnchor constraintEqualToConstant:100]
    ]];

    UILabel *redLabel = [UILabel new];
    redLabel.text = @"RED";
    self.redTextField = [UITextField new];
    self.redTextField.delegate = self;
    self.redTextField.placeholder = @"0..255";
    self.redTextField.borderStyle = UITextBorderStyleRoundedRect;
    UIStackView *redStackView = [UIStackView new];
    redStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [redStackView addArrangedSubview:redLabel];
    [redStackView addArrangedSubview:self.redTextField];
    redStackView.spacing = 20;
    [self.view addSubview:redStackView];
    [NSLayoutConstraint activateConstraints:@[
        [redStackView.topAnchor constraintEqualToAnchor:stackView.bottomAnchor constant:40],
        [redStackView.leftAnchor constraintEqualToAnchor:stackView.leftAnchor],
        [redStackView.rightAnchor constraintEqualToAnchor:stackView.rightAnchor],
        [redStackView.heightAnchor constraintEqualToConstant:50],
        [redLabel.widthAnchor constraintEqualToConstant:60]
    ]];

    UILabel *greenLabel = [UILabel new];
    greenLabel.text = @"GREEN";
    self.greenTextField = [UITextField new];
    self.greenTextField.delegate = self;
    self.greenTextField.placeholder = @"0..255";
    self.greenTextField.borderStyle = UITextBorderStyleRoundedRect;
    UIStackView *greenStackView = [UIStackView new];
    greenStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [greenStackView addArrangedSubview:greenLabel];
    [greenStackView addArrangedSubview:self.greenTextField];
    greenStackView.spacing = 20;
    [self.view addSubview:greenStackView];
    [NSLayoutConstraint activateConstraints:@[
        [greenStackView.topAnchor constraintEqualToAnchor:redStackView.bottomAnchor constant:40],
        [greenStackView.leftAnchor constraintEqualToAnchor:stackView.leftAnchor],
        [greenStackView.rightAnchor constraintEqualToAnchor:stackView.rightAnchor],
        [greenStackView.heightAnchor constraintEqualToConstant:50],
        [greenLabel.widthAnchor constraintEqualToConstant:60]
    ]];

    UILabel *blueLabel = [UILabel new];
    blueLabel.text = @"BLUE";
    self.blueTextField = [UITextField new];
    self.blueTextField.delegate = self;
    self.blueTextField.placeholder = @"0..255";
    self.blueTextField.borderStyle = UITextBorderStyleRoundedRect;
    UIStackView *blueStackView = [UIStackView new];
    blueStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [blueStackView addArrangedSubview:blueLabel];
    [blueStackView addArrangedSubview:self.blueTextField];
    blueStackView.spacing = 20;
    [self.view addSubview:blueStackView];
    [NSLayoutConstraint activateConstraints:@[
        [blueStackView.topAnchor constraintEqualToAnchor:greenStackView.bottomAnchor constant:40],
        [blueStackView.leftAnchor constraintEqualToAnchor:stackView.leftAnchor],
        [blueStackView.rightAnchor constraintEqualToAnchor:stackView.rightAnchor],
        [blueStackView.heightAnchor constraintEqualToConstant:50],
        [blueLabel.widthAnchor constraintEqualToConstant:60]
    ]];

    UIButton *processButton = [UIButton new];
    [processButton sizeToFit];
    processButton.translatesAutoresizingMaskIntoConstraints = NO;
    [processButton setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    [processButton setTitle:@"Process" forState:UIControlStateNormal];
    [self.view addSubview:processButton];
    [processButton sizeToFit];
    [NSLayoutConstraint activateConstraints:@[
        [processButton.topAnchor constraintEqualToAnchor:blueStackView.bottomAnchor constant:40],
        [processButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0]
    ]];

    [processButton addTarget:self
                      action:@selector(processColorWithSender:)
            forControlEvents:UIControlEventTouchUpInside];



    self.view.accessibilityIdentifier = @"mainView";
    self.redTextField.accessibilityIdentifier = @"textFieldRed";
    self.greenTextField.accessibilityIdentifier = @"textFieldGreen";
    self.blueTextField.accessibilityIdentifier = @"textFieldBlue";
    processButton.accessibilityIdentifier = @"buttonProcess";
    redLabel.accessibilityIdentifier = @"labelRed";
    greenLabel.accessibilityIdentifier = @"labelGreen";
    blueLabel.accessibilityIdentifier = @"labelBlue";
    self.hexLabel.accessibilityIdentifier = @"labelResultColor";
    self.colorView.accessibilityIdentifier = @"viewResultColor";
}

- (void)processColorWithSender:(id)sender
{
    [self.view endEditing:YES];
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    NSNumber *redNumber = [numberFormatter numberFromString:self.redTextField.text];
    NSNumber *blueNumber = [numberFormatter numberFromString:self.blueTextField.text];
    NSNumber *greenNumber = [numberFormatter numberFromString:self.greenTextField.text];

    self.redTextField.text = @"";
    self.blueTextField.text = @"";
    self.greenTextField.text = @"";

    if (redNumber == nil || blueNumber == nil || greenNumber == nil) {
        self.hexLabel.text = @"Error";
        return;
    }

    unsigned long red = redNumber.unsignedIntegerValue;
    unsigned long blue = blueNumber.unsignedIntegerValue;
    unsigned long green = greenNumber.unsignedIntegerValue;

    if ((red >= 0 && red <= 255) && (blue >= 0 && blue <= 255) && (green >= 0 && green <= 255)) {
        self.colorView.backgroundColor =
            [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:1];
        NSString *hexString = [NSString stringWithFormat:@"0x%02lX%02lX%02lX", red, green, blue];
        self.hexLabel.text = hexString;
    } else {
        self.hexLabel.text = @"Error";
        return;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.hexLabel.text = @"Color";
}

@end
