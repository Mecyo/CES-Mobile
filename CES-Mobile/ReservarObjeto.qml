import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

BasePage {
    title: qsTr("Todos os objetos")
    objectName: "ReservarObjeto.qml"
    listViewDelegate: pageDelegate
    onRequestUpdatePage: requestHttp.get("exibir_objetos/" + Settings.userId)
    toolBarActions: {
       "toolButton3": {"action":"filter", "icon":"filter"},
       "toolButton4": {"action":"search", "icon":"search"}
    }
    onRequestHttpReady: requestHttp.get("exibir_objetos/" + Settings.userId)

    property var objects
    property int post: 0
    property var dados: {"tipo": 2,"usuario_id": Settings.userId}


    function confirmar(idOrigem, idDestino) {
        var dados = ({})
        dados.movimentacao_origem = idOrigem
        dados.movimentacao_destino = idDestino

        requestHttp.post("solicitar_reserva/", JSON.stringify(dados))
        post = 1
    }

    function showDetail(delegateIndex) {
        pageStack.push("ReservarObjectDetails.qml", {"details":objects[delegateIndex]})
    }

    function viewHome() {
        pageStack.push("Home.qml")
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
            if (statusCode != 200) {
                post = 0
                return
            }
            if(post === 1) {
                toast.show(qsTr("Você confirmou a transferência!"), true, 2900)
                popCountdow.start()
            }
            else if(post === 2) {
                toast.show(qsTr("Você cancelou a transferência!"), true, 2900)
                popCountdow.start()
            }
            objects = response
            for (var i = 0; i < response.length; ++i)
                listViewModel.append(objects[i])
        }
    }

    Component {
        id: pageDelegate

        ListItem {
            primaryIconName: tipoObjeto_id.icone
            width: parent.width; height: 60
            primaryLabelText: nome
            secondaryLabelText: tipoObjeto_id.nome
            showSeparator: true
            onClicked: showDetail(index)
            secondaryActionIcon.onClicked: viewHome()
            //secondaryActionIcon.onClicked: confirmar(movimentacao_id_origem.id, movimentacao_id_destino.id)
        }
    }
}
