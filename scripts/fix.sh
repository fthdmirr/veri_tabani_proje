cd ..
cd ios
arch -x86_64 rm -rf Podfile.lock
arch -x86_64 pod install --repo-update
