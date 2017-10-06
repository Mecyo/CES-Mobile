import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: window
    visible: true
    width: 360; height: 580
    title: qsTr("CES - Sistema de Controle de Entrada e Saída de Objetos")
    x: 510; y: 75
    Component.onCompleted: pageStack.push(Qt.resolvedUrl("Home.qml"))

    property bool isIOS: Qt.platform.os === "ios"
    property alias currentPage: pageStack.currentItem
    property bool isAndroid: Qt.platform.os === "android"
    property var user: {
        "profileName": "teacher",
        "profile": {
            "id": 1,
            "email": "enoquejoseneas@gmail.com",
            "name": "Enoque Joseneas"
        }
    }
    property var pages: [
        {
           "absPath": "ListObjectsAvailable.qml",
           "title": "Objetos disponíveis",
           "icon": "gears",
           "roles": ["teacher"],
           "order": 1,
           "isHome": false,
           "showInMenu": true,
           "isLogin": false
        }
    ]

    property var pagesHistorico: [
        {
           "absPath": "Historico.qml",
           "title": "Histórico de Objetos",
           "icon": "gears",
           "roles": ["teacher"],
           "order": 1,
           "isHome": false,
           "showInMenu": true,
           "isLogin": false
        }
    ]

    // this signal can be used to pages make connections to some events
    // like push notification message|token, send by android QtActivity and iOS AppDelegate
    signal eventNotify(string eventName, var eventData)

    Loader {
        asynchronous: false
        source: "ToolBar.qml"
        onLoaded: window.header = item
    }

    Loader {
        asynchronous: false
        source: "Menu.qml"
    }

    /*This is to load the user logged to be used in all pages
    Loader {
        asynchronous: false
        source: "Home.qml"
        onLoaded: {

            request('http://someurlgoeshere.com', function (o) {

                    // log the json response
                    console.log(o.responseText);

                    // translate response into object
                    var d = eval('new Object(' + o.responseText + ')');

                    // access elements inside json object with dot notation
                    emailLabel.text = d.email
                    urlLabel.text = d.url
                    sinceLabel.text = d.since
                    bioLabel.text = d.bio

                });
        }
    }

    // this function is included locally, but you can also include separately via a header definition
    function request(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = (function(myxhr) {
            return function() {
                callback(myxhr);
            }
        })(xhr);
        xhr.open('GET', url, true);
        xhr.send('');
    }*/

    Toast {
        id: toast
    }

    PageStack {
        id: pageStack
    }
}
