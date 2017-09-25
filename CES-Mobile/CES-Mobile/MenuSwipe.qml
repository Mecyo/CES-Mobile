import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import "./AwesomeIcon/" as AwesomeIcon

Page {
    anchors.fill: parent

    property alias tabBarChild: tabBar
    property alias swipeChild: swipe
    property alias swipeChildCurrentItem: swipe.currentItem

    SwipeView {
        id: swipe
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Home {

        }     
        Retirar {

        }
        Reservar {

        }
        Transferencia {

        }
        Historico {

        }

    }


    header: TabBar {
        id: tabBar
        visible: swipe.visible
        currentIndex: swipe.currentIndex
        z: swipe.z

        Repeater {
            model: listModel
            TabButton {
                height: 35
                Rectangle {anchors.fill: parent; color: "transparent"}

                ColumnLayout {
                    spacing: 0; height: parent.height
                    anchors.centerIn: parent

                    Text {
                        text: name
                        font.pixelSize: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }

    ListModel {
        id: listModel
        ListElement { name: "Home"}
        ListElement { name: "Retirar"}
        ListElement { name: "Reservar"}
        ListElement { name: "Transferência"}
        ListElement { name: "Histórico"}
    }
}
