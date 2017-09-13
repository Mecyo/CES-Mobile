import QtQuick 2.5
import QtQuick.Controls.Styles 1.2

TabViewStyle {
    tab: Item {

        implicitWidth: Math.round(textitem.implicitWidth + image.width + 20)
        implicitHeight: Math.round(textitem.implicitHeight + 10)

        Rectangle
        {
            anchors.fill: parent
            anchors.bottomMargin: 2
            radius: 1
            border.width: 1
            border.color: "#AAA"
            color:"transparent"
        }

        Rectangle
        {
            anchors.fill: parent
            anchors.margins: 1
            anchors.bottomMargin: styleData.selected ? 0 : 2
            radius: 1
            gradient: Gradient{
                GradientStop{position:0; color:styleData.selected?"#EDEDED":"#E3E3E3"}
                GradientStop{position:1; color:styleData.selected?"#DCDCDC":"#D3D3D3"}
            }
        }

        Text {
            id: textitem
            anchors.fill: parent
            anchors.leftMargin: 4 + image.width
            anchors.rightMargin: 4
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: styleData.title
            elide: Text.ElideMiddle
        }

        Image
        {
            id: image
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.margins: 2
            anchors.leftMargin: 4
            fillMode: Image.PreserveAspectFit
            source: control.getTab(styleData.index).icon

        }
    }
}
