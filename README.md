# Goodges
Goodbye badges, hello labels!

## Disclaimer

**This repository is not maintained anymore. Please see [NoisyFlake's repository](https://github.com/NoisyFlake/Goodges) for an updated version.**

### Description
Goodges radically changes the way notifications are displayed on the homescreen.

It replaces the badges by changing the icon labels. For instance, if there is a notification pending on the Facebook app, the label of the application is changed to '1 notification'.
But Goodges is intelligent ! It varies depending on the app : if there are two updates pending on Cydia, the label will display '2 updates'.
Also, if the app is set so as to not display any badges, Goodges will take that into account and will not show anything.

### Changelog
**Version 1.1.5**
* Added Harbor compatibility.
* Little bug fixes.

**Version 1.1.4**
* Fixes hidden labels that would display randomly.

**Version 1.1.3**
* Added Korean translation (thanks @BamGwanRamCha).
* Temporary fix for shaking icons.
* Fix folders displaying bad notifications count.

**Version 1.1.2**
* Fixes iOS 8 compatibility.

**Version 1.1.1**
* Fixes an issue with settings getting back to defaults.

**Version 1.1.0**
* Added iOS 10 compatibility.
* Reworked from scratch, way smoother now.
* Settings have been remade, so you'll lose those you currently have.
* New feature: make icons glow when a notification is pending.
* New feature: make icons shake.
* New feature: you can now export your settings!

**Version 1.0.0**
* Public release.

### Installation
You must have [theos](https://github.com/theos/theos) installed to compile Goodges.
Also, make sure to have *applist* and *libcolorpicker* placed in your `$THEOS/lib` folder.
You can check my [headers repo](https://github.com/faku99/headers) for headers.

Then, type the following in a terminal window:

    cd path/to/folder
    make


### License
[GPL 3.0](LICENSE.md)
