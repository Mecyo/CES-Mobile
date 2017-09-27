import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3

import "./AwesomeIcon/"

Page {
    id: page
    title: "Transferir Objeto" + " - " + "(" + objetoNome +")"
    objectName: "page4"
    property string objetoNome: ""

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

            TextField {
                id: rectTextField
                width: 100
                height: 24
                anchors.verticalCenter: parent.verticalCenter
                placeholderText: "Pesquisar..."
                padding: 0
                bottomPadding: 8
                leftPadding: 18
                topPadding: 8
                font.pointSize: 11
                horizontalAlignment: Text.AlignLeft
                background: Rectangle {
                    color: "#FFF";
                    radius: 10
                    implicitWidth: 100;
                    border.color: "#333"
                    border.width: 1
                    AwesomeIcon {
                        id: iconSearch
                        size: 11
                        color: "#333"
                        name: "search"; y: 0; width: 18; height: 24; clickEnabled: true
                        anchors{left: parent.left; verticalCenter: parent.verticalCenter}
                        onClicked: {
                            if(comboPesquisa.currentText == "Selecione" && txtPesquisa.text) {
                                dialog.setText("Pesquisando por: " + txtPesquisa.text);
                                dialog.open();
                            } else {
                                dialog.setText("Pesquisando por: " + comboPesquisa.currentText);
                                dialog.open();
                            }
                        }
                    }
                }
            }

            Label {
                anchors.centerIn: parent
                text: title
            }

            AwesomeIcon {
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
        model: listModel1.listarRetirados("userName")
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
                        text: nome
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    AwesomeIcon {
                        name: "exchange"
                        color: "black"
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }

    ItemModel { id: listModel1 }
}
