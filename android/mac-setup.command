#!/bin/sh
path="$(dirname "$0")"
cd "$path" || exit

printf "\n\n installing Bundle"
gem install bundle

if ! [ -f "Gemfile" ]; then
    printf "\n\n creating Gemfile"
    {
        echo 'source "https://rubygems.org"'
        printf '\ngem "fastlane"'
        printf '\ngem "pony"'
        printf '\ngem "nokogiri", "~> 1.10", "= 1.10.8"'
        printf '\ngem "google_drive", "~> 3.0", ">= 3.0.6"'
        printf '\ngem "googleauth", "~> 0.17", "<= 0.17.1"'
    } >> Gemfile
elif ! grep -q "fastlane" "Gemfile"; then printf '\ngem "fastlane"'  >> Gemfile;
elif ! grep -q "pony" "Gemfile"; then printf '\ngem "pony"'  >> Gemfile;
elif ! grep -q "nokogiri" "Gemfile"; then printf '\ngem "nokogiri", "~> 1.10", "= 1.10.8"' >> Gemfile;
elif ! grep -q "google_drive" "Gemfile"; then printf '\ngem "google_drive", "~> 3.0", ">= 3.0.6"' >> Gemfile;
elif ! grep -q "googleauth" "Gemfile"; then printf '\ngem "googleauth", "~> 0.17", "<= 0.17.1"'  >> Gemfile;
fi

if ! [ -d "fastlane" ]; then mkdir fastlane; fi
if [ -f ".env" ]; then cat .env >> fastlane/.env; fi
if [ -f "Fastfile" ]; then cat Fastfile >> fastlane/Fastfile; fi
if ! [ -f "fastlane/.secret.env" ]; then
    {
        echo 'GOOGLE_FOLDER_ID=your folder id where build need to be uploaded'
        echo 'SEND_E_MAIL_USERNAME=mail address'
        echo 'SEND_E_MAIL_PASSWORD=password'
    } >> fastlane/.secret.env
fi

if ! [ -f "fastlane/Appfile" ]; then
    {
        echo 'json_key_file("path/to/your/play-store-credentials.json")'
        echo 'package_name("my.package.name")'
    } >> fastlane/Appfile
fi

if ! [ -f ".env" ]; then
    {
        echo 'APPLICATION_NAME=app name'
        echo 'FL_GRADLE_FLAVOR=flavor dev|qa|prod'
        echo 'FL_GRADLE_BUILD_TYPE=Debug|Release'
        echo 'FL_GRADLE_BUILD_VERSION=1.0'
        echo 'SEND_E_MAIL_TO=to'
        echo 'SEND_E_MAIL_CC=cc'
        echo 'SEND_E_MAIL_SUBJECT=sub'
        echo 'SEND_E_MAIL_APP_ICON_URL=url'
        echo 'SEND_E_MAIL_APP_PRIMARY_COLOR=#000000'
    } >> fastlane/.env
fi


if ! [ -f "fastlane_build.command" ]; then
    {
        echo "#!/bin/sh" 
        printf 'path="$''(dirname "$''0")"\n'
        printf 'cd "$''path" || exit'
        printf '\nbundle exec fastlane android build'
    }>>fastlane_build.command
    chmod u+x ./fastlane_build.command 
fi

if ! [ -f "fastlane_upload.command" ]; then
    {
        echo "#!/bin/sh" 
        printf 'path="$''(dirname "$''0")"\n'
        printf 'cd "$''path" || exit'
        printf '\nbundle exec fastlane android upload'
    }>>fastlane_upload.command
    chmod u+x ./fastlane_upload.command 
fi

if [ -f "Fastfile" ]; then rm Fastfile; fi

echo 'updating bundle'
bundle update

exit 0;