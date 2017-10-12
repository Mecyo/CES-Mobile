import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0


BasePage {
    //Trocar por id do usuário do Emile
    property int userId: 2
    property string userName: "Emerson"

    title: qsTr("Home")
    objectName: "Home.qml"
    listViewDelegate: pageDelegate
    onRequestUpdatePage: requestHttp.get("movimentacoes_abertas_usuario/" + userId)
    toolBarActions: {
       "toolButton3": {"action":"filter", "icon":"filter"},
       "toolButton4": {"action":"search", "icon":"search"}
    }
    onRequestHttpReady: requestHttp.get("movimentacoes_abertas_usuario/" + userId)

    property var objects
    property var selecionado

    function showDetail(delegateIndex) {
        selecionado = objects[delegateIndex].objeto_id
        pageStack.push("/ShowObjectDetails.qml", {"details":selecionado})
    }

    function devolver(delegateIndex) {
        selecionado = objects[delegateIndex].objeto_id
        console.log("Devolvendo o Objeto: ", JSON.stringify(selecionado))
        pageStack.push("ShowObjectDetails.qml", {"details":selecionado})
    }

    function transferir(delegateIndex) {
        selecionado = objects[delegateIndex].objeto_id
        console.log("Transferindo o Objeto: ", JSON.stringify(selecionado))
        pageStack.push("Transference.qml", {"objeto":selecionado})
    }

    Datepicker {
        id: datepicker
    }

    FilterDialog {
        id: filterDialog
    }

    Connections {
        target: window
        onEventNotify: if (eventName === "filter") filterDialog.open()
    }

    Connections {
        target: requestHttp
        onFinished: {
            if (statusCode != 200)
                return
            objects = response
            for (var i = 0; i < response.length; ++i)
                listViewModel.append(objects[i])
        }
    }

    Row {
        Label {
            id: labelUserName
            text: "Objetos com você, " + userName
        }
    }

    Component {
        id: pageDelegate

        ListItem {
            primaryIconName: objeto_id.tipoObjeto_id.icone
            secondaryIconName:  "reply"
            secondaryActionIcon.onClicked: devolver(index)
            tertiaryIconName:  "exchange"
            tertiaryActionIcon.onClicked: transferir(index)
            width: parent.width; height: 60
            primaryLabelText: objeto_id.nome
            secondaryLabelText: Qt.formatDateTime(retirada, "dd/MM/yyyy")
            showSeparator: true
            onClicked: showDetail(index)
        }
    }
}
