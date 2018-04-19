import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Page {
    id: page
    title: "Transferência - (Objeto(s) em sua posse)"
    objectName: "Transferência"

    property string colorWindowLogin: "#3580cf"
    property string colorInputActive: "#20579d"
    property string colorInputInActive: "#2461ac"
    property string colorButton: "#b2cff4"
    property string inputFocus: "login"

    Popup {
        id: popup
        x: window.width / 10
        y: window.height / 4
        width: window.width - (x * 2)
        height: window.height / 2
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        Component.onCompleted: open()

        contentItem: Rectangle {
            color: colorWindowLogin
            anchors.centerIn: parent
            Text {
                id: mensagem
                text: ""
                color: "#FFF"
            }
            Column {
                anchors.centerIn: parent
                spacing: 16
                Column {
                    id: colLogin
                    x: 10
                    width: 200
                    height: 52
                    spacing: 4
                    Text { text: "Login" }
                  TextField {
                      id: login
                      width: parent.width
                      font.family: "Verdana"
                      focus: true
                      onFocusChanged: inputFocus = "login"
                      background: Rectangle{
                        radius: 8
                        color: inputFocus == "login" ? colorInputActive : colorInputInActive
                      }
                  }
                }
                Column {
                    id: colSenha
                    x: 10
                    width: 200
                    height: 52
                    spacing: 4
                    Text { text: "Senha" }
                    TextField {
                        id: senha
                        width: parent.width
                        font.capitalization: Font.AllUppercase
                        echoMode: TextInput.Password
                        onFocusChanged: inputFocus = "senha"
                        background: Rectangle{
                            radius: 8
                            color: inputFocus == "senha" ? colorInputActive : colorInputInActive
                        }
                    }
                }
                Row {
                      spacing: 16
                  anchors.horizontalCenter: parent.horizontalCenter
                  Button {
                      text: "Login"
                      onClicked: initSystem()
                       background: Rectangle {
                           radius: 4
                          color: colorButton
                      }
                  }
                  Button {
                      text: "Sair"
                      onClicked: window.close()
                      background: Rectangle {
                          radius: 8
                         color: colorButton
                     }
                  }
                }
             }
        }

    }
}
