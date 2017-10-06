import QtQuick 2.8
import QtQuick.Controls 2.1

Page {
    id: basePage
    width: window.width
    background: Rectangle {
        id: _pageBackgroundRec
        anchors.fill: parent
        color: Settings.theme.pageBackgroundColor
    }

    // used by toolbar when page is on the pageStack to make bind with action button
    // if page set to 'goback' value, the toolbar show a arrow-left icon as back button
    // when user click in this button, the page is poped from pageStack.
    property string toolBarState: "normal"

    // keeps the page url, used to bind with menu (turn item selected) and is
    // used by pageStack to check if page is already ont the stack, moving to top if found
    property string pageUrl: ""

    // keeps the page absolute path without page extension type
    // for this works, the objectName needs to be set
    property string pluginAbsPath: pageUrl.replace(objectName,"")

    // each page can set a custom color to page background using this alias
    property alias pageBackgroundColor: _pageBackgroundRec.color

    /**
     * A object with toolbar actions used when the page is on the pageStack
     * ToolBar offears 4 buttons put into a RowLayout from right to left.
     * Each button can be used to page add some events.
     * Each button needs the icon and action name propertys.
     * The action name is send to window eventNotify and the page
     * needs a connection to manager the clicks on each button.
     * This Object needs to be a object like this:
     *    {
     *       "toolButton3": {"action":"delete", "icon":"trash"},
     *       "toolButton4": {"action":"copy", "icon":"copy"}
     *    }
     */
    property var toolBarActions: ({})

    /**
      * This property is read by toolbar dinamically
      * This property can be used to page show a list of itens in last icon of toolbar
      * like a sub-menu of options. Needs to be a list of MenuItem with two propertys for each item:
      *     1: 'text' - the text to be displayed
      *     2: a event handle for onTriggered action, that is triggered when user touch in the item.
      * toolBarMenuList: [
      *    MenuItem {
      *        text: qsTr("Show in grid")
      *        onTriggered: listView.visible = !listView.visible
      *    },
      *    MenuItem {
      *        text: checkedAll ? qsTr("Uncheck all") : qsTr("Check all")
      *        onTriggered: { ... }
      *    }
      * ]
      */
    property list<MenuItem> toolBarMenuList

    // pages uses this flag to prevent object RequestHttp creation id not make http requests
    // the default is true and RequestHttp object is loaded asynchronously
    property bool hasNetworkRequest: true

    // pages can use this flag to prevent android back button send user to previous page
    // this flag will be check with Main.qml
    property bool lockGoBack: false

    // flag to hide/show the application tabBar (window.footer), loaded in Main.qml
    // the TabBar is loaded only if the app has true value in 'usesTabBar' property in app settings
    // the TabBar is the app footer and is used with SwipeView, showing the pages button in window bottom
    property bool showTabBar: true

    // flag to hide/show the application toolBar (window.header), loaded in Main.qml
    // the toolbar is a custom component with a row of buttons
    // some pages like login or logout, hide the toolbar using this flag (setting to false)!
    property bool showToolBar: true

    // to auto-loader the listView
    property bool hasListView: true

    // if set to false, the busyIndicator will be put on the top
    property bool centralizeBusyIndicator: true

    // a flag to the current page state binding with requestHttp state
    property bool isPageBusy: false

    // keeps the status for current page
    // The currentPage is a window alias to currentItem in pageStack or swipeView
    property bool isActivePage: window.currentPage && window.currentPage.objectName === objectName

    // a instance of RequestHttp created dynamically to page manage http requests
    property QtObject requestHttp

    // alias to busyIndicator to child page manage them
    property alias busyIndicator: _busyIndicator

    // alias to primary text of the emptyList to child page set a specific text
    property alias primaryActionMessageText: _pageActionMessage.primaryActionMessageText

    // alias to secondary text of the emptyList to child page set a specific text
    property alias secondaryActionMessageText: _pageActionMessage.secondaryActionMessageText

    // alias to icon name in the emptyList to child page set a specific icon
    property alias actionMessageIconName: _pageActionMessage.iconName

    // by default, the page load a  new ListView and set to this property
    // if the page not use or need a list view, set the property 'hasListView' to false
    property ListView listView

    // keeps an alias to listView model (QML ListModel instance)
    property ListModel listViewModel

    // component implemented by child page that uses ListView
    property Component listViewDelegate

    // this signal is emited when user touch in PageActionMessage icon
    // the page can connect with this signal to reload page or make some action
    // the PageActionMessage is visible when page has ListView and the list is empty
    signal requestUpdatePage()

    // this signal is emited by ListView when user come to the end of the list
    // and can be used by page to load more data from webservice to paginating results
    // loading more itens or show some alert to user
    signal loadItens()

    // this signal is emited after listview creation finished
    signal listViewReady()

    // this signal is emited after requestHttp creation finished
    signal requestHttpReady()

    // show page loading element when request http is running
    BusyIndicator {
        id: _busyIndicator
        visible: isPageBusy; z: parent.z + 1
        anchors {
            centerIn: centralizeBusyIndicator ? parent : undefined
            top: centralizeBusyIndicator ? undefined : parent.top
            topMargin: centralizeBusyIndicator ? undefined : 20
            horizontalCenter: centralizeBusyIndicator ? undefined : parent.horizontalCenter
        }
    }

    // page action message show a icon with two messages put into a column
    // the action can be clicked by user and send the requestUpdatePage() signal
    PageActionMessage {
        id: _pageActionMessage
        z: basePage.z+1
        visible: hasListView && listView && listView.count === 0 && !isPageBusy
        enabled: !isPageBusy
        onClicked: requestUpdatePage()
    }

    // if the page not set hasNetworkRequest to false, this loader
    // create a new instance of RequestHttp to page manage requests like get, post...
    // Obs: To page manage results from requests, needs to create a connection with requestHttp alias
    // handling the signal: onFinished(int statusCode, const QVariant &response)
    Loader {
        asynchronous: true; active: hasNetworkRequest
        sourceComponent: RequestHttp { }
        onLoaded: {
            basePage.requestHttp = item
            isPageBusy = Qt.binding(function() { return basePage.requestHttp.state === basePage.requestHttp.stateLoading })
            requestHttpReady()
        }
    }

    // if the page not set hasListView to false,
    // this loader create a instance of ListView
    Loader {
        asynchronous: true; active: hasListView
        sourceComponent: CustomListView { }
        onLoaded: {
            basePage.listView = item
            basePage.listViewModel = Qt.binding(function() { return listView.model })
            listViewReady()
        }
    }
}
