import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import "AwesomeIcon/"

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
                AwesomeIcon {
                    id: nameIcon
                    size: 30
                    name: iconName
                    color: "#333"
                    clickEnabled: false
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                ColumnLayout {
                    spacing: 0; height: parent.height
                    anchors.centerIn: parent
                }
            }
        }
    }

    ListModel {
        id: listModel
        ListElement { name: "Home"; iconName: "home"}
        ListElement { name: "Retirar"; iconName: "share"}
        ListElement { name: "Reservar"; iconName: "tag"}
        ListElement { name: "Transferência"; iconName: "exchange"}
        ListElement { name: "Histórico"; iconName: "history"}
    }
}
