import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

BasePage {
    property int userId: 1
    title: qsTr("Reserve um objeto")
    objectName: "ObjetoReservado.qml"
    listViewDelegate: pageDelegate
    //onRequestUpdatePage: requestHttp.get("exibir_objetos/")
    onRequestUpdatePage: requestHttp.get("movimentacoes_abertas_usuario/" + userId)
    toolBarActions: {
       "toolButton3": {"action":"filter", "icon":"filter"},
       "toolButton4": {"action":"search", "icon":"search"}
    }
    //onRequestHttpReady: requestHttp.get("exibir_objetos/")
    onRequestHttpReady: requestHttp.get("movimentacoes_abertas_usuario/" + userId)

    property var objects

    function showDetail(delegateIndex) {
        pageStack.push("ReservarObjectDetails.qml", {"details":objects[delegateIndex]})
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
            objects = []
            for (var i = 0; i < response.length; ++i) {
                objects[i] = requestHttp.get("exibir_objeto/" + response[i].objeto_id.id)

                listViewModel.append(objects[i])
            }
        }
    }


    Component {
        id: pageDelegate

        ListItem {
            badgeText: index+1
            secondaryIconName: "gear"
            badgeBackgroundColor: (index%1) ? "red" : "yellow"
            width: parent.width; height: 60
            primaryLabelText: objeto_id.nome
            secondaryLabelText: tipoObjeto_id.nome
            showSeparator: true
            onClicked: showDetail(index)
        }
    }
}
