import QtQuick 2.9
import QtQuick.Controls 2.2

import "AwesomeIcon/"

Component {
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
