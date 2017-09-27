import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

import "./AwesomeIcon/" as AwesomeIcon

Page {
    id: page
    title: "Transferência - (Objeto(s) em sua posse)"
    objectName: "Transferência"

    Rectangle {
        id: rectangleTop
        anchors.top: parent.top
        height: 45
        width: parent.width
        color: "#008fb3"
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        z: parent.z + 1

        RowLayout {
            id: rowLayout
            height: parent.height
            width: parent.width - 10
            anchors.horizontalCenter: parent.horizontalCenter

            AwesomeIcon.AwesomeIcon {
                name: "search"
                color: "black"
                onClicked: rectTextField.visible = !rectTextField.visible
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle {
                id: rectTextField
                visible: false
                height: textField.height
                width: textField.width
                radius: 100
                anchors.verticalCenter: parent.verticalCenter
                TextField {
                    id: textField
                    anchors.fill: parent
                    placeholderText: "Usuário"
                }
            }

            Label {
                visible: !rectTextField.visible
                anchors.centerIn: parent
                text: title
            }

            AwesomeIcon.AwesomeIcon {
                name: "pencil"
                color: "black"
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    ListView {
        id: listView1
        anchors.top: rectangleTop.bottom
        height: parent.height - rectangleTop.height
        width: parent.width
        model: listModel1.listarUsuarios()
        delegate: Component {
            Rectangle {
                width: page.width
                height: 45
                border.color: "black"
                RowLayout {
                    id: rowListView
                    height: parent.height
                    width: parent.width - 10
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label {
                        text: texto
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    AwesomeIcon.AwesomeIcon {
                        name: "exchange"
                        color: "black"
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: pushPage("qrc:/TransferirObjeto.qml", {"objetoNome": texto});
                    }
                }
            }
        }
    }

    ItemModel { id: listModel1 }
}
