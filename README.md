# <div align="center">Navigation Action Bar</div>

<div align="center">A flutter package for a beautiful modern Navigation Bar along with a Floating Action Bar</div><br>  

<div align="center">  
   <a href="https://flutter.io">  
    <img src="https://img.shields.io/badge/Platform-Flutter-yellow.svg"  
      alt="Platform" />  
  </a>  
   <a href="https://opensource.org/licenses/MIT">  
    <img src="https://img.shields.io/badge/License-MIT-red.svg"  
      alt="License: MIT" />  
  </a>  
</div><br>  

# Table of contents  

 * [Installing](#installing)  
 * [Usage](#usage)
 * [Attributes](#attributes)
 * [License](#license)  


# Installing

### 1. Depend on it
Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  navigation_action_bar: ^0.0.1
```

### 2. Install it

You can install packages from the command line:

with `pub`:

```css
$ pub get
```

with `Flutter`:

```css
$ flutter packages get
```

### 3. Import it

Now in your `Dart` code, you can use: 

```dart
import 'package:navigation_action_bar/navigation_action_bar.dart';
```


# Usage  

  
```dart
    Scaffold(
      bottomNavigationBar: NavigationActionBar(
        context: context,
        scaffoldColor: Colors.blueAccent,
        index: 0,
        subItems: [
          NavBarItem(iconData: Icons.attach_file, size: 25),
          NavBarItem(iconData: Icons.photo, size: 25),
          NavBarItem(iconData: Icons.camera_alt, size: 25),
        ],
        mainIndex: 2,
        items: [
          NavBarItem(iconData: Icons.list, size: 30),
          NavBarItem(iconData: Icons.compare_arrows, size: 30),
          NavBarItem(iconData: Icons.add, size: 40),
          NavBarItem(iconData: Icons.call_merge, size: 30),
          NavBarItem(iconData: Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      )
```
# Attributes
| Dart attribute                        | Datatype                    | Description                                                  | Default Value |
| :------------------------------------ | :-------------------------- | :------------------------------------------------- |:----------------------------:|
|index                                  | int                | Specifies the index of the tab which needs to be open initially            | 0 |
| mainIndex                         | int          | Specifies the index where the Rotating Button should be placed | @required |
| items                              | List&lt;NavBarItem&gt;                      | The list of widgets which are to be displayed in the Navigation Bar | @required |
| subItems                          | List&lt;NavBarItem&gt;                      | The list of widgets which are to be displayed in Action Bar |@required |
| scaffoldColor            | Color                       | The color of the scaffold             | Colors.blueAccent |
| backgroundColor            | Color                  | The background color of Navigation Bar          | Colors.white |
| animationCurve          | AnimationCurve                | Specifies the type of animation curve used by action buttons        | Curves.bounceOut|
| animationDuration           | Duration            | Specifies how long the animation will last         |300 Milliseconds|


# License  
Navigation_Action_Bar is licensed under `MIT license`. View [license](https://github.com/aseem09/navigation_action_bar/blob/master/LICENSE).
