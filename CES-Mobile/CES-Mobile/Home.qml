import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Window 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3

import "AwesomeIcon/"

Page {
    id: page
    title: "Home"

   Rectangle {
        id: quadpesq;
        width: parent.width;
        height: 48
        color: "#2196F3";

        Column {
            id: column
            x: 16
            y: 16
            height: 16
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
                    anchors.verticalCenter: parent.verticalCenter
                    placeholderText: "Pesquisar..."
                    padding: 0
                    bottomPadding: 8
                    leftPadding: 18
                    topPadding: 8
                    font.pointSize: 11
                    horizontalAlignment: Text.AlignLeft
                    background: Rectangle {
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
                    model: ["Selecione", "Nome", "Data Retirada"]
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

   Rectangle {
        id: rectComVoce
        width: parent.width;
        height: parent.height;
        color: "#C9F1FD";
        anchors.top: quadpesq.bottom;
        Label{
            id:lblComVc;
            text: "Objetos com Você: "
        }


        ListView {
            anchors.top: lblComVc.bottom;
            header: Rectangle {
                id: headerListComVoce
                color: "#ff5500"

                border.color: "black"
                border.width: 1
                Column {
                    id: columnNome
                    height: 15
                    width: page.width / 4
                    anchors{margins: 10}
                    Text { text: '<b>Nome</b>'}
                }
                Column {
                    id: columnRetirada
                    height: 15
                    width: page.width / 4
                    anchors{left: columnNome.right; margins: 10}
                    Text { text: '<b>Retirada</b>'}
                }
                Column {
                    id: columDevolver
                    height: 15
                    width: page.width / 4
                    anchors{left: columnRetirada.right; margins: 10}
                    Text { text: '<b>Devolver</b>'}
                }
                Column {
                    id: columnTransferir
                    height: 15
                    width: page.width / 4
                    anchors{left: columDevolver.right; margins: 10}
                    Text { text: '<b>Transferir</b>'}
                }
            }
        }
   }

/*ListView {
            model: retiradosModel
            delegate: Component {
                Rectangle {
                    width: page.width
                    height: 45
                    border.color: "black"
                    RowLayout {
                        id: rowListView
                        height: parent.height
                        width: parent.width - 10
                        anchors.horizontalCenter: parent.horizontalCenter

                        Label {
                            text: texto
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        AwesomeIcon {

                        }
                }
            }

            model: ObjectsModel {}
            delegate: contactsDelegate
            focus: true
        }
    }

   Rectangle{
        id: rectRetirados
        width: parent.width;
        height: parent.height;
        color: "#C9F1FD";
        anchors.top: rectComVoce.bottom;
        Label{
            anchors.top:lblComVc.bottom
            id:lblRetirados;
            text: "Últimos retirados: "
        }

        ListView {
            width: 180; height: 200

            Component {
                id: contactsDelegate
                Rectangle {
                    id: wrapper
                    width: 180
                    height: contactInfo.height
                    color: ListView.isCurrentItem ? "black" : "red"
                    Text {
                        id: contactInfo
                        text: name + ": " + number
                        color: wrapper.ListView.isCurrentItem ? "red" : "black"
                    }
                }
            }

            model: R {}
            delegate: contactsDelegate
            focus: true
        }

    }

   Rectangle {
       width: 180; height: 200

       Component {
           id: retiradosDelegate
           Item {
               width: 180; height: 40
               Column {
                   Text { text: '<b>Nome</b>'}
               }
           }
       }

       ListView {
           anchors.fill: parent
           model: retiradosModel
           delegate: retiradosDelegate
           highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
           focus: true
       }
   }

   ListModel {
       id: retiradosModel
       ListElement {
           name: "Chave"
           dataRetirada: "13/09/2017"
           devolver: AwesomeIcon {
               size: parent.height / 2
               color: "#333"
               anchors.leftMargin: -22
               name: "reply"; y: 0; width: 27; height: 43; clickEnabled: true
               anchors{left: parent.left; centerIn: parent.Center}
               onClicked: {
                   dialog.setText("Devolvendo ítem: " + parent.name);
                   dialog.open();
               }
          }
           transferir: AwesomeIcon {
               size: parent.height / 2
               color: "#333"
               anchors.leftMargin: -22
               name: "retweet"; y: 0; width: 27; height: 43; clickEnabled: true
               anchors{left: parent.left; centerIn: parent.Center}
               onClicked: {
                   dialog.setText("Transferindo ítem: " + parent.name);
                   dialog.open();
               }
          }
       }
       ListElement {
           name: "Chave"
           dataRetirada: "14/09/2017"
           devolver: AwesomeIcon {
               size: parent.height / 2
               color: "#333"
               anchors.leftMargin: -22
               name: "reply"; y: 0; width: 27; height: 43; clickEnabled: true
               anchors{left: parent.left; centerIn: parent.Center}
               onClicked: {
                   dialog.setText("Devolvendo ítem: " + parent.name);
                   dialog.open();
               }
          }
           transferir: AwesomeIcon {
               size: parent.height / 2
               color: "#333"
               anchors.leftMargin: -22
               name: "retweet"; y: 0; width: 27; height: 43; clickEnabled: true
               anchors{left: parent.left; centerIn: parent.Center}
               onClicked: {
                   dialog.setText("Transferindo ítem: " + parent.name);
                   dialog.open();
               }
          }
       }
       ListElement {
           name: "Multimídia"
           dataRetirada: "16/09/2017"
           devolver: AwesomeIcon {
               size: parent.height / 2
               color: "#333"
               anchors.leftMargin: -22
               name: "reply"; y: 0; width: 27; height: 43; clickEnabled: true
               anchors{left: parent.left; centerIn: parent.Center}
               onClicked: {
                   dialog.setText("Devolvendo ítem: " + parent.name);
                   dialog.open();
               }
          }
           transferir: AwesomeIcon {
               size: parent.height / 2
               color: "#333"
               anchors.leftMargin: -22
               name: "retweet"; y: 0; width: 27; height: 43; clickEnabled: true
               anchors{left: parent.left; centerIn: parent.Center}
               onClicked: {
                   dialog.setText("Transferindo ítem: " + parent.name);
                   dialog.open();
               }
          }
       }
   }*/


}
