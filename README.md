# HLSlideViewController
iOS SlideViewController with the function of subViewController's communication.

## Function
1. A SlideViewController just like normal usage.
2. Message Management for the two-subViewControllers with each other.


## Usage
1. Usage `[[HLSlideViewController alloc] initWithLeftViewController: andRightViewController:];` to get slideViewControler instance.
2. In your leftViewController or rightViewController, just call `[self.rootViewController performSelector:]` or any other dynamic message forward functions, to call the specified selector defined in your leftViewController as well as rightViewController.
