# UIKit-PW2
HW task 2 for HSE SE UIKit course

# Questions! Yaay
## What does the code on lines 25 and 29 do?
 25: We set this loong property to false to make the auto layout work properly. Basically acts a sign that you're taking full control of the view positioning/constraints in your app which prevents further conflicts.
 29: Displaying the title on the main view so that it is visible.
  
## What is a safe area layout guide?
 The "usable" part of the screen, where we can put our UI elements and they won't get covered or cropped.
  
## What is [weak self] on line 23 and why it is important?
 Memory management concept used to prevent strong reference cycles in closures. Prevents memory leaks by ensuring that the closure doesn't permanently hold a strong reference to self (the view controller)

## Question: What does clipsToBounds mean?
 If true: subviews of this view are not visible outside of this view's bounds, false - are visible.
  
## Question: What is the valueChanged type? What is Void and what is Double?
 Closure (self-contained block of code/anonymous function). Void - "empty" type, Double - floating point double precision number type.
