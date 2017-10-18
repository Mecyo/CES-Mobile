import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

BasePage {
    title: qsTr("Transferência")
    objectName: "Transference.qml"
    listViewDelegate: pageDelegate
    onRequestUpdatePage: requestHttp.post("listar_transferencias_usuario/", JSON.stringify(dados))
    toolBarActions: {
       "toolButton3": {"action":"filter", "icon":"filter"},
       "toolButton4": {"action":"search", "icon":"search"}
    }
    onRequestHttpReady: requestHttp.post("listar_transferencias_usuario/", JSON.stringify(dados))

    property var objects
    property int objetoId
    property int movimentacaoId
    property int post: 0
    property var dados: {"tipo": 2,"usuario_id": Settings.userId}


    function confirmar(idOrigem, idDestino) {
        var dados = ({})
        dados.movimentacao_origem = idOrigem
        dados.movimentacao_destino = idDestino

        requestHttp.post("confirmar_transferir_objeto/", JSON.stringify(dados))
        post = 1
    }
    function cancelar(id) {
        var dados = ({})
        dados.transferencia_id = id

        requestHttp.post("cancelar_transferir_objeto/", JSON.stringify(dados))
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
        interval: 2000; repeat: false
        onTriggered: pageStack.pop()
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
            if(post === 1) {
                toast.show(qsTr("Você confirmou a transferência!"), true, 2900)
                popCountdow.start()
            }
            else if(post === 2) {
                toast.show(qsTr("Você cancelou a transferência!"), true, 2900)
                popCountdow.start()
            }

            console.log(response)
            objects = response
            for (var i = 0; i < response.length; ++i)
                listViewModel.append(objects[i])
        }
    }

    Component {
        id: pageDelegate

        ListItem {
//            badgeText: index+1
            secondaryIconName: "thumbs-up"
            secondaryActionIcon.onClicked: confirmar(movimentacao_id_origem.id, movimentacao_id_destino.id)
            tertiaryIconName: "thumbs-down"
            tertiaryActionIcon.onClicked: cancelar(id)
            badgeBackgroundColor: "white"
            width: parent.width; height: 60
            primaryLabelText: movimentacao_id_origem.usuario_id.name
            secondaryLabelText: movimentacao_id_origem.objeto_id.nome
            showSeparator: true
        }
    }
}
