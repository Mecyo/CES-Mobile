import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

BasePage {
    title: qsTr("Transferências")
    objectName: "TransferenciasAtivas.qml"
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
        post = 2
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
        onTriggered: pageStack.replace(Qt.resolvedUrl("Home.qml"))

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

            objects = response
            console.log(JSON.stringify(objects))
            for (var i = 0; i < response.length; ++i) {
                if(objects[i].movimentacao_id_destino.status === 6)
                    listViewModel.append(objects[i])
            }
        }
    }

    Component {
        id: pageDelegate

        ListItem {
            primaryIconName: movimentacao_id_destino.objeto_id.tipoObjeto_id.icone
            tertiaryIconName: "check"
            tertiaryActionIcon.onClicked: confirmar(movimentacao_id_origem.id, movimentacao_id_destino.id)
            secondaryIconName: "times"
            secondaryActionIcon.onClicked: cancelar(id)
            badgeBackgroundColor: "white"
            width: parent.width; height: 60
            primaryLabelText: movimentacao_id_origem.objeto_id.nome
            secondaryLabelText: movimentacao_id_origem.usuario_id.name
            showSeparator: true
        }
    }
}
