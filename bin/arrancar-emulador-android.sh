#!/bin/bash

PATH=$PATH:/home/alvaro/Android/Sdk/emulator

AVD=$(emulator -list-avds)
AVD=$(echo $AVD | awk '{print $1}') #si hay más de una línea, elijo la primera
echo Es necesario apagar VirtualBox!
echo Cambiar idioma: adb shell am start -a android.settings.LOCALE_SETTINGS
echo Instalar: adb install app/build/outputs/apk/debug/app-debug.apk


emulator -avd $AVD
