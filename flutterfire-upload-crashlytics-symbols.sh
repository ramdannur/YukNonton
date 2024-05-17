#!/bin/bash
PATH=${PATH}:$FLUTTER_ROOT/bin:$HOME/.pub-cache/bin
flutterfire upload-crashlytics-symbols --upload-symbols-script-path=$PODS_ROOT/FirebaseCrashlytics/upload-symbols --platform=ios --apple-project-path=${SRCROOT} --env-platform-name=${PLATFORM_NAME} --env-configuration=${CONFIGURATION} --env-project-dir=${PROJECT_DIR} --env-built-products-dir=${BUILT_PRODUCTS_DIR} --env-dwarf-dsym-folder-path=${DWARF_DSYM_FOLDER_PATH} --env-dwarf-dsym-file-name=${DWARF_DSYM_FILE_NAME} --env-infoplist-path=${INFOPLIST_PATH} --default-config=default
