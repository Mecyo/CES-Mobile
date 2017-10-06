import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Window 2.2
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
        color: "#008fb3";

        Column {
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
                    text: "AAHGDFD"
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

   Label{
       id:lblComVc;
       text: "Objetos com Você: "
       anchors.top: quadpesq.bottom
   }

   Item {
       id: headerList
       anchors.top: lblComVc.bottom;
       Rectangle {
           id: col1
           width: page.width / 4
           height: 20
           border.color: "#000"
           border.width: 1
           color: "#CCC"
           Label {text: '<b>Nome</b>' ; anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}

       }
       Rectangle {
           id: col2
           width: page.width / 4
           anchors.top: lblComVc.bottom;
           anchors.left: col1.right
           height: 20
           border.color: "#000"
           border.width: 1
           color: "#CCC"
           Label { text: '<b>Retirada</b>' ; anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}

       }
       Rectangle {
           id: col3
           width: page.width / 4
           anchors.top: lblComVc.bottom;
           anchors.left: col2.right
           height: 20
           border.color: "#000"
           border.width: 1
           color: "#CCC"
           Label { text: '<b>Devolver</b>' ; anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}

       }
       Rectangle {
           id: col4
           width: page.width / 4
           anchors.top: lblComVc.bottom;
           anchors.left: col3.right
           height: 20
           border.color: "#000"
           border.width: 1
           color: "#CCC"
           Label { text: '<b>Transferir</b>' ; anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}

       }
   }

   Rectangle {
        id: rectComVoce
        width: parent.width;
        height: 480
        color: "#C9F1FD";
        anchors.top: headerList.bottom
        anchors.topMargin: 20

        ListView {

            //header:
            model: modelRetirados.listarRetirados("userName")
            delegate: retiradosDelegate
            focus: true
        }

        ItemModel{id: modelRetirados}
        ItensRetiradosDelegate{id: retiradosDelegate}




        /*ListView {
            width: rectComVoce.width

            /*header: Rectangle {
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
            }*/
           /* model: retiradosModel;
            delegate: Component {
                Rectangle {
                    //anchors.top: headerListComVoce.bottom;
                    width: page.width
                    height: 45
                    border.color: "black"
                    RowLayout {
                        id: rowListView
                        height: parent.height
                        width: parent.width
                        anchors.horizontalCenter: parent.horizontalCenter

                        /*Column {
                            id: columnGridNome
                            height: 15
                            width: page.width / 4
                            anchors{margins: 10}*/
                            /*Label {
                                id: lblNome
                                text: nome
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        //}

                        /*Column {
                            id: columnGridRetirada
                            height: 15
                            width: page.width / 4
                            anchors{left: columnGridNome.right; margins: 10}*/
                            /*Label {
                                id: lblRetirada
                                text: dataRetirada
                                anchors.left: lblNome.right
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        //}

                        /*Column {
                            id: columnGridDevolver
                            height: 15
                            width: page.width / 4
                            anchors{left: columnGridRetirada.right; margins: 10}
                            AwesomeIcon {
                                id: iconTransferir
                                name: "reply";
                                color: "#333"
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                onClicked: {
                                    dialog.setText("Devolvendo ítem: " + nome);
                                    dialog.open();
                                }
                            }
                        }

                        Column {
                            id: columnGridTransferir
                            height: 15
                            width: page.width / 4
                            anchors{right: page.right; margins: 10}
                            AwesomeIcon {
                                name: "retweet";
                                color: "#333"
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                onClicked: {
                                    dialog.setText("Transferindo ítem: " + nome);
                                    dialog.open();
                                }
                            }
                        }*/
                    /*}
                }
            }
        }*/
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

   */


}
