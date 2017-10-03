import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

BasePage {
    title: qsTr("Mostrando detalhes do objeto")
    objectName: "HistoricObjectDetails.qml"
    hasListView: false
    toolBarState: "goback"

    property var details
    property var currentDate: new Date()

    Component.onCompleted: console.log("details: ", JSON.stringify(details))

    TimePicker {
        id: _timePicker
    }

    Datepicker {
        id: _datepicker
        onDateSelected: bookDate.text = "%1/%2/%3".arg(date.day).arg(date.month).arg(date.year)
    }

    Connections {
        target: requestHttp
        onFinished: {
            if (statusCode != 200) {
                return
            } else {
                toast.show(qsTr("Você reservou o objeto com sucesso!"), true, 2900)
                popCountdow.start()
            }
        }
    }

    Timer {
        id: popCountdow
        interval: 3000; repeat: false
        onTriggered: pageStack.pop()
    }

    Rectangle {
        id: detailsRec
        width: parent.width * 0.90; height: width*0.5
        radius: width
        color: "transparent"
        anchors { top: parent.top; topMargin: 10; horizontalCenter: parent.horizontalCenter }

        Column {
            spacing: 10
            anchors.centerIn: parent
            width: parent.width; height: parent.height

            Text {
                text: qsTr("Book the object")
                anchors.horizontalCenter: parent.horizontalCenter
                font { pointSize: 16; weight: Font.DemiBold }
            }

            Text {
                text: details.nome
                anchors.horizontalCenter: parent.horizontalCenter
                font { pointSize: 11; weight: Font.DemiBold }
            }

            Row {
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.60; height: 50

                Text {
                    id: _dateText
                    text: qsTr("Date: ")
                    anchors.verticalCenter: parent.verticalCenter
                    font { pointSize: 11; weight: Font.DemiBold }
                }

                TextField {
                    id: bookDate
                    readOnly: true
                    text: "%1/%2/%3".arg(currentDate.getDay()).arg(currentDate.getMonth()).arg(currentDate.getFullYear())
                    width: (parent.width + _dateText.implicitWidth)/2
                    placeholderText: qsTr("Aperte para selecionar uma data")
                    anchors.verticalCenter: parent.verticalCenter
                    onFocusChanged: if (focus) _datepicker.open()
                }
            }

            Row {
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.60; height: 50

                Text {
                    id: _timeText
                    text: qsTr("Time: ")
                    anchors.verticalCenter: parent.verticalCenter
                    font { pointSize: 11; weight: Font.DemiBold }
                }

                TextField {
                    id: bookTime
                    readOnly: true
                    text: new Date().toTimeString()
                    width: (parent.width + _dateText.implicitWidth)/2
                    placeholderText: qsTr("tap to select a date")
                    anchors.verticalCenter: parent.verticalCenter
                    onFocusChanged: if (focus) _timePicker.open()
                }
            }
        }
    }

    Button {
        id: submitBtn
        text: qsTr("Reservar novamente?")
        enabled: requestHttp.state !== requestHttp.stateLoading
        anchors { top: detailsRec.bottom; topMargin: 50; horizontalCenter: parent.horizontalCenter }
        onClicked: {
            var data = ({})
            data.usuario_id = window.user.profile.id
            data.objeto_id = details.id
            requestHttp.post("emprestar_objeto/", JSON.stringify(data))
        }
    }
}
