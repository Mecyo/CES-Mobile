import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

BasePage {
    title: qsTr("Detalhes do objeto")
    objectName: "DetalhesObjeto.qml"
    hasListView: false
    toolBarState: "goback"

    property int status
    property string nomeObjeto
    property string dataRetirada
    property var dados: ({"tipo": 2,"usuario_id": Settings.userId})

    function statusName() {
        switch(status) {
            case 1: return "Solicitado retirada"
            case 2: return "Emprestado"
            case 3: return "Solicitado Devolução"
            case 4: return "Devolvido"
            case 5: return "Solicitado Transferência"
            case 6: return "Transferencia pendente"
            case 7: return "Transferência confirmada"
            case 8: return "Reservado"
        }
    }


    Connections {
        target: requestHttp
        onFinished: {
            if (statusCode != 200) {
                return
            } else {
                toast.show(qsTr("Você reservou o objeto com sucesso!"), true, 2900)
                popCountdow.start()
            }
        }
    }

    Timer {
        id: popCountdow
        interval: 2000; repeat: false
        onTriggered: pageStack.pop()
    }

    Rectangle {
        id: detailsRec
        width: parent.width * 0.90; height: parent.height / 2
        radius: width
        color: "transparent"
        anchors { top: parent.top; topMargin: 10; horizontalCenter: parent.horizontalCenter }

        Column {
            spacing: 10
            anchors.centerIn: parent
            width: parent.width; height: parent.height

            Text {
                text: qsTr("Informações do objeto")
                anchors.horizontalCenter: parent.horizontalCenter
                font { pointSize: 16; weight: Font.DemiBold }
            }

            Text {
                text: nomeObjeto
                anchors.horizontalCenter: parent.horizontalCenter
                font { pointSize: 9; weight: Font.DemiBold }
            }

            Text {
                text: dataRetirada
                visible: status != 1
                anchors.horizontalCenter: parent.horizontalCenter
                font { pointSize: 9; weight: Font.DemiBold }
            }

            Text {
                text: statusName()
                anchors.horizontalCenter: parent.horizontalCenter
                font { pointSize: 9; weight: Font.DemiBold }
            }
        }
    }

//    Button {
//        id: submitBtn
//        text: qsTr("Confirmar Transferência")
//        enabled: requestHttp.state !== requestHttp.stateLoading
//        visible: status === 6
//        anchors { top: detailsRec.bottom; topMargin: 50; horizontalCenter: parent.horizontalCenter }
//        onClicked: {
////            var data = ({})
////            requestHttp.post("confirmar_transferir_objeto/", JSON.stringify(data))
//        }
//    }
}
