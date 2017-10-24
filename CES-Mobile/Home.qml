import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0


BasePage {
    title: qsTr("Objetos com você")
    objectName: "Home.qml"
    listViewDelegate: pageDelegate
    onRequestUpdatePage: requestHttp.get("movimentacoes_abertas_usuario/" + Settings.userId)
    toolBarActions: {
       "toolButton3": {"action":"filter", "icon":"filter"},
       "toolButton4": {"action":"search", "icon":"search"}
    }
    onRequestHttpReady: requestHttp.get("movimentacoes_abertas_usuario/" + Settings.userId)

    property var objects

    function showDetail(delegateIndex) {
        pageStack.push("DetalhesObjeto.qml", {"details": objects[delegateIndex]})
    }

    function transferir(delegateIndex) {
        pageStack.push("Transference.qml", {"details":objects[delegateIndex]})
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

    Component {
        id: pageDelegate

        ListItem {
            primaryIconName: objeto_id.tipoObjeto_id.icone
            tertiaryIconName:  "exchange"
            tertiaryActionIcon.onClicked: transferir(index)
            width: parent.width; height: 60
            primaryLabelText: objeto_id.nome
            secondaryLabelText: Qt.formatDateTime(objects[index].retirada === null ? objects[index].reserva : objects[index].retirada, "dd/MM/yyyy HH:mm")
            showSeparator: true
            onClicked: showDetail(index)
        }
    }
}
