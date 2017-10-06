QT += quick quickcontrols2 network svg

CONFIG += c++11 debug

SOURCES += CES-Mobile/main.cpp CES-Mobile/requesthttp.cpp

HEADERS += CES-Mobile/requesthttp.h

RESOURCES += CES-Mobile/qml.qrc

OTHER_FILES += CES-Mobile/Settings.json

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
