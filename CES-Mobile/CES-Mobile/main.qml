import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Controle de Entrada e Saída")

    TabView {
        id: tabView
        currentIndex: swipeView.currentIndex
        anchors.fill: parent

        style: HomeTabViewStyle{}

        IconTab {
            //title: "Tab #1"
            icon: "home.png"
        }
        IconTab{
            //title: "Tab #3"
            icon: "file-find.png"
        }

    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabView.currentIndex

        Page1 {
        }

        Page {
            Label {
                text: qsTr("Second page")
                anchors.centerIn: parent
            }
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Tela 1")
        }
        TabButton {
            text: qsTr("Tela 2")
        }
    }
}
