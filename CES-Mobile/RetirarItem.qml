import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

BasePage {
    title: qsTr("RetirarItem")
    objectName: "RetirarItem.qml"
    listViewDelegate: pageDelegate
    onRequestUpdatePage: requestHttp.get("objetos_disponiveis/")
    toolBarActions: {
       "toolButton3": {"action":"filter", "icon":"filter"},
       "toolButton4": {"action":"search", "icon":"search"}
    }
    onRequestHttpReady: requestHttp.get("objetos_disponiveis/")

    property var objects
    property int post: 0

    function showDetail(status,nomeObjeto,dataRetirada) {
        pageStack.push("DetalhesObjeto.qml", {"status": status, "nomeObjeto": nomeObjeto, "dataRetirada": dataRetirada})
    }

    function solicitarObjeto(objetoId) {
        var dados = ({})
        dados.objeto_id = objetoId
        dados.usuario_id = 2
        requestHttp.post("emprestar_objeto/", JSON.stringify(dados))
        post = 1
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
            if(post)
                toast.show(qsTr("Você retirou o objeto com sucesso!"), true, 2900)
            objects = response
            for (var i = 0; i < response.length; ++i)
                listViewModel.append(objects[i])
        }
    }

    Component {
        id: pageDelegate

        ListItem {
            badgeText: index+1
            secondaryIconName: "reply"
            badgeBackgroundColor: (index%2) ? "red" : "yellow"
            width: parent.width; height: 60
            primaryLabelText: nome
            secondaryLabelText: tipoObjeto_id.nome
            showSeparator: true
            secondaryActionIcon.onClicked: solicitarObjeto(id)
            onClicked: showDetail(status,nome)
        }
    }
}
