import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: window
    visible: true
    width: 360; height: 580
    title: qsTr("Hello World")
    x: 510; y: 75
    Component.onCompleted: pageStack.push(Qt.resolvedUrl("Home.qml"))

    property bool isIOS: Qt.platform.os === "ios"
    property alias currentPage: pageStack.currentItem
    property bool isAndroid: Qt.platform.os === "android"
    property var user: {
        "profileName": "teacher",
        "profile": {
            "id": 1,
            "email": "enoquejoseneas@gmail.com",
            "name": "Enoque Joseneas"
        }
    }
    property var pages: [
        {
           "absPath": "Home.qml",
           "title": "Home",
           "icon": "gears",
           "roles": ["teacher"],
           "order": 1,
           "isHome": false,
           "showInMenu": true,
           "isLogin": false
        },
        {
           "absPath": "ListObjectsAvailable.qml",
           "title": "Objetos disponíveis",
           "icon": "gears",
           "roles": ["teacher"],
           "order": 2,
           "isHome": false,
           "showInMenu": true,
           "isLogin": false
        },
        {
           "absPath": "Transference.qml",
           "title": "Transferir Objeto",
           "icon": "exchange",
           "roles": ["teacher"],
           "order": 3,
           "isHome": false,
           "showInMenu": true,
           "isLogin": false
        },
        {
           "absPath": "Historico.qml",
           "title": "Histórico de Objetos",
           "icon": "gears",
           "roles": ["teacher"],
           "order": 4,
           "isHome": false,
           "showInMenu": true,
           "isLogin": false
        },
        {
            "absPath": "ReservarObjeto.qml",
            "title": "Reserva de Objetos",
            "icon": "gears",
            "roles": ["teacher"],
            "order": 5,
            "isHome": false,
            "showInMenu": true,
            "isLogin": false
        }
    ]

    // this signal can be used to pages make connections to some events
    // like push notification message|token, send by android QtActivity and iOS AppDelegate
    signal eventNotify(string eventName, var eventData)

    Loader {
        asynchronous: false
        source: "ToolBar.qml"
        onLoaded: window.header = item
    }

    Loader {
        asynchronous: false
        source: "Menu.qml"
    }

    Toast {
        id: toast
    }

    PageStack {
        id: pageStack
    }
}
