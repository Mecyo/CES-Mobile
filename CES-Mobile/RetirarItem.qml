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

    function showDetail(delegateIndex) {
        pageStack.push("RetirarItemDetail.qml", {"details":objects[delegateIndex]})
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
            badgeText: index+1
            secondaryIconName: "reply"
            badgeBackgroundColor: (index%2) ? "red" : "yellow"
            width: parent.width; height: 60
            primaryLabelText: nome
            secondaryLabelText: tipoObjeto_id.nome
            showSeparator: true
            onClicked: showDetail(index)
            secondaryActionIcon.onClicked: viewHome()
        }
    }
}
