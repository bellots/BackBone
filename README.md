# BackBone

When I start a project, I notice that I always setup it in the same way, and setupping it steals me a lot of time because maybe I have to copy code from my latest projects, getting the latest optimizations.

So I decided to create a repo, always updated, with the most used libraries and my directories.

I splitted it in **3 main branches**:

1. **Without API Client**
2. **With Alamofire**
3. **With Apollo Client (GraphQL)**

These 3 branches have the same core, based on files grouped by semantic (I.E. **UIViewControllers/...**)


#STYLE
I created a solid logic based on **UIAppearance**, so I *subclass* every primitive UIKit element (UILabel, UIButton etc.) and then I apply a specific style for the sublcass.

## **Example**

I want to have a label which has **red textColor** and a **blue backgroundColor**.

### How to

1) Create a Swift file (if doesn't already exist) in **Subclasses** directory called *UILabels*.

2) If it's the first label that you add as subclass, first create a class in *UILabels.swift* in this way: `@IBDesignable class DefaultLabel{}`. It's important because UIAppearance overrides every UILabel style, like titleLabel in UIButtons.

3) Inside that file, add a class:`@IBDesignable class RedOnBlueLabel:DefaultLabel{}`

4) Check if exists a file in *Themes directory* named *ThemeLabels.swift* or something like that. If not, create that

5) Add a struct called as you want (I suggest something like *ThemeLabel*

6) Add a function called `static func setStyle(for theme:Theme`)

7) The `enum Theme` is an enum which you define in file *Themes/Theme.swift*

8) If your app could be used in different modes (like `standard` and `dark`), your function added in point **6** will be:

```
		static func setStyle(for theme:Theme){
   			switch theme {
        	case .standard:
				DefaultLabel.appearance().textColor = UIColor.black
				RedOnBlueLabel.appearance().textColor = UIColor.red
				RedOnBlueLabel.appearance().backgroundColor = UIColor.blue
			case .dark:
				DefaultLabel.appearance().textColor = UIColor.white
				RedOnBlueLabel.appearance().textColor = UIColor.red
				RedOnBlueLabel.appearance().backgroundColor = UIColor.blue
			}
		}
```

9) In *Themes/Theme.swift*, would be:

```
enum Theme{
    case standard
    case dark
    
    func setStyle(){
        ThemeLabel.setStyle(for:self)
    }
}

```

10) That's it! This `setStyle()` is called in `AppDelegate->DidFinishLaunchingWithOptions` function.