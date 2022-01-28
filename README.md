# fastlane-setup
Easy fastlane setup for ios and android to install plugin and other dependencies and create lane build &amp; upload

## IOS

First add fastlane/.secret.env and stage changes of git

Copy all files from ios to your project

then use below command in terminal to give access, then just double click to run setup

`chmod u+x ./setup.command`

setup file will see missing component and will fix for you eg: missing gems/pugins/secret for current setup

if on double click on setup.command file dialog appear saying: '“setup.command” is damaged and can’t be opened. You should move it to the Bin.'

then just run `xattr -cr ./setup.command` in terminal

keep files in dir where .xcodeproj is present.
