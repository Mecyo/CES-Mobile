import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

Drawer {
    id: menu
    width: window.width * 0.84; height: window.height
    dragMargin: enabled ? Qt.styleHints.startDragDistance : 0

    property bool enabled: true
    property color menuItemTextColor: Settings.theme.colorAccent
    property color menuBackgroundColor: Settings.theme.menuBackgroundColor
    property color menuItemSelectedTextColor: Qt.darker(menuBackgroundColor, 1.7)
    property color userInfoTextColor: menuItemTextColor

    Component.onCompleted: {
        var pagesLength = window.pages.length
        for (var i = 0; i < pagesLength; i++)
            listModel.append(window.pages[i])
    }

    Connections {
        target: window
        onCurrentPageChanged: close()
        onEventNotify: {
            // signal signature: eventNotify(string eventName, var eventData)
            if (eventName === Settings.events.openDrawer)
                open()
            else if (eventName === Settings.events.userProfileChanged && user.profile.hasOwnProperty("image_path"))
                drawerUserImageProfile.imgSource = user.profile.image_path
        }
    }

    Rectangle {
        id: menuRectangle
        z: 0; anchors.fill: parent; color: menuBackgroundColor
    }

    ColumnLayout {
        id: userInfoColumn
        width: parent.width; height: 120
        anchors { top: parent.top; topMargin: 15; horizontalCenter: parent.horizontalCenter }

        RoundedImage {
            id: drawerUserImageProfile
            width: 100; height: width
            borderColor: Settings.theme.colorAccent
            imgSource: "qrc:/default_user_image.svg"
            anchors { top: parent.top; topMargin: 10; horizontalCenter: parent.horizontalCenter }
        }

        Text {
            color: userInfoTextColor; textFormat: Text.RichText
            text: user.profile.name + "<br><b>" + user.profile.email + "</b>"
            font.pointSize: Settings.fontSize.normal; Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            anchors {
                topMargin: 15
                top: drawerUserImageProfile.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }
    }

    // window.pages is a list of objects (plugins) that set "showInMenu" to true
    // each object has the follow properties:
    // {
    //    "absPath": "the qml file absolute path as string",
    //    "title": "the page title as string",
    //    "icon": "the icon name as string",
    //    "roles": [the list of roles],
    //    "order": integer,
    //    "isHome": boolean,
    //    "showInMenu": boolean,
    //    "isLogin": boolean
    // }
    ListView {
        width: parent.width
        height: parent.height - userInfoColumn.height
        anchors { top: userInfoColumn.bottom; topMargin: 55 }
        boundsBehavior: Flickable.StopAtBounds
        model: ListModel { id: listModel }
        delegate: ListItem {
            width: menu.width
            showSeparator: true
            primaryIconName: icon
            primaryLabelText: title
            primaryLabelColor: menuItemTextColor
            selectedBackgroundColor: menuItemSelectedTextColor
            backgroundColor: menuBackgroundColor
            selected: absPath === window.currentPage.pageUrl
            visible: showInMenu && window.pages[index].roles.indexOf(user.profileName) > -1
            onClicked: {
                pageStack.pushIfNotExists(absPath, {"pageUrl":absPath})
                close()
            }
        }
        ScrollIndicator.vertical: ScrollIndicator { }
    }
}
