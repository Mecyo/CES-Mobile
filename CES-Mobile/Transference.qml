import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

BasePage {
    title: qsTr("Transfer a object")
    objectName: "Transference.qml"
    listViewDelegate: pageDelegate
    onRequestUpdatePage: requestHttp.get("exibir_usuarios/")
    toolBarActions: {
       "toolButton3": {"action":"filter", "icon":"filter"},
       "toolButton4": {"action":"search", "icon":"search"}
    }
    onRequestHttpReady: requestHttp.get("exibir_usuarios/")

    property var objects

//    function showDetail(delegateIndex) {
//        pageStack.push("ShowObjectDetails.qml", {"details":objects[delegateIndex]})
//    }

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
            console.log("Número de itens ===  " + statusCode)
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
            secondaryIconName: "exchange"
            badgeBackgroundColor: (index%2) ? "red" : "yellow"
            width: parent.width; height: 60
            primaryLabelText: nome
            secondaryLabelText: email
            showSeparator: true
            //onClicked: showDetail(index)
        }
    }
}
