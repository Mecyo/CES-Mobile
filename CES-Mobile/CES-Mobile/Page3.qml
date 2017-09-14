import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

Page {
    title: "page3"
    objectName: "page3"
    Label {
        id: label
        visible: true
        text: "Page3"
        anchors.centerIn: parent
    }
    Button {
        text: "Clique aqui para page4"
        anchors.top: label.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: pushPage("qrc:/Page4.qml");
    }
}
