import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0


BasePage {
    title: qsTr("Histórico")
    objectName: "Historico.qml"
    listViewDelegate: pageDelegate
    onRequestUpdatePage: requestHttp.get("movimentacoes_usuario/" + Settings.userId)
    toolBarActions: {
       "toolButton3": {"action":"filter", "icon":"filter"},
       "toolButton4": {"action":"search", "icon":"search"}
    }
    onRequestHttpReady: requestHttp.get("movimentacoes_usuario/" + Settings.userId)

    property var objects
    property var selecionado

    function showDetail(status,nome,retirada) {
        pageStack.push("HistoricObjectDetails.qml", {"status": status, "nomeObjeto": nome, "dataRetirada": retirada})
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

    Component {
        id: pageDelegate

        ListItem {
            primaryIconName: objeto_id.tipoObjeto_id.icone
            width: parent.width; height: 60
            primaryLabelText: objeto_id.nome
            secondaryLabelText: Qt.formatDateTime(retirada, "dd/MM/yyyy")
            showSeparator: true
            onClicked: showDetail(status,objeto_id.nome,retirada)
        }
    }
}
