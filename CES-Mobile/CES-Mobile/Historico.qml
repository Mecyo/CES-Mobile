import QtQuick 2.8
import QtQuick.Window 2.3
import QtQuick.Controls 1.4
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import SortFilterProxyModel 0.1
import "AwesomeIcon/"


Page {
    id: page
    title: "Histórico"
    objectName: "Histórico"
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
            height: parent.height
            width: parent.width - 10
            anchors.horizontalCenter: parent.horizontalCenter

            AwesomeIcon {
                name: "search"
                color: "black"
                onClicked: rectTextField.visible = !rectTextField.visible
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle {
                id: rectTextField
                visible: false
                height: textField.height
                width: textField.width
                radius: 100
                anchors.verticalCenter: parent.verticalCenter
                TextField {
                    id: textField
                    anchors.fill: parent
                    placeholderText: "Usuário"
                }
            }

            Label {
                visible: !rectTextField.visible
                anchors.centerIn: parent
                text: title
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
        id: tableView

        frameVisible: false
        sortIndicatorVisible: true

        anchors.top: rectangleTop.bottom
        height: parent.height - rectangleTop.height
        width: parent.width

        model: SortFilterProxyModel {
            id: proxyModel
            source: listModel1.count > 0 ? listModel1 : null

            sortOrder: tableView.sortIndicatorOrder
            sortCaseSensitivity: Qt.CaseInsensitive
            sortRole: listModel1.count > 0 ? tableView.getColumn(tableView.sortIndicatorColumn).role : ""

            filterString: "*" + searchBox.text + "*"
            filterSyntax: SortFilterProxyModel.Wildcard
            filterCaseSensitivity: Qt.CaseInsensitive
        }

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
            title: "Item"
            role: "item"
            movable: false
            resizable: false
            width: tableView.viewport.width - itemColumn.width
        }

        TableViewColumn {
            id: descrColumn
            title: "Descrição"
            role: "descr"
            movable: false
            resizable: false
            width: tableView.viewport.width / 5
        }

        TableViewColumn {
            id: qtdColumn
            title: "Quantidade"
            role: "qtd"
            movable: false
            resizable: false
            width: tableView.viewport.width / 5
        }

        TableViewColumn {
            id: devolucaoColumn
            title: "Devolvido"
            role: "devolucao"
            movable: false
            resizable: false
            width: tableView.viewport.width / 5
        }

        TableViewColumn {
            id: dataColumn
            title: "Data"
            role: "dataPedido"
            movable: false
            resizable: false
            width: tableView.viewport.width / 5
        }

        ListModel {
            id: listModel1
            ListElement {
                item: "Chave";
                descr: "Chave do LAB5";
                qtd: "1";
                devolucao: "Sim";
                dataPedido: "26/09/2017"
            }
            ListElement {
                item: "Projetor";
                descr: "AudioVisual";
                qtd: "7";
                devolucao: "Não";
                dataPedido: "26/09/2017"
            }

        }
    }
}
