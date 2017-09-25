import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Window 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import "AwesomeIcon/"

Page {
    title: "Home"

   Rectangle {
        id: quadpesq;
        width: parent.width;
        height: parent.height / 10;
        color: "#2196F3";

        Column {
            anchors{fill:parent;margins: 16}
            Row {
                spacing: 7

                TextField {
                    id: txtPesquisa;
                    placeholderText: "Pesquisar..."
                    height: comboPesquisa.height
                    background: Rectangle {
                                    color: "#FFF";
                                    radius: 10
                                    implicitWidth: 100;
                                    border.color: "#333"
                                    border.width: 1
                                    AwesomeIcon {
                                        id: iconSearch
                                        size: 10//parent.height / 2
                                        color: "#333"
                                        name: "search"; clickEnabled: true
                                        anchors{left: parent.left; centerIn: parent.Center}
                                        onClicked: {
                                            //dialog.Reset
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
                    name: "pencil"; clickEnabled: true
                    anchors{left: parent.left; centerIn: parent.Center}
                    onClicked: {
                        dialog.informativeText = "Editando!!"
                        dialog.open();
                    }
               }
            }
        }
    }

   Rectangle{
        id: principal
        width: parent.width;
        height: parent.height;
        color: "#C9F1FD";
        anchors.top: quadpesq.bottom;
        Label{
            id:lblComVc;
            text: "Objetos com Você: "
        }
        Label{
            anchors.top:lblComVc.bottom
            id:lblRetirados;
            text: "Últimos retirados: "
        }

    }
}
