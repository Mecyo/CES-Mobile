import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

BasePage {
    title: qsTr(details.nome)
    objectName: "ReservarObjectDetails.qml"
    hasListView: false
    toolBarState: "goback"

    property var details
    property var timeCurrent: hoursTumbler.currentIndex+ ":"+ minutesTumbler.currentIndex

    Component.onCompleted: console.log("details: ", JSON.stringify(details))

    onTimeCurrentChanged: bookTime.text = timeCurrent

    Frame {
        id: frame
        padding: 0
        visible: false
        width: parent.width
        anchors{ horizontalCenter: parent.horizontalCenter; bottom: parent.bottom}
        z: parent.z + 1

        ColumnLayout {
            anchors.centerIn: parent
            width: parent.width
            Row {
                id: row
                width: parent.width

                Tumbler {
                    id: hoursTumbler
                    model: 24
                    delegate: delegateComponent
                    width: parent.width * 0.50
                }

                Tumbler {
                    id: minutesTumbler
                    model: 60
                    delegate: delegateComponent
                    width: parent.width * 0.50
                }
            }
            Button {
                id: amPmTumbler
                text: "Fechar"
                onClicked: frame.visible = false
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: frame.bottom
            }
        }
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

        ColumnLayout {
            spacing: 10
            anchors.centerIn: parent
            width: parent.width * 0.50; height: parent.height * 0.50

            Row {
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.50; height: 50

                Text {
                    id: _dateText
                    text: qsTr("Data solicitada: ")
                    anchors.verticalCenter: parent.verticalCenter
                    font { pointSize: 11; weight: Font.DemiBold }
                }

                TextField {
                    id: bookDate
                    readOnly: true
                    text: "00/00/0000"
                    width: (parent.width * 0.50 + _dateText.implicitWidth)/2
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
                    text: qsTr("Hora solicitada: ")
                    anchors.verticalCenter: parent.verticalCenter
                    font { pointSize: 11; weight: Font.DemiBold }
                }

                TextField {
                    id: bookTime
                    readOnly: true
                    text: timeCurrent
                    width: (parent.width * 0.50 + _dateText.implicitWidth)/2
                    placeholderText: qsTr("tap to select a date")
                    anchors.verticalCenter: parent.verticalCenter
                    onFocusChanged: if (focus) frame.visible = true
                }
            }
        }
    }

    Button {
        id: submitBtn
        text: qsTr("Reservar objeto")
        visible: !frame.visible
        enabled: requestHttp.state !== requestHttp.stateLoading
        anchors { top: detailsRec.bottom; topMargin: 50; horizontalCenter: parent.horizontalCenter }
        onClicked: {
            var data = ({})
            data.objeto_id = details.id
            data.data_reserva = bookDate.text + " " + bookTime.text
            data.usuario_id = Settings.userId

            requestHttp.post("solicitar_reserva/", JSON.stringify(data))
        }
    }
}
