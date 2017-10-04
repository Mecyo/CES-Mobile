import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Window 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3

import "AwesomeIcon/"

Page {
    id:page
    title: "Retirar"
    objectName: "Retirar"


    Rectangle {
         id: quadpesq;
         width: parent.width;
         height: 48
         color: "#008fb3";
         anchors.top: parent.top
         Column {

             anchors{fill:parent;margins: 16}
             Row {
                 id: row
                 width: 100
                 height: 24
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.top: parent.top
                 anchors.right: parent.right
                 anchors.left: parent.left
                 spacing: 7

                 TextField {
                     id: txtPesquisa;
                     width: 100
                     height: 24
                     text: ""
                     anchors.verticalCenter: parent.verticalCenter
                     placeholderText: "Pesquisar..."
                     padding: 0
                     bottomPadding: 0
                     leftPadding: 18
                     topPadding: 13
                     font.pointSize: 11
                     horizontalAlignment: Text.AlignLeft
                     background:
                         Rectangle {
                             color: "#FFF";
                             radius: 10
                             implicitWidth: 100;
                             border.color: "#333"
                             border.width: 1
                             AwesomeIcon {
                                 id: iconSearch
                                 size: 11
                                 color: "#333"
                                 name: "search"; y: 0; width: 18; height: 24; clickEnabled: true
                                 anchors{left: parent.left; centerIn: parent.Center}
                                 onClicked: {
                                     if(comboPesquisa.currentText == "Selecione" && txtPesquisa.text) {
                                         dialog.setText("Pesquisando por: " + txtPesquisa.text);
                                         dialog.open();
                                     } else {
                                         dialog.setText("Pesquisando por: " + comboPesquisa.currentText);
                                         dialog.open();
                                     }
                                 }
                             }
                        }
                 }

             }
         }

         Column {
             anchors{centerIn: parent;margins: 16}
             Row {
                 spacing: 7
                 ComboBox {
                     id: comboPesquisa;
                     font.pointSize: 11
                     model: ["Selecione", "Objeto", "Status"]
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

         Column {
             anchors{right: parent.right; margins: 16}
             spacing: 5
             Rectangle {
                 color: "#FFF";
                 radius: 10
                 implicitWidth: 100;
                 border.color: "#333"
                 border.width: 2
                 AwesomeIcon {
                     id: iconEdit
                     size: parent.height / 2
                     color: "#333"
                     anchors.leftMargin: -22
                     name: "pencil"; y: 0; width: 27; height: 43; clickEnabled: true
                     anchors{left: parent.left; centerIn: parent.Center}
                     onClicked: {
                         dialog.informativeText = "Editando!!"
                         dialog.open();
                     }
                }
             }
         }
     }

    Rectangle
    {
        id:retanguloTopoListViewReservados
        anchors.top: quadpesq.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        height: 48
        RowLayout {
            id: rowLayout2
            height: parent.height
            anchors.horizontalCenterOffset: 0
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                text: "Itens Reservados"
                visible: true
                anchors.centerIn: parent.Center
            }

        }
    }

    ListView {
        id: listaElementosReservados
        anchors.top: retanguloTopoListViewReservados.bottom
        height: parent.height - retanguloTopoListViewReservados.height + quadpesq.height
        width: parent.width
        model: listModel1
        delegate:
            Rectangle {
            width: page.width; height: 55; implicitHeight: height
            border.color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
            Row {
                id: rowListView
                height: 45
                width: page.width
                spacing: 1
                Item{width: 10; height: 45}
                Label {
                    text: Nome
                    width: page.width * 0.20
                    height: 45
                    elide: Text.ElideRight
                    font.pixelSize: 13
                    maximumLineCount: 1
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAnywhere
                }
                Label {
                    text: Descricao
                    width: page.width * 0.50
                    height: 45
                    elide: Text.ElideRight
                    maximumLineCount: 3
                    wrapMode: Text.WrapAnywhere
                    verticalAlignment: Text.AlignVCenter
                }
                Label {
                    text: Status
                    width: page.width * 0.05
                    height: 45
                    elide: Text.ElideRight
                    maximumLineCount: 1
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAnywhere
                }
                AwesomeIcon {
                    name: "minus-circle"
                    color: "black"
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }

    ListModel {
        id: listaElementosReservados
        ListElement { Nome: "Notebook"; Descricao: "Notebook do dept mat";Status: "Reservado"}
        ListElement { Nome: "dataShow"; Descricao: "Datashow de ADS "; Status: "Reservado"}
    }
}

