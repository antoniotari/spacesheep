import QtQuick 2.0
import "defs.js" as Defs

Item {
    width: parent.width
    height: parent.height

    property double speed:44 // Defs.speed
    property bool timerRunning: timer.running

    // the timer will refresh the field to give the impression that is moving down
    Timer {
        id:timer
        interval: 2; running: false; repeat: true
        onTriggered: {
            Defs.createStarField(parent.width,parent.height);
        }
    }

    function startTimer()
    {
        timer.start()
    }

    Component.onCompleted:{
        //Defs.createStarField(parent.width,parent.height);
    }

    Component.onDestruction: console.log("Destruction Beginning!")
}
