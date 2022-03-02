# Add more folders to ship with the application, here
#folder_01.source = qml/SpaceSheepMobile
#folder_01.target = qml
#folder_02.source = images
#folder_03.source = fonts
#folder_04.source = audio
#DEPLOYMENTFOLDERS = folder_01
#DEPLOYMENTFOLDERS +=folder_02
#DEPLOYMENTFOLDERS +=folder_03
#DEPLOYMENTFOLDERS +=folder_04


QT += quick multimedia sensors declarative qml
CONFIG += qtestlib mobility
# CONFIG += mobility
MOBILITY = multimedia


# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    qtquick2applicationviewer/mainview.cpp \
    qtquick2applicationviewer/global.cpp \
    qtquick2applicationviewer/bullet.cpp \
    threadtest.cpp \
    qtquick2applicationviewer/qtquick2applicationviewer.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
#include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
#qtcAddDeployment()

OTHER_FILES += \
#    audio/move.wav \
#    audio/mdestr.au \
#    audio/crash.wav \
#    audio/collisn.au \
#    audio/blast.au \
#    audio/bgaudio_mono.au \
#    audio/Baah.wav \
#    audio/666ways-03-intro-solo.mp3 \
#    fonts/PressStart2P-Regular.ttf \
#    fonts/HanaleiFill-Regular.ttf \
#    qml/androidqml/Star.qml \
#    qml/androidqml/SpaceField.qml \
#    qml/androidqml/Ship.qml \
#    qml/androidqml/Meteor.qml \
#    qml/androidqml/main.qml \
#    qml/androidqml/Button.qml \
#    qml/androidqml/Bullet.qml \
#    qml/androidqml/defs.js \
#    images/boom0.gif \
#    images/boom1.gif \
#    images/boom2.gif \
#    images/boom3.gif \
#    images/boom4.gif \
#    images/bullet.gif \
#    images/linelat.jpg \
#    images/bullet.png \
#    images/decoration.png \
#    images/meteor0.png \
#    images/meteor1.png \
#    images/meteor2.png \
#    images/meteor3.png \
#    images/meteor4.png \
#    images/meteor5.png \
#    images/presimag.png \
#    images/ship.png \
    android/AndroidManifest.xml

HEADERS += \
    qtquick2applicationviewer/mainview.h \
    qtquick2applicationviewer/global.h \
    qtquick2applicationviewer/defs.h \
    qtquick2applicationviewer/bullet.h \
    threadtest.h \
    qtquick2applicationviewer/qtquick2applicationviewer.h

# ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

RESOURCES += \
    SpacheSheepMobile.qrc
