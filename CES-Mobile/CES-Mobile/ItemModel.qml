import QtQuick 2.9

import "AwesomeIcon/"

Item {

    function listarUsuarios() {
        return listaUsuarios;
    }

    function listarRetirados(user) {
        return listaRetirados;
    }

    ListModel {
        id: listaRetirados
        ListElement {
            nome: "Chave"
            dataRetirada: "13/09/2017"
            iconName: "key"
        }

        /*ListElement {
            nome: "Chave"
            dataRetirada: "14/09/2017"
            iconName: "key"
        }

        ListElement {
            nome: "Multimídia"
            dataRetirada: "16/09/2017"
            iconName: "print"
        }*/

    }

    ListModel {
        id: listaUsuarios
        ListElement { texto: "Renato"}
        ListElement { texto: "Emanuel"}
        ListElement { texto: "Brunno"}
        ListElement { texto: "Thiago"}
        ListElement { texto: "Emerson"}
    }
}
