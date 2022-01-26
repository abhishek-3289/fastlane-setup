#!/bin/sh
path="$(dirname "$0")"
echo "$path"
cd "$path" || exit

printf "\n\n"
echo 'installing Bundler'
gem install bundler

printf "\n\n"
echo 'creating Gemfile'
touch Gemfile
{
    echo 'source "https://rubygems.org"'
    echo ''
    echo 'gem "fastlane"'
    echo 'gem "pony"'
} >> Gemfile

printf "\n\n"
echo 'installing fastlane'
bundler update


printf "\n\n"
echo 'fastlane env setup'
mkdir fastlane
touch fastlane/.env
touch fastlane/.ios.env
touch fastlane/.secret.env
touch fastlane/Fastfile
touch fastlane/Pluginfile

{
    echo 'APPLE_ID=your apple id'
    echo 'DIAWI_TOKEN=token'
    echo 'FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD=password'
    echo 'SEND_E_MAIL_USERNAME=mail address'
    echo 'SEND_E_MAIL_PASSWORD=password'

} >> fastlane/.secret.env

cat .env >> fastlane/.env
cat .ios.env >> fastlane/.ios.env
cat Fastfile >> fastlane/Fastfile

printf "\n\n"
echo 'installing plugin diawi'
fastlane add_plugin diawi

printf "\n\n"
echo 'creating command files for lane'
touch fastlane_ios_build.command
touch fastlane_ios_upload.command

{
    echo "#!/bin/sh" 
    printf 'path=$''"(dirname "$''0")"'
    echo ''
    printf 'cd "$''path" || exit'
    echo ''
    echo 'bundle exec fastlane ios build'
}>>fastlane_ios_build.command

{
    echo "#!/bin/sh" 
    printf 'path=$''"(dirname "$''0")"'
    echo ''
    printf 'cd "$''path" || exit'
    echo ''
    echo 'bundle exec fastlane ios upload'
}>>fastlane_ios_upload.command

chmod u+x ./fastlane_ios_build.command 
chmod u+x ./fastlane_ios_upload.command 

printf "\n\n"
echo 'clean up'

rm .env 
rm Fastfile
rm .ios.env