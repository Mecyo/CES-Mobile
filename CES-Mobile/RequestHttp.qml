import RequestHttp 1.0 

RequestHttp {
    baseUrl: Settings.restService.baseUrl
    basicAuthorizationUser: Settings.restService.userServiceName
    basicAuthorizationPassword: Settings.restService.userServicePassword
    onError: {
        // signal signature: void error(int statusCode, const QVariant &message);
        if (statusCode !== 3)
            return
        var message = qsTr("Cannot connect to server!")
        // alert is a function on Main.qml
        // on iOS, the alert show a dialog with a native appearence
        // snackbar is a object on Main.qml most used in Android
        if (window.isIOS)
            window.alert(qsTr("Error!"), message, null, null)
        else
            snackbar.show(message)
    }
}
