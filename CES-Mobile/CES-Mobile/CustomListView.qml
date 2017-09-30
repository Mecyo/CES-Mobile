import QtQuick 2.8
import QtQuick.Controls 2.1

ListView {
    model: ListModel { }
    clip: true; cacheBuffer: width
    delegate: basePage.listViewDelegate ? basePage.listViewDelegate : null
    width: basePage.width; height: basePage.height
    onRemoveChanged: update()
    onAtYEndChanged: if (atYEnd) loadItens()
    add: Transition {
        NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 350 }
        NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 350 }
    }
    displaced: Transition {
        NumberAnimation { properties: "x,y"; duration: 350; easing.type: Easing.OutBounce }
    }
    ScrollIndicator.vertical: ScrollIndicator { }
}
