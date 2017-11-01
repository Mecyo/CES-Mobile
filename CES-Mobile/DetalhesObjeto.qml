import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

BasePage {
    id: page
    title: qsTr("Detalhes do objeto")
    objectName: "DetalhesObjeto.qml"
    hasListView: false
    toolBarState: "goback"

    property var details
    property var dados: ({"tipo": 2,"usuario_id": Settings.userId})

    function statusName(status) {
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
                toast.show(qsTr("Você devolveu o objeto com sucesso!"), true, 2900)
                popCountdown.start()
            }
        }
    }

    Timer {
        id: popCountdown
        interval: 2000; repeat: false
        onTriggered: pageStack.push(Qt.resolvedUrl("Home.qml"))
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: Math.max(column.implicitHeight + 50, height)

        ColumnLayout {
            id: column
            spacing: 0
            width: page.width
            anchors { top: parent.top; horizontalCenter: parent.horizontalCenter }

            ListItem {
                showSeparator: true
                primaryLabelText: qsTr("Nome do Objeto")
                secondaryLabelText: details.objeto_id.nome
                primaryIconName: "cog"
            }

            ListItem {
                showSeparator: true
                primaryLabelText: qsTr("Responsável")
                secondaryLabelText: /*details.usuario_id.perfilUsuario_id.nome*/ details.usuario_id.profileName.nome + " " + details.usuario_id.name
                primaryIconName: "user"
            }

            ListItem {
                showSeparator: true
                primaryLabelText: qsTr("Data de Retirada")
                secondaryLabelText: Qt.formatDateTime(details.retirada, "dd/MM/yyyy HH:mm")
                primaryIconName: "calendar"
                visible: details.retirada !== null ? true : false
            }

            ListItem {
                showSeparator: true
                primaryLabelText: qsTr("Data de Reserva")
                secondaryLabelText: Qt.formatDateTime(details.reserva, "dd/MM/yyyy HH:mm")
                primaryIconName: "calendar"
                visible: details.reserva !== null ? true : false
            }

            ListItem {
                showSeparator: true
                primaryLabelText: qsTr("Status")
                secondaryLabelText: statusName(details.status)
                primaryIconName: "bookmark"
            }

            Button {
                id: devolverButton
                text: qsTr("Devolver Objeto")
                enabled: requestHttp.state !== requestHttp.stateLoading
                visible: details.status === 2 && 7
                anchors {horizontalCenter: parent.horizontalCenter }
                onClicked: {
                    var dados = ({})
                    dados.movimentacao_id = details.id
                    requestHttp.post("devolver_objeto/", JSON.stringify(dados))
                }
            }

        }
    }
}
