import QtQuick 2.1
Item
{
    property string theColor: "yellow"
    Rectangle {
        width:parent.width// parent.width<parent.height?parent.width:parent.height
        height: width
        color: "transparent"
        border.color: theColor
        border.width: 1
        radius: width*0.5
    }
}
