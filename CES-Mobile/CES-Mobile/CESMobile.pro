QT += quick quickcontrols2 network svg

CONFIG += c++11 debug

SOURCES += main.cpp requesthttp.cpp

HEADERS += requesthttp.h

RESOURCES += qml.qrc

OTHER_FILES += Settings.json

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
