import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

Page {
    title: "page2"
    objectName: "page2"
    Label {
        id: label
        visible: true
        text: "Page2"
        anchors.centerIn: parent
    }
    Button {
        text: "Clique aqui para page3"
        anchors.top: label.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: pushPage("qrc:/Page3.qml");
    }
}
