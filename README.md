# ReusableiOSCode
Reusable Modules across projects

All Manager files hel;p do initial setup for a project to work without hard-coded dependencies.

For e.g when we embark on a project, we need a way to handle fonts dynamically. Tying up fonts within Views and ViewControllers will make application look bad. In stead, we could create a PLIST/JSON file with list of supported fonts and go on from there. That's what FontManager helps you with

Same with the case for ThemeManager. BG colors for views, text color for labels and textfields, can be a nightmare to manage when left to later part of application development. This helps you to seed things.

As for the ViewManager goes, it helps you to to load appropraite static text in each form. Like form captions, label captions etc. Next logical step on this will be to handle validations dynamically and load/associate model objects on the fly

Setting up OmniBaG view for a custom implementation can sometimes be an ardent task. Check my implementation in OmniBGView directory and use it where ever needed
