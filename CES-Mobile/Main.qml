import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Awesome/"

ApplicationWindow {
    id: window
    visible: true
    width: 360; height: 580
    title: menuSwipe.swipeChildCurrentItem.title
    x: 510; y: 75

    property string colorWindowLogin: "#3580cf"
    property string colorInputActive: "#20579d"
    property string colorInputInActive: "#2461ac"
    property string colorButton: "#b2cff4"
    property string colorFontButton: "#405e84"
    property string inputFocus: "login"

   Popup {
        id: popup
        x: window.width / 10
        y: window.height / 4
        width: window.width - (x * 2)
        height: window.height / 2
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        Component.onCompleted: open()

        contentItem: Rectangle {
            radius: 8
            color: colorWindowLogin
            anchors.centerIn: parent
            Text {
                id: mensagem
                text: ""
                color: "#FFF"
            }
            Column {
                anchors.centerIn: parent
                spacing: 16
                Column {
                    id: colLogin
                    x: 10
                    width: 200
                    height: 52
                    spacing: 4
                    Text { text: "Login" }
                  TextField {
                      id: login
                      width: parent.width
                      font.family: "Verdana"
                      focus: true
                      onFocusChanged: changedFocus("login")
                      background: Rectangle{
                        radius: 4
                        color: inputFocus == "login" ? colorInputActive : colorInputInActive
                      }
                  }
                }
                Column {
                    id: colSenha
                    x: 10
                    width: 200
                    height: 52
                    spacing: 4
                    Text { text: "Senha" }
                    TextField {
                        id: senha
                        width: parent.width
                        echoMode: TextInput.Password
                        onFocusChanged: changedFocus("senha")
                        background: Rectangle{
                            radius: 4
                            color: inputFocus == "senha" ? colorInputActive : colorInputInActive
                        }
                    }
                }
                Row {
                      spacing: 16
                  anchors.horizontalCenter: parent.horizontalCenter
                  Button {
                      text: "Login"
                      onClicked: initSystem()
                       background: Rectangle {
                           radius: 4
                          color: colorButton
                      }
                  }
                  Button {
                      text: "Sair"
                      onClicked: window.close()
                      background: Rectangle {
                          radius: 4
                         color: colorButton
                     }
                  }
                }
             }
        }

    }

    Component.onCompleted: popup.open()//pageStack.push(Qt.resolvedUrl("Login.qml"))
    //Component.onProgressChanged: base.requestHttp.get("exibir_usuario/" + 2)

    function changedFocus(inputName) {
        inputFocus = inputName
        mensagem.text = ""
    }

    function initSystem() {
        var valida = true
        if(login.text === "" && senha.text === "") {
            mensagem.text = "Informe login e senha!"
            valida = false
        }
        else if(login.text === "") {
            mensagem.text = "Informe o login!"
            valida = false
        }
        else if(senha.text === ""){
            mensagem.text = "Informe a senha!"
            valida = false
        }

        if(valida) {

            var usuario = ({})
            usuario.login = login.text
            usuario.senha = senha.text

            base.requestHttp.post("logar/", JSON.stringify(usuario))
        }
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

    BasePage {
        id: base
        //onRequestHttpReady: requestHttp.get("exibir_usuario/" + 2)
    }

    property bool isSwipeView: true
    property alias currentPageSwipe: menuSwipe.swipeChildCurrentItem
    property alias depth: pageStack.depth
    property bool hasNetworkRequest: true

    property var objectTypes: []
    property var objectStatus: []

    // this signal can be used to pages make connections to some events
    // like push notification message|token, send by android QtActivity and iOS AppDelegate
    signal eventNotify(string eventName, var eventData)

    signal swipeChange()

    onDepthChanged:  depthChange()

    Connections {
        target: base.requestHttp
        onFinished: {
            console.log(statusCode)
            if (statusCode != 200) {
                mensagem.text = "Falha ao efetuar login!"
                return
            }
            user = response
            popup.close()

            menuSwipe.childrenChanged()
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
    
    Loader {
        asynchronous: false; active: true
        source: "LoadFilterDialogTipos.qml"
    }

    Loader {
        asynchronous: false; active: true
        source: "LoadFilterDialogStatus.qml"
    }

    header: ToolBar {
        id: toolbar
        Rectangle {
            color: "#2196f3"
        }
        anchors.leftMargin: 10

        RowLayout {
            id: rowDados
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
        RowLayout {
            id: rowUser
            anchors.top: rowDados.bottom
            Label {
                id: labelUserName
                text: "Objetos com você, " + window.user.perfilUsuario_id.nome + " " + window.user.name
            }
        }
    }

    MenuSwipe {
        id: menuSwipe
        anchors.top: parent.top
        onSwipeChildCurrentItemChanged: swipeChange()
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
