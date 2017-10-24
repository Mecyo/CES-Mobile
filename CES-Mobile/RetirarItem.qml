import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

BasePage {
    title: qsTr("Retirar Item")
    objectName: "RetirarItem.qml"
    listViewDelegate: pageDelegate
    onRequestUpdatePage: requestHttp.get("objetos_disponiveis_usuario/" + Settings.userId)
    toolBarActions: {
       "toolButton3": {"action":"filter", "icon":"filter"},
       "toolButton4": {"action":"search", "icon":"search"}
    }
    onRequestHttpReady: requestHttp.get("objetos_disponiveis_usuario/" + Settings.userId)

    property var objects
    property int post: 0

    function showDetail(status,nomeObjeto,dataRetirada) {
        pageStack.push("DetalhesObjeto.qml", {"status": status, "nomeObjeto": nomeObjeto, "dataRetirada": dataRetirada})
    }

    function solicitarObjeto(objetoId) {
        var dados = ({})
        dados.objeto_id = objetoId
        dados.usuario_id = Settings.userId
        requestHttp.post("emprestar_objeto/", JSON.stringify(dados))
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
        onTriggered: pageStack.push("Home.qml")
    }

    Connections {
        target: window
        onEventNotify: if (eventName === "filter") filterDialog.open()
    }

    Connections {
        target: requestHttp
        onFinished: {
            console.log("Status ===  " + statusCode)
            if (statusCode != 200)
                return
            if(post) {
                toast.show(qsTr("Você retirou o objeto com sucesso!"), true, 2900)
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
            primaryIconName: objeto_id.tipoObjeto_id.icone
            tertiaryIconName: "reply"
            tertiaryActionIcon.onClicked: solicitarObjeto(id)
            width: parent.width; height: 60
            primaryLabelText: nome
            secondaryLabelText: tipoObjeto_id.nome
            showSeparator: true
        }
    }
}
