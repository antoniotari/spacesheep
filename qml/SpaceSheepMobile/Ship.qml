import QtQuick 2.0
import "defs.js" as Defs
import QtQuick.Particles 2.0

Item{
    id:ship

    opacity: 1
    property bool isActive: false
    width:Defs.shipxsize// Defs.scaledDim(Defs.shipxsize,parent.height)
    height: Defs.shipysize//Defs.scaledDim(Defs.shipysize,parent.height)

    Rectangle
    {
        width: parent.width-30
        height:parent.height-10
        anchors.centerIn: parent
        color:"transparent"
    Image{
        anchors.fill: parent
         id:metImage
         source: "../../images/images/ship.png"
         //"assets:/images/ship.png"
     }
    }

    Behavior on x {
        id:animationx
        animation: bouncebehavior

    }
    Behavior on y {
        animation: bouncebehavior2
    }

    NumberAnimation {
        id: bouncebehavior
        /*easing {
            type: Easing.OutCirc
            amplitude: 11.0
            period: 0.1
        }*/
        duration:77
    }

    NumberAnimation {
        id: bouncebehavior2
        /*easing {
            type: Easing.OutCirc
            amplitude: 11.0
            period: 0.1
        }*/
        duration:77
    }
}
