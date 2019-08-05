# flutter channel stable
# flutter package get


# echo 'final String defaultServerAddr = "";' > ./lib/environment.dart
flutter build apk --split-per-abi --build-name=1.0.0 --build-number=$a
cp ./build/app/outputs/apk/release/app-release.apk ./release_apk/app-$a-$(date "+%m%d%H%M").apk
cp ./build/app/outputs/apk/release/app-armeabi-v7a-release.apk ./release_apk/app-armeabi-v7a-$a-$(date "+%m%d%H%M").apk
cp ./build/app/outputs/apk/release/app-arm64-v8a-release.apk ./release_apk/app-arm64-v8a-$a-$(date "+%m%d%H%M").apk
# flutter channel dev
# flutter package get