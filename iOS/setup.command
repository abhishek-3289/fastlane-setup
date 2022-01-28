#!/bin/sh
path="$(dirname "$0")"
cd "$path" || exit

printf "\n\n installing Bundler"
gem install bundler

if ! [ -f "Gemfile" ]; then
    printf "\n\n creating Gemfile"
    {
        echo 'source "https://rubygems.org"'
        printf '\ngem "fastlane"'
        printf '\ngem "pony"'
    } >> Gemfile
elif ! grep -q "fastlane" "Gemfile"; then
    printf '\ngem "fastlane"'  >> Gemfile
elif ! grep -q "pony" "Gemfile"; then
    printf '\ngem "pony"'  >> Gemfile
fi

if ! [ -d "$DIR" ]; then mkdir fastlane; fi
if [ -f ".env" ]; then cat .env >> fastlane/.env; fi
if [ -f ".ios.env" ]; then cat .ios.env >> fastlane/.ios.env; fi
if [ -f "Fastfile" ]; then cat Fastfile >> fastlane/Fastfile; fi
if ! [ -f "fastlane/.secret.env" ]; then
    {
        echo 'APPLE_ID=your apple id'
        echo 'DIAWI_TOKEN=token'
        echo 'FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD=password'
        echo 'SEND_E_MAIL_USERNAME=mail address'
        echo 'SEND_E_MAIL_PASSWORD=password'

    } >> fastlane/.secret.env
fi

if ! [ -f "fastlane/Pluginfile" ]; then fastlane add_plugin diawi; 
elif ! grep -q "diawi" "fastlane/Pluginfile"; then fastlane add_plugin diawi; fi

if ! [ -f "fastlane_ios_build.command" ]; then
    {
        echo "#!/bin/sh" 
        printf 'path="$''(dirname "$''0")"\n'
        printf 'cd "$''path" || exit'
        printf '\nbundle exec fastlane ios build'
    }>>fastlane_ios_build.command

    chmod u+x ./fastlane_ios_build.command 
fi

if ! [ -f "fastlane_ios_upload.command" ]; then
    {
        echo "#!/bin/sh" 
        printf 'path="$''(dirname "$''0")"\n'
        printf 'cd "$''path" || exit'
        printf '\nbundle exec fastlane ios upload'
    }>>fastlane_ios_upload.command
    
    chmod u+x ./fastlane_ios_upload.command 
fi


if [ -f ".env" ]; then rm .env; fi
if [ -f "Fastfile" ]; then rm Fastfile; fi
if [ -f ".ios.env" ]; then rm .ios.env; fi

echo 'updating bundle'
bundle update

exit 0;