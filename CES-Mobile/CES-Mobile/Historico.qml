import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3

import "AwesomeIcon/"


Page {
    id: page
    title: "Histórico"
    objectName: "Histórico"
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
        model: listModel1
        delegate:
            Rectangle {
            width: page.width; height: 55; implicitHeight: height
            border.color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
            Row {
                id: rowListView
                height: 45
                width: page.width
                spacing: 5
                Item{width: 10; height: 45}
                Label {
                    text: item
                    width: page.width * 0.20
                    height: 45
                    elide: Text.ElideRight
                    font.pixelSize: 13
                    maximumLineCount: 1
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAnywhere
                }
                Label {
                    text: desc
                    width: page.width * 0.50
                    height: 45
                    elide: Text.ElideRight
                    maximumLineCount: 3
                    wrapMode: Text.WrapAnywhere
                    verticalAlignment: Text.AlignVCenter
                }
                Label {
                    text: qtd
                    width: page.width * 0.05
                    height: 45
                    elide: Text.ElideRight
                    maximumLineCount: 1
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAnywhere
                }
                AwesomeIcon {
                    width: page.width * 0.05
                    name: devolucao
                    anchors.verticalCenter: parent.verticalCenter
                }
                Label {
                    text: pedido
                    width: page.width * 0.15
                    height: 45
                    elide: Text.ElideRight
                    maximumLineCount: 1
                    wrapMode: Text.WrapAnywhere
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }

    ListModel {
        id: listModel1
        ListElement { item: "Chave1"; desc: "Chave do lab 5"; qtd: "1"; devolucao: "check_square" ;pedido:"27/09/2017"}
        ListElement { item: "Retroprojetor1"; desc: "Chaves dos labs 1 a 4 "; qtd: "4"; devolucao: "check_square" ;pedido:"27/09/2017"}
    }
}