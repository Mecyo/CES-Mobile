import QtQuick 2.0

Item {

    id: item1

    Component.onCompleted: requestHttp.get("status_objetos/")

    RequestHttp {
        id: requestHttp
        onFinished: {


           if(statusCode == 200) {
                    var objectsStatus = []
                    for (var j = 0; j < response.length; ++j)
                        objectsStatus.push(response[j])
                    window.objectStatus = objectsStatus
             }


        }

    }

}
 
