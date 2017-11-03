import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: window
    visible: true
    width: 360; height: 580
    title: qsTr("Hello World")
    x: 510; y: 75

    BasePage {
        id: base
        onRequestHttpReady: requestHttp.get("exibir_usuario/" + 2)
    }

    Component.onCompleted: initSystem()
    //Component.onProgressChanged: base.requestHttp.get("exibir_usuario/" + 2)

    function initSystem() {
        pageStack.push(Qt.resolvedUrl("Home.qml"))
    }

    property bool isIOS: Qt.platform.os === "ios"
    property alias currentPage: pageStack.currentItem
    property bool isAndroid: Qt.platform.os === "android"
    property var user

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
            "absPath": "ReservarObjeto.qml",
            "title": "Reserva de Objetos",
            "icon": "bookmark",
            "roles": ["teacher"],
            "order": 2,
            "isHome": false,
            "showInMenu": true,
            "isLogin": false
        },
        {
           "absPath": "Historico.qml",
           "title": "Histórico de Objetos",
           "icon": "history",
           "roles": ["teacher"],
           "order": 3,
           "isHome": false,
           "showInMenu": true,
           "isLogin": false
        },
        {
           "absPath": "TransferenciasAtivas.qml",
           "title": "Transferências",
           "icon": "exchange",
           "roles": ["teacher"],
           "order": 4,
           "isHome": false,
           "showInMenu": true,
           "isLogin": false
        },
        {
           "absPath": "RetirarItem.qml",
           "title": "Retirada de itens",
           "icon": "reply",
           "roles": ["teacher"],
           "order": 5,
           "isHome": false,
           "showInMenu": true,
           "isLogin": false
        }
    ]

    property var objectTypes: []
    property var objectStatus: []

    // this signal can be used to pages make connections to some events
    // like push notification message|token, send by android QtActivity and iOS AppDelegate
    signal eventNotify(string eventName, var eventData)
    
    Connections {
        target: base.requestHttp
        onFinished: {
            console.log(statusCode)
            if (statusCode != 200)
                return
            user = response
        }
    }

    Loader {
        asynchronous: false
        source: "ToolBar.qml"
        onLoaded: window.header = item
    }

    Loader {
        asynchronous: false
        source: "Menu.qml"
    }

    Loader {
        asynchronous: false; active: true
        source: "LoadFilterDialogTipos.qml"
    }

    Loader {
        asynchronous: false; active: true
        source: "LoadFilterDialogStatus.qml"
    }

    Toast {
        id: toast
    }

    PageStack {
        id: pageStack
    }
}
