import QtQml 2.2
import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import Qt.labs.calendar 1.0
import QtGraphicalEffects 1.0

import "Awesome/" as Awesome

Item {
    id: datepicker

    property var dateObject: new Date()
    property string calendarLocale: "pt_BR"
    property int currentDay: dateObject.getDay()
    property int currentMonth: dateObject.getMonth()
    property int currentYear: dateObject.getFullYear()
    property var currentLocale: Qt.locale(calendarLocale)
    property var monthsList: {
        var list = []
        for (var i = 0; i < 12; ++i)
            list.push(currentLocale.standaloneMonthName(i, Locale.ShortFormat))
        return list
    }

    function open() {
        popup.open()
    }

    signal dateSelected(var date)

    Popup {
        id: popup
        modal: true; focus: true
        x: 0; y : -window.header.height
        width: window.width; height: window.height

        Column {
            id: column
            spacing: 25
            anchors.fill: parent

            // years paginator
            RowLayout {
                id: row
                width: popup.width*0.95; Layout.fillWidth: true
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: previousYearRect
                    width: previousYear.implicitWidth * 2.5; height: 40
                    color: mouseAreaPrevious.down ? "#fafafa" : "#fcc"; radius: 4; anchors.left: parent.left

                    Behavior on color {
                        ColorAnimation { duration: 500 }
                    }

                    Awesome.Icon {
                        id: previousYearIcon
                        name: "chevron_left"; opacity: 0.7
                        width: 25; height: width; color: previousYear.color
                        anchors { left: parent.left; verticalCenter: parent.verticalCenter }
                    }

                    Label {
                        id: previousYear
                        color: "#777"
                        text: datepicker.currentYear-1
                        font { pointSize: 12; bold: true }
                        anchors {
                            left: previousYearIcon.right
                            leftMargin: 7
                            verticalCenter: parent.verticalCenter
                        }
                    }

                    ToolTip {
                        id: previousYearTooltip
                        delay: 50
                        timeout: 3000
                        text: qsTr("Previous year")
                    }

                    MouseArea {
                        id: mouseAreaPrevious
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: datepicker.currentYear--
                        onPressAndHold: {
                            previousYearTooltip.open()
                            datepicker.currentYear -= 10
                        }
                    }
                }

                Label {
                    text: datepicker.currentYear
                    color: previousYear.color
                    font { pointSize: 22; bold: true }
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Rectangle {
                    id: nextYearRect
                    color: mouseAreaNext.down ? "#fafafa" : "#fcc"; radius: 4
                    width: nextYear.implicitWidth * 2.5; height: 40
                    anchors.right: parent.right

                    Behavior on color {
                        ColorAnimation { duration: 500 }
                    }

                    Label {
                        id: nextYear
                        text: datepicker.currentYear+1; color: previousYear.color
                        font { pointSize: 12; bold: true }
                        anchors {
                            right: nextYearIcon.left
                            rightMargin: 7
                            verticalCenter: parent.verticalCenter
                        }
                    }

                    Awesome.Icon {
                        id: nextYearIcon
                        name: "chevron_right"; opacity: 0.7
                        width: 25; height: width; color: previousYear.color
                        anchors { right: parent.right; verticalCenter: parent.verticalCenter }
                    }

                    ToolTip {
                        id: nextYearTooltip
                        delay: 50
                        timeout: 3000
                        text: qsTr("Next year")
                    }

                    MouseArea {
                        id: mouseAreaNext
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: datepicker.currentYear++
                        onPressAndHold: {
                            nextYearTooltip.open()
                            datepicker.currentYear += 10
                        }
                    }
                }
            }

            // show months grig
            GridLayout {
                rows: 2; columns: 6
                columnSpacing: 4; rowSpacing: 4
                width: row.width; Layout.fillWidth: true
                anchors { left: parent.left; right: parent.right }

                Repeater {
                    model: datepicker.monthsList

                    Rectangle {
                        color: selected ? "#fcc" : "#fafafa"
                        radius: 1; width: 48; height: 35

                        Behavior on color {
                            ColorAnimation { duration: 500 }
                        }

                        Text {
                            color: parent.selected ? "#556" : "#777"
                            text: modelData; anchors.centerIn: parent
                            font.weight: parent.selected ? Font.DemiBold : Font.Normal
                        }

                        property bool selected: index === datepicker.currentMonth

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                var newIndex = index
                                datepicker.currentMonth = newIndex
                            }
                        }
                    }
                }
            }

            // show a grid with day name
            DayOfWeekRow {
                id: dayListRow
                locale: grid.locale
                width: row.width; Layout.fillWidth: true
                anchors.horizontalCenter: parent.horizontalCenter
                delegate: Text {
                    color: "#444"
                    text: model.shortName
                    font: dayListRow.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            // show a grid with days
            MonthGrid {
                id: grid
                spacing: 10
                locale: datepicker.currentLocale
                width: parent.width; Layout.fillWidth: true
                month: datepicker.currentMonth
                year: datepicker.currentYear
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: innerMouseArea.clicked()
                delegate: Rectangle {
                    color: isSelectedDay ? "#fcc" : "transparent"; radius: 1
                    width: 48; height: 35

                    Behavior on color {
                        ColorAnimation { duration: isSelectedDay ? 150 : 0 }
                    }

                    property bool isSelectedDay: parseInt(textDelegate.text) === currentDay && model.month === grid.month

                    Text {
                        id: textDelegate
                        text: model.day; color: parent.isSelectedDay ? "#556" : "#777"
                        font { bold: parent.isSelectedDay; pointSize: 18 }
                        enabled: model.month === grid.month
                        opacity: enabled ? 1 : 0.3
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.centerIn: parent

                        Behavior on color {
                            ColorAnimation { duration: 50 }
                        }

                        MouseArea {
                            id: innerMouseArea
                            anchors.fill: parent
                            onClicked: {
                                if (textDelegate.enabled)
                                    currentDay = parseInt(textDelegate.text)
                            }
                        }
                    }
                }
            }
        }

        Button {
            text: qsTr("OK")
            anchors {
                bottom: parent.bottom
                bottomMargin: 5
                horizontalCenter: parent.horizontalCenter
            }
            onClicked: {
                var objc = {
                    "day": currentDay,
                    "month": datepicker.currentMonth+1,
                    "year": datepicker.currentYear
                }
                datepicker.dateSelected(objc)
                popup.close()
            }
        }
    }
}
