import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import "Awesome/"

ApplicationWindow {
    id: window
    visible: true
    width: 360; height: 580
    title: menuSwipe.swipeChildCurrentItem.title
    x: 510; y: 75

    function depthChange() {
        if(!menuSwipe)
            return;
        if(depth === 0){
            isSwipeView = true
            menuSwipe.tabBarChild.visible = true
            menuSwipe.z = window.z + 1
            pageStack.z = window.z - 1
        } else {
            isSwipeView = false
            menuSwipe.tabBarChild.visible = false
            pageStack.z = window.z + 1
            menuSwipe.z = window.z - 1
        }
    }

    function pushPage(url, args) {
        pageStack.push(url, args)
    }

    function popPage() {
        if(depth === 1)
            pageStack.clear()
        pageStack.pop()
    }

    function voltar() {
        isSwipeView = true
        popPage()
    }

    function updatePage() {
        menuSwipe.swipeChildCurrentItem.update()
    }

    BasePage {
        id: base
        onRequestHttpReady: requestHttp.get("exibir_usuario/" + 1)
    }

    property bool isSwipeView: true
    property alias currentPageSwipe: menuSwipe.swipeChildCurrentItem
    property alias depth: pageStack.depth
    property bool hasNetworkRequest: true

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
            "icon": "gears",
            "roles": ["teacher"],
            "order": 2,
            "isHome": false,
            "showInMenu": true,
            "isLogin": false
        },
        {
           "absPath": "Historico.qml",
           "title": "Histórico de Objetos",
           "icon": "gears",
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

    // this signal can be used to pages make connections to some events
    // like push notification message|token, send by android QtActivity and iOS AppDelegate
    signal eventNotify(string eventName, var eventData)

    onDepthChanged:  depthChange()

    Connections {
        target: base.requestHttp
        onFinished: {
            console.log(statusCode)
            if (statusCode != 200)
                return
            user = response
            pageStack.push(Qt.resolvedUrl("Home.qml"))
        }
    }

    /*Loader {
        asynchronous: false
        source: "ToolBar.qml"
        onLoaded: window.header = item
    }

    Loader {
        asynchronous: false
        source: "Menu.qml"
    }*/

    Toast {
        id: toast
    }

    header: ToolBar {
        id: toolbar
        Rectangle {
            color: "#2196f3"
        }
        anchors.leftMargin: 10

        RowLayout {
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            anchors.fill: parent

            Icon {
                name: "arrow-left"
                visible: !isSwipeView
                color: "#000"
                size: 22
                onClicked: voltar()
            }

            Column {
                Label {
                    text: isSwipeView ? "CES" : ""
                    font.pixelSize: 20
                    font.bold: true
                }
                Label {
                    text: isSwipeView ? "Sistema de Controle de Entrada e Saída de Objetos" : ""
                    font.pixelSize: 12
                }
            }

            RowLayout {
                anchors.top: parent.top
                anchors.right: parent.right
                spacing: 5
                Label {
                    text: "Olá, " + (user !== null ? user.name : "Anônimo")
                    font.pixelSize: 12
                }
                Icon {
                    name: "user"
                    color: "#000"
                    size: 15
                    onClicked: popPage()
                }
                Icon {
                    name: "gear"
                    color: "#000"
                    size: 15
                    onClicked: popPage()
                }
            }
        }
    }

    MenuSwipe {
        id: menuSwipe
        anchors.top: parent.top
        onSwipeChildCurrentItemChanged: updatePage()
    }

    StackView {
        id: pageStack
        anchors.fill: parent

        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {
                if (pageStack.depth > 1) {
                    pageStack.pop();
                    event.accepted = true;
                }
            }
        }

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0; to: 1; duration: 450
            }
        }

        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1; to: 0; duration: 450
            }
        }
    }
}
