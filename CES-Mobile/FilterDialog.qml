import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtGraphicalEffects 1.0

Popup {
    id: _dialog
    x: Math.round((window.width - width) / 2)
    y: Math.round(window.height * 0.01)
    width: Math.round(Math.min(window.width, window.height) / 3 * 2.5)
    height: (window.height/4) + content.implicitHeight * 1.2
    modal: true; focus: true
    background: Rectangle {
        id: rect
        color: "#fff"; radius: 4
        width: _dialog.width; height: _dialog.height

        RectangularGlow {
            z: -1; color: "#444"
            anchors.fill: rect
            cached: true
            glowRadius: 4; spread: 0.0; cornerRadius: 4
        }
    }

    property alias title: _title.text
    property int currentField: 0

    function searchByText(text, list) {
        for(var i = 0; i < list.length; ++i)
        {
            if(list[i].nome === text)
                return list[i].id
        }
    }

    function getFilterData() {
        return {
            "objeto_id": { "tipoObjeto_id": searchByText(objectType.currentText, window.objectTypes),
                           "status": searchByText(objectStatus.currentText, window.objectStatus),
                           "nome": search.text
            }
        }
    }

    Timer {
        id: asyncNotify
        interval: 250; running: false
        onTriggered: accepted(getFilterData())
    }

    signal accepted(var filterData)
    signal rejected()

    Connections {
        target: datepicker
        onDateSelected: {
            var dateText = "%1Teste/%2/%3".arg(date.day).arg(date.month).arg(date.year)
            if (currentField == 1)
                startDateField.text = dateText
            else if (currentField == 2)
                endDateField.text = dateText
        }
    }

    Label {
        id: _title
        width: parent.width
        text: qsTr("Advanced filter")
        font { pointSize: 20; bold: true }
        wrapMode: Label.WordWrap
        horizontalAlignment: Label.AlignLeft
        verticalAlignment: Label.AlignTop
    }

    Column {
        id: content
        spacing: 25
        width: parent.width
        anchors { top: _title.bottom; topMargin: 25 }

        Column {
            spacing: 4
            width: parent.width; height: 50
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                text: qsTr("Filter by object type:")
            }

            ComboBox {
                id: objectType
                width: parent.width
                model: {
                    var show = []
                    for(var i = 0; i < window.objectTypes.length; ++i)
                        show.push(window.objectTypes[i].nome)
                    return show
                }
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Column {
            spacing: 4
            width: parent.width; height: 50
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                text: qsTr("Filter by object status:")
            }

            ComboBox {
                id: objectStatus
                width: parent.width
                model: {
                    var show = []
                    for(var i = 0; i < window.objectStatus.length; ++i)
                        show.push(window.objectStatus[i].status)
                    return show
                }

                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Item { width: parent.width; height: 3 }

        TextField {
            id: search
            width: parent.width; height: 30
            placeholderText: qsTr("Tap to search")
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Column {
            spacing: 0
            width: parent.width; height: 50
            anchors.horizontalCenter: parent.horizontalCenter

            Row {
                spacing: 10
                width: parent.width; height: 50

                Label {
                    text: qsTr("Data reserva:")
                    anchors.verticalCenter:  parent.verticalCenter
                }

                TextField {
                    id: dateField
                    readOnly: true
                    width: parent.width * 0.70
                    onFocusChanged: {
                        if (focus) {
                            currentField = 1
                            datepicker.open()
                        }
                    }
                }
            }
        }
    }

    // dialog buttons
    Row {
        spacing: 10
        anchors { bottom: parent.bottom; bottomMargin: -5; right: parent.right; rightMargin: 5 }

        Button {
            text: qsTr("CANCEL")
            font.bold: true
            highlighted: false
            Material.elevation: 0
            Material.foreground: Material.BlueGrey
            onClicked: {
                _dialog.close()
                rejected()
            }
        }

        Button {
            text: qsTr("FILTER")
            font.bold: true
            highlighted: false
            Material.elevation: 0
            Material.foreground: Material.BlueGrey
            onClicked: {
                _dialog.close()
                asyncNotify.start()
            }
        }
    }
}
