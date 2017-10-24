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

  /*  onListViewReady: {
        var json = [
            {"status": 0, "objeto_id": {"nomeObjeto": "Projetor sony"}, "dataRetirada": "16/07/802701 14:00"},
            {"status": 1, "objeto_id": {"nomeObjeto": "Chave sony"}, "dataRetirada": "16/07/2701 14:00"},
            {"status": 2, "objeto_id": {"nomeObjeto": "Projetor sega"}, "dataRetirada": "15/07/9000 14:00"},
            {"status": 2, "objeto_id": {"nomeObjeto": "Chave sega"}, "dataRetirada": "28/07/1993 14:00"}
        ]
        for (var i = 0; i < json.length; i++)
            listViewModel.append(json[i])
    }*/

    property var objects
    property var selecionado

    function showDetail(status,nome,retirada) {
        pageStack.push("HistoricObjectDetails.qml", {"status": status, "nomeObjeto": nome, "dataRetirada": retirada})
    }

    ListModel {
        id: buscaModel
    }

    ListModel {
        id: originalModel
    }

    Datepicker {
        id: datepicker
    }

    FilterDialog {
        id: filterDialog
        onAccepted: {
            // filterData
            if (originalModel.count == 0) {
                for (var i = 0; i < listViewModel.count; i++)
                    originalModel.append(listViewModel.get(i))
            }
            for (i = 0; i< originalModel.count; ++i) {
                var found = true
                var compareObjc = ({})
                var objc = originalModel.get(i)
                for (var p in filterData) {
                    if (objc[p] !== filterData[p]) {
                        found = false
                        break
                    }
                }
                console.log("found: " + found)
                console.log(JSON.stringify(filterData))
                console.log(JSON.stringify(compareObjc))
                if (found) {
                    console.log("found!")
                    buscaModel.append(objc)
                }
            }
            if (!buscaModel.count)
                return
            toolBarState = "cancel"
            listViewModel.clear()
            for (i = 0; i < buscaModel.count; ++i)
                listViewModel.append(buscaModel.get(i))
        }
    }

    Connections {
        target: window
        enabled: isActivePage
        onEventNotify: {
            if (eventName === "filter") {
                console.log("abrir dialogo!")
                filterDialog.open()
            }
            if (eventName === Settings.events.cancel) {
                listViewModel.clear()
                buscaModel.clear()
                for (var i = 0; i < originalModel.count; ++i)
                    listViewModel.append(originalModel.get(i))
            }
        }
    }

    Connections {
        target: requestHttp
        onFinished: {
            if (statusCode != 200)
                return
            objects = response
            console.log("response: ", response)
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
            secondaryLabelText: Qt.formatDateTime(dataRetirada, "dd/MM/yyyy")
            showSeparator: true
            onClicked: showDetail(status,objeto_id.nome,dataRetirada)
        }
    }
}
