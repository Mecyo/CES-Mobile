import QtQuick 2.0

Item {

    Component.onCompleted: requestHttp.get("tipos_objetos/")

    RequestHttp {
        id: requestHttp
        onFinished: {
            if (statusCode == 200) {
                var objectsTypes = []
                for (var i = 0; i < response.length; ++i)
                    objectsTypes.push(response[i].nome)
                window.objectTypes = objectsTypes
            }
        }
    }
}
