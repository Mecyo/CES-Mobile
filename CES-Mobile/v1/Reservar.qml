import QtQuick 2.8
import QtQuick.Window 2.3
import QtQuick.Controls 1.4
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import "AwesomeIcon/"

Page {
    id: page
    title: "Reservar"
    objectName: "Reservar"
    Rectangle {
        id: rectangleTop
        anchors.top: parent.top
        height: 45
        width: parent.width
        color: "#008fb3"
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        z: parent.z + 1

        RowLayout {
            id: rowLayout
            y: 0
            height: parent.height
            anchors.horizontalCenterOffset: 3
            width: parent.width - 10
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                text: "Reservados"
                visible: !rectTextField.visible
                anchors.centerIn: parent
            }

        }
    }

    TableView {
        id: tableView
        x: 0

        frameVisible: false
        sortIndicatorVisible: true

        anchors.top: rectangleTop.bottom
        height: parent.height - rectangleTop.height
        anchors.topMargin: 0
        width: parent.width

        model: listModel1

        rowDelegate: Rectangle {
           height: 30
           SystemPalette {
              id: myPalette;
              colorGroup: SystemPalette.Active
           }
           color: {
              var baseColor = styleData.alternate?myPalette.alternateBase:myPalette.base
              return styleData.selected?myPalette.highlight:baseColor
           }
        }
        TableViewColumn {
            id: itemColumn
            title: "Nome"
            role: "item"
            movable: false
            resizable: false
            width: tableView.viewport.width / 5
        }

        TableViewColumn {
            id: descrColumn
            title: "Data"
            role: "data"
            movable: false
            resizable: false
            width: tableView.viewport.width / 5
        }

        TableViewColumn {
            id: qtdColumn
            title: "Cancelar"
            role: "can"
            movable: false
            resizable: false
            width: tableView.viewport.width / 5
        }

        TableViewColumn {
            id: devolucaoColumn
            title: "Retirar"
            role: "ret"
            movable: false
            resizable: false
            width: tableView.viewport.width / 5
        }


        ListModel {
            id: listModel1
            ListElement {
                item: "Chave";
                data: "20/09/2017";
                can: "X";
                ret: "+";

            }
            ListElement {
                item: "Chave";
                data: "16/09/2017";
                can: "X";
                ret: "+";
            }
            ListElement {
                item: "Multimidia";
                data: "15/09/2017";
                can: "X";
                ret: "+";
            }
        }
    }
    Rectangle {
        id: rectangleTop2
        x: 0
        anchors.top: parent.top
        height: 45
        width: parent.width
        color: "#008fb3"
        anchors.topMargin: 208
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        z: parent.z + 1
        Column {

            Row {
                spacing: 7
                ComboBox {
                    id: comboPesquisa;
                    font.pointSize: 11
                    model: ["Selecione", "Nome", "Devolução","Solicitar"]
                    background: Rectangle {
                                id: rectCombo
                                color: "#FFF";
                                radius: 10
                                implicitWidth: 100;
                                border.color: "#333"
                                border.width: 1
                               }
                }

            }
        }
        RowLayout {
            id: rowLayout2
            y: -1
            height: parent.height
            anchors.horizontalCenterOffset: -5
            width: parent.width - 10
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                text: "Reservar mais"
                visible: !rectTextField.visible
                anchors.centerIn: parent
            }

            AwesomeIcon {
                name: "pencil"
                color: "black"
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
    TableView {
        id: tableView2
        x: 0
        y: 241
        frameVisible: false
        sortIndicatorVisible: true

        anchors.top: rectangleTop2.bottom
        height: parent.height - rectangleTop2.height
        anchors.topMargin: -1
        width: parent.width

        model: listModel2

        rowDelegate: Rectangle {
           height: 30
           SystemPalette {
              id: myPalette2;
              colorGroup: SystemPalette.Active
           }
           color: {
              var baseColor = styleData.alternate?myPalette2.alternateBase:myPalette2.base
              return styleData.selected?myPalette2.highlight:baseColor
           }
        }
        TableViewColumn {
            id: itemColumn2
            title: "Nome"
            role: "nome"
            movable: false
            resizable: false
            width: tableView.viewport.width / 5
        }

        TableViewColumn {
            id: descrColumn2
            title: "Devolução"
            role: "devo"
            movable: false
            resizable: false
            width: tableView.viewport.width / 5
        }

        TableViewColumn {
            id: qtdColumn2
            title: "Solicitar"
            role: "sol"
            movable: false
            resizable: false
            width: tableView.viewport.width / 5
        }


        ListModel {
            id: listModel2
            ListElement {
                nome: "Chave A200";
                devo: "21/09/2017";
                sol: "+";

            }
            ListElement {
                nome: "Chave O2019";
                devo: "22/09/2017";
                sol: "+";
            }
            ListElement {
                nome: "Multimidia LB4";
                devo: "25/09/2017";
                sol: "+";
            }
        }
    }
}
