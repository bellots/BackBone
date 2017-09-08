# UsefulExtensions

This library gives you some useful vars and functions by extending standard classes and types.

## Types extended:

### Locale:

* Get Locale from a simple static var
```
Locale.italy // returns Locale with string "it-IT"
Locale.usa // returns Locale with string "en-US"
```

### Double:

* Rounds to fraction digits

```
2.123131.round(fractionDigits:2) // output: 2.12
```

* Returns a string formatted starting from the double with locale and style

```
let price:Double = 100.00
print(price.format(with: .italy, and: .currencyISOCode)) // prints 100.00 EUR
```

### String:

* Return the localized string

```
"alert_message".localized // output: whatever you have in your .strings file at alert_message string
```

* Return your string without useless whitespaces  

```
" hello world".trimmed // output: hello world
```

### UIApplication:

* Return the active ViewController

``` 
UIApplication.toppestViewController() 
```

### UIColor:

* More readable function to get UIColor from RGB

``` 
UIColor(r:200, g:200, b:200) 
```

### UINavigationItem:

* Create a dismissable left button

```                 
self.navigationItem.addDismissLeftButton(target: self, selector: #selector(...), image:UIImage(named:"asd"), scale: 10) 
```

### UITableView:

* Check if TableView is scrolled to bottom

```
self.tableView.isScrolledToBottom // output: true or false
```

* Scroll to bottom your tableView

```
self.tableView.scrollToBottom(animated:true)
```

* Register uitableview from xib in a more elegant way

```
self.tableView.register(CustomTableViewCell.self)
```

### UITextField:

* Change placeholder UIColor (also directly in storyboard or xib)

```
textField.placeholderColor = UIColor.red
```

### UIViewController:

* Get the string name from UIViewController Class

```
TestViewController.nameIdentifier // output: "TestViewController"
```

* present ViewController if you want embedded in a NavigationController

```
self.present(viewControllerToPresent: vc, animated: true, embedInNavigationController: true, completion: nil)
```

### UIView:

* Get the string name from UIView Class

```
MyCustomView.nameIdentifier // output: "MyCustomView"
```

* get UIView SubClass from it's nib directly from the class

```
MyCustomView.loadViewFromNib()
```

* function which serves to IBDesignable nib class.

If ```setup()``` is called in your *IBDesignable* class in functions ```initWithCoder``` and in ```initWithFrame```, you can see your custom UIView in storyboard 

```

@IBDesignable

class CustomLabel: UIView {

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        setup()
    }
}

```

* update your constraint with animation

```
myView.change(topConstraint, constantWith:20.0, andAnimating:true)
```

* fadeIn your UIView

```
myView.fadeIn(withAnimation:true)
```

* fadeOut your UIView

```
myView.fadeOut(withAnimation:true)
```

* generally fade your UIView

```
myView.fade(withAnimation:true)
```

* get top constraint array

```
let constraints:[NSLayoutConstraint] = myView.topConstraints
```

* useful IBInspectable variables

```
myView.cornerRadius = 5.0
myView.borderWidth = 2.0
myView.borderColor = UIColor.blue
```

### MKMapView:

* center the map on the desired location with the desired radius

```
mapView.centerMapOnLocation(location, radius:50000)
```

### UIStackView:

* add an arranged subView to UIStackView giving the desired width

```
stackView.add(myView, width:150)
```
