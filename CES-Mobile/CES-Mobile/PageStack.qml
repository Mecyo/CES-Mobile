import QtQuick 2.8
import QtQuick.Controls 2.1

StackView {
    id: _pageStack
    visible: true
    anchors.fill: visible ? parent : undefined

    function pushIfNotExists(pageAbsPath, prop) {
        // if current page viewed is "pageAbsPath" return!
        if (currentItem.pageUrl === pageAbsPath)
            return
        var page = null
        for (var i = 0; i < _pageStack.depth; ++i) {
            page = get(i, StackView.ForceLoad)
            if (page.pageUrl === pageAbsPath)
                page = pop(page)
            else
                page = false
        }
        if (!page)
            push(pageAbsPath, prop)
    }

    Connections {
        target: window
        onEventNotify: {
            if (eventName === Settings.events.goBack) {
                if (typeof camera != "undefined" && camera.visible)
                    camera.close()
                else if (_pageStack.depth > 1)
                    _pageStack.pop()
                return false
            }
        }
    }
}
