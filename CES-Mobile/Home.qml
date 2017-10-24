import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0


BasePage {
    title: qsTr("Objetos com você")
    objectName: "Home.qml"
    listViewDelegate: pageDelegate
    onRequestUpdatePage: requestHttp.get("movimentacoes_abertas_usuario/" + window.user.id)
    toolBarActions: {
       "toolButton3": {"action":"filter", "icon":"filter"},
       "toolButton4": {"action":"search", "icon":"search"}
    }
    onRequestHttpReady: requestHttp.get("movimentacoes_abertas_usuario/" + window.user.id)

    property var objects
    property var selecionado

    function showDetail(status,nomeObjeto,dataRetirada) {
        pageStack.push("DetalhesObjeto.qml", {"status": status, "nomeObjeto": nomeObjeto, "dataRetirada": dataRetirada})
    }

    function devolver(delegateIndex) {
    	selecionado = objects[delegateIndex].objeto_id

        requestHttp.post("devolver_objeto/", JSON.stringify(selecionado))
        toast.show(qsTr("Solicitação de devolução efetuada com sucesso!\nAguarde confirmação!"), true, 2900)
        popCountdow.start()
    }
    
    function transferir(delegateIndex) {
    	selecionado = objects[delegateIndex].objeto_id
        pageStack.push("Transference.qml", {"selecionado":selecionado})
    }

    function isTransfer(status) {
        return status === 6
    }

    function confirmTransfer(delegateIndex) {
        //confirmar_transferir_objeto/
        id = objects[delegateIndex].id
    }

    function cancelTransfer(delegateIndex) {
        return status === 6
    }

    Row {
        Label {
            id: labelUserName
            text: "Objetos com você, " + window.user.perfilUsuario_id.nome + " " + window.user.name
        }
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
            backgroundColor:  isTransfer(status) ? "red" : "white"
            primaryIconName: objeto_id.tipoObjeto_id.icone
            secondaryIconName:  isTransfer(status) ? "check" : "reply"
            secondaryActionIcon.onClicked: isTransfer(status) ? confirmTransfer(index) : devolver(index)
            tertiaryIconName:  isTransfer(status) ? "times" : "exchange"
            tertiaryActionIcon.onClicked: isTransfer(status) ? cancelTransfer(index) : transferir(index)
            width: parent.width; height: 60
            primaryLabelText: objeto_id.nome
            secondaryLabel.font.pointSize: 9
            secondaryLabelText: isTransfer(status) ? Qt.formatDateTime(retirada, "dd/MM/yyyy HH:MM") +  "\nTRANSFERÊNCIA-PENDENTE" : Qt.formatDateTime(retirada, "dd/MM/yyyy HH:MM")
            showSeparator: true
            onClicked: showDetail(status,objeto_id.nome,retirada)
        }
    }
}
