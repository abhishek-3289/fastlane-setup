# **Fastlane-setup**
Easy fastlane setup for ios and android to install plugin and other dependencies and create lane build &amp; upload.

Will share build only by two clicks

<br>

---
<br>
<br>

## **iOS**

First add fastlane/.secret.env and stage changes of git

Copy all files from ios to your project, keep files in dir where .xcodeproj is present.

Then use below command in terminal to give access, then just double click to run setup `chmod u+x ./setup.command`

Setup file will see missing component and will fix for you eg: missing gems/pugins/secret for current setup


GEMS used `diawi` to upload file on diawi and get download able link, `pony` for sending downloaded link over mail

<br>

---
<br>
<br>

## **Android**
First add fastlane/.secret.env and stage changes of git

<br>

### **MAC-Setup**
Easy setup which resolve issue that occur while using google_drive plugin due to dependencies and version conflict issue which won't be solved by bundle.

<br>

Copy _Fastfile_,_mac-setup.command_ from android dir to your project.

Then use below command in terminal to give access, then just double click to run setup `chmod u+x ./mac-setup.command`

GEMS used `google_drive` to upload apk on *GoogleDrive* and get shareable link, `pony` for sending shareable link over mail

<br>

---
<br>
<br>

### **Troubleshooting**
<br>
If on double click on setup.command file dialog appear saying: '“setup.command” is damaged and can’t be opened. You should move it to the Bin.'
then just run `xattr -cr ./setup.command` in terminal

<br>
If you are unable to send mail then make sure that your 2FA is off and 

[Less secure app access](https://myaccount.google.com/u/0/lesssecureapps) is on 

[Create token](https://dashboard.diawi.com/profile/api)  for using diawi

If any TCP or Connection time out error comes while uploading build to diawi, delete Gemfile.lock then open terminal and run `bundle update`

Android config.json not found, Create your _config.json_ file for google_drive 
1. Open [Google Cloud Console](https://console.cloud.google.com/home/dashboard)
2. Select your project or create new project
3. From menu, under _APIs & Services_ click on Credentials
4. Click on Manage Service account and create your service account
5. Create new *KEY*  from this service account, it will download your _config.json_ file. 
6. Enable [Google Drive API](https://console.cloud.google.com/marketplace/product/google/drive.googleapis.com)
7. Make sure to share your drive folder to this service account from your [drive](https://drive.google.com/drive/my-drive) and provide edit access so that it can upload files.
8. Keep this _config.json_ file under fastlane dir or you can access it secretly.

