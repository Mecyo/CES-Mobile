import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

BasePage {
    title: qsTr("Transferência")
    objectName: "Transference.qml"
    listViewDelegate: pageDelegate
    onRequestUpdatePage: requestHttp.get("exibir_usuarios/")
    toolBarActions: {
       "toolButton3": {"action":"filter", "icon":"filter"},
       "toolButton4": {"action":"search", "icon":"search"}
    }
    toolBarState: "goback"
    onRequestHttpReady: requestHttp.get("exibir_usuarios/")

    property var users
    property var selecionado
    property int post: 0

    function transferir(usuarionovoId) {
        var dados = ({})
        dados.objeto_id = selecionado.objeto_id.id
        dados.movimentacao_id = selecionado.movimentacao_id.id
        dados.novo_usuario_id = usuarionovoId

        requestHttp.post("transferir_objeto/", JSON.stringify(dados))
        post = 1
    }

    Datepicker {
        id: datepicker
    }

    FilterDialog {
        id: filterDialog
    }

    Timer {
        id: popCountdow
        interval: 3000; repeat: false
        onTriggered: pageStack.push(Qt.resolvedUrl("Home.qml"))
    }

    Connections {
        target: window
        onEventNotify: if (eventName === "filter") filterDialog.open()
    }

    Connections {
        target: requestHttp
        onFinished: {
            console.log("Status ===  " + statusCode)
            if (statusCode != 200) {
                post = 0
                return
            }
            if(post) {
                toast.show(qsTr("Você transferiu o objeto com sucesso!"), true, 2900)
                popCountdow.start()
            }
            users = response
            for (var i = 0; i < response.length; ++i)
                if(users[i].id !== user.id)
                    listViewModel.append(users[i])
        }
    }

    Component {
        id: pageDelegate

        ListItem {
            badgeText: index+1
            secondaryIconName: selecionado !=null ? "check" : ""
            badgeBackgroundColor: (index%2) ? "red" : "yellow"
            width: parent.width; height: 60
            primaryLabelText: name
            secondaryLabelText: email
            showSeparator: true
            secondaryActionIcon.onClicked: transferir(id)
        }
    }
}
