import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import MyQmlModule 1.0


BasePage {
    id: base
    title: qsTr("Objetos com você")
    objectName: "Home.qml"
    listViewDelegate: pageDelegate
    onRequestUpdatePage: loadOnReadyOrUpdate("Update")
    onRequestHttpReady: loadOnReadyOrUpdate("Ready")

    property var objects
    property int post: 0
    property var selecionado

    function loadOnReadyOrUpdate(called){
        if(window.user !== undefined)
            requestHttp.get("movimentacoes_abertas_usuario/" + window.user.id)
    }

    function showDetail(delegateIndex) {
        pageStack.push("DetalhesObjeto.qml", {"details": objects[delegateIndex]})
    }

    function devolver(delegateIndex) {
    	selecionado = objects[delegateIndex].objeto_id

        requestHttp.post("devolver_objeto/", JSON.stringify(selecionado))
        toast.show(qsTr("Solicitação de devolução efetuada com sucesso!\nAguarde confirmação!"), true, 2900)
        popCountdow.start()
    }
    
    function transferir(delegateIndex) {
        selecionado = objects[delegateIndex]
        pageStack.push("Transference.qml", {"selecionado": selecionado})
    }

    function isTransfer(status) {
        return status === StatusMovimentacaoEnum.SOLICITADO_TRANSFERENCIA
                || status === StatusMovimentacaoEnum.TRANSFERENCIA_PENDENTE
    }

    function getTransfer(delegateIndex) {
        var movimentacao_id = objects[delegateIndex].id
        post = 1
        requestHttp.get("exibir_transferencia_movimentacao/" + movimentacao_id)
    }

    function confirmTransfer(response) {
        post = 2
        var transferencia = ({})
        transferencia.movimentacao_id_origem = response.movimentacao_id_origem.id
        transferencia.movimentacao_id_destino = response.movimentacao_id_destino.id
        requestHttp.post("confirmar_transferir_objeto/", JSON.stringify(transferencia))
    }

    function cancelTransfer(delegateIndex) {
        return status === 6//Generalizar método verificando pelo StatusMovimentacaoEnum
    }

    function getBackgroundColor(status) {
        switch(status)
        {
            case StatusMovimentacaoEnum.SOLICITADO_RETIRADA: return "blue";
            case StatusMovimentacaoEnum.EMPRESTADO: return "white"
            case StatusMovimentacaoEnum.SOLICITADO_DEVOLUCAO: return "orange"
            case StatusMovimentacaoEnum.DEVOLVIDO: return "green"
            case StatusMovimentacaoEnum.SOLICITADO_TRANSFERENCIA: return "red"
            case StatusMovimentacaoEnum.TRANSFERENCIA_PENDENTE: return "red"
            case StatusMovimentacaoEnum.TRANSFERENCIA_CONFIRMADA: return "blue"
            case StatusMovimentacaoEnum.SOLICITADO_RESERVA: return "gray";
            default: return "white";
        }
    }

    function getSecondaryLabel(index){
        if(index >= 0){
            if(objects[index].retirada !== undefined && objects[index].retirada !== null)
                return Qt.formatDateTime(objects[index].retirada, "dd/MM/yyyy HH:mm");
            else if(objects[index].reserva !== undefined && objects[index].reserva !== null)
                return Qt.formatDateTime(objects[index].reserva, "dd/MM/yyyy HH:mm");
        }

        return "";
    }

    Timer {
        id: popCountdow
        interval: 2000; repeat: false
        onTriggered: pageStack.pop()
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
        target: window
        onSwipeChange: requestHttp.get("movimentacoes_abertas_usuario/" + window.user.id)
    }

    Connections {
        target: requestHttp
        onFinished: {
            if (statusCode != 200) {
                post = 0
                return
            }
            if(post === 1) {
                confirmTransfer(response)
                return
            }
            else if(post === 2) {
                toast.show(qsTr("Transferência confirmada com sucesso!"), true, 2900)
                popCountdow.start()
                return
            }
            objects = response
            listViewModel.clear()
            for (var i = 0; i < response.length; ++i)
                listViewModel.append(objects[i])
        }
    }

    function getTertiaryIconName(status) {
        switch(status)
        {
            case StatusMovimentacaoEnum.EMPRESTADO: return "exchange"
            case StatusMovimentacaoEnum.TRANSFERENCIA_PENDENTE: return "times"

            default: return "";
        }
    }

    function getSecondaryIconName(status) {
        switch(status)
        {
            case StatusMovimentacaoEnum.SOLICITADO_RETIRADA: return "times";
            case StatusMovimentacaoEnum.EMPRESTADO: return "reply"
            case StatusMovimentacaoEnum.SOLICITADO_TRANSFERENCIA: return "times"
            case StatusMovimentacaoEnum.TRANSFERENCIA_PENDENTE: return "check"

            default: return "";
        }
    }

    function setOnclickSecondaryIcon(status, index){
        switch(status)
        {
            case StatusMovimentacaoEnum.SOLICITADO_TRANSFERENCIA: return cancelTransfer(index)
            case StatusMovimentacaoEnum.TRANSFERENCIA_PENDENTE: return getTransfer(index)

            default: return devolver(index);
        }
    }

    Component {
        id: pageDelegate

        ListItem {
            id: listItem
            backgroundColor:  getBackgroundColor(status)
            primaryIconName: objeto_id.tipoObjeto_id.icone
            secondaryIconName:  getSecondaryIconName(status)
            secondaryActionIcon.onClicked: setOnclickSecondaryIcon(status, index)
            tertiaryIconName:  getTertiaryIconName(status)
            tertiaryActionIcon.onClicked: isTransfer(status) ? cancelTransfer(index) : transferir(index)
            width: parent.width; height: 60
            primaryLabelText: objeto_id.nome
            secondaryLabelText: getSecondaryLabel(index)
            showSeparator: true
            onClicked: showDetail(index)
        }
    }
}
