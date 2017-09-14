import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import "./AwesomeIcon/" as AwesomeIcon

ApplicationWindow {
    id: windowApp
    visible: true
    width: 400
    height: 480

    property bool isSwipeView: true
    property alias currentPage: pageStack.currentItem
    property alias currentPageSwipe: menuSwipe.swipeChildCurrentItem
    property alias depth: pageStack.depth

    onDepthChanged:  depthChange()
    onCurrentPageSwipeChanged: currentPageSwipe ? toolbarText.text = currentPageSwipe.objectName : ""
    onCurrentPageChanged: currentPage ? toolbarText.text = currentPage.objectName : ""

    function depthChange() {
        if(!menuSwipe)
            return;
        if(depth === 0){
            isSwipeView = true
            menuSwipe.tabBarChild.visible = true
            toolbarText.text = currentPageSwipe.objectName
            menuSwipe.z = windowApp.z + 1
            pageStack.z = windowApp.z - 1
        } else {
            isSwipeView = false
            menuSwipe.tabBarChild.visible = false
            pageStack.z = windowApp.z + 1
            menuSwipe.z = windowApp.z - 1
        }
    }

    function pushPage(url, args) {
        pageStack.push(url, args)
    }

    function popPage() {
        if(depth === 1)
            pageStack.clear()
        pageStack.pop()
    }

    header: ToolBar {
        id: toolbar1
        Rectangle {
            anchors.fill: parent
            color: "#006600"
        }
        anchors.leftMargin: 10

        RowLayout {
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            anchors.fill: parent

            AwesomeIcon.AwesomeIcon {
                name: isSwipeView ? "" :"arrow_left"
                color: "black"
                size: 22
                onClicked: popPage()
            }
            Label {
                id: toolbarText
                text: currentPage !== null ? currentPage.objectName : currentPageSwipe.objectName
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
                anchors.centerIn: parent
            }
        }
    }

    MenuSwipe {
        id: menuSwipe
    }

    footer: menuSwipe.tabBarChild

    StackView {
        id: pageStack
        anchors.fill: parent

        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {
                if (pageStack.depth > 1) {
                    pageStack.pop();
                    event.accepted = true;
                }
            }
        }

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0; to: 1; duration: 450
            }
        }

        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1; to: 0; duration: 450
            }
        }
    }
}
