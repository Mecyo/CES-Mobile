import QtQuick 2.8
import QtQuick.Controls 2.1

import "AwesomeIcon/"

Component {

    /*Rectangle {
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
}*/

    Item {
        Rectangle {
            id: delCol1
            width: page.width / 4
            height: 20
            clip: false
            border.color: "#000"
            border.width: 1
            Label {
                id: lblNome
                text: nome
            }
            AwesomeIcon {
                name: iconName
                color: "black"
                anchors.leftMargin: 5
                size: 13
                anchors.left: lblNome.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: delCol2
            width: page.width / 4
            anchors.left: delCol1.right
            height: 20
            border.color: "#000"
            border.width: 1
            Label {
                id: lblRetirada
                text: dataRetirada
            }

        }
        Rectangle {
            id: delCol3
            width: page.width / 4
            anchors.left: delCol2.right
            height: 20
            border.color: "#000"
            border.width: 1
            AwesomeIcon {
                name: "reply";
                color: "#333"
                size: 13
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    dialog.setText("Devolvendo ítem: " + nome);
                    dialog.open();
                }
            }

        }
        Rectangle {
            id: delCol4
            width: page.width / 4
            anchors.top: lblComVc.bottom;
            anchors.left: delCol3.right
            height: 20
            border.color: "#000"
            border.width: 1
            AwesomeIcon {
                name: "retweet";
                color: "#333"
                size: 13
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    dialog.setText("Transferindo ítem: " + nome);
                    dialog.open();
                }
            }
        }
    }
}
