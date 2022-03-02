import QtQuick 2.1
//import QtQuick.Controls 1.0
import QtSensors 5.0
import "defs.js" as Defs
//import "Meteor.qml" as Meteor

Rectangle {
    id:main_window
    width: (applicationData.getDevice().indexOf("pc") != -1)?400:1000
    height: (applicationData.getDevice().indexOf("pc") != -1)?Defs.heigtFactor:2000

    // width: DisplayInfo.width
    //height: DisplayInfo.height
    //anchors.fill: parent
    radius: 0
    opacity: 1
    visible: true
    color:"black"

    Rectangle{
        id:fill_rect
        anchors.fill: parent
        //rotation:45.0
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color:"black"
                //color:Qt.rgba(0.4,0.4,0.4,0.5)
            }

            GradientStop {
                position: 1.0
                color:"steelblue"
            }
        }

        Rectangle{
            id:fill_rect2
            anchors.fill: parent
            color:Qt.rgba(0.0,0.0,0.0,0.5)
        }
    }

    //dimension of the meteor
    property double metDimX: Defs.sxmet;
    property double metDimY: Defs.symet;
    //property int distance: 0;

    property int someNumber:11

    signal qmlSignal2(var anObject)

    /* the SystemPalette item provides access to the Qt system palette
    and is used to give the button a more native look-and-feel. */
    SystemPalette {
        id: activePalette
    }

    //shoot on space bar
    Keys.onSpacePressed: {
        applicationData.shootBullet()
    }

    Component.onCompleted: {
        //var types = SensorsAndr.sensorTypes();
        //console.log(types.join(", "));
        console.log("main window oncompleted w:"+width+" h:"+height);
        spaceField.startTimer();
        console.log("FROM QML, THE DEVICE IS : "+applicationData.getDevice());
    }

    function startAnimations()
    {
        seqanim.start()
        paranim.start()
    }

    //pause the game
    Keys.onBacktabPressed: {
        // check if global pause is true or false
        // call function in c++ to pause the thread
        // pause the timers in qml
    }

    /* Text {
        text: qsTr("")
        anchors.centerIn: parent
    }*/

    MouseArea {
        id:mouseArea
        //anchors.fill: parent
        //z:2
        x:parent.x
        y:parent.y
        width:parent.width
        height: parent.height-toolBar.height

        property double mouseXclick
        property double mouseYclick

        onClicked: {
            //Qt.quit();
            applicationData.shootBullet()
        }

        onPressed: {
            mouseXclick=mouseX
            mouseYclick=mouseY
            timerMove.start()
        }

        onPressAndHold: {
        }

        onReleased: {
            timerMove.stop()
            joyRect.x=0
            joyRect.y=0
            joyRect.width= 0
            joyRect.height=0
        }
    }

    // the timer will start when mouse pressed and checks the position of the mouse to move the ship
    Timer {
        id:timerMove
        interval: 2; running: false; repeat: true
        onTriggered: {
            if((mouseArea.mouseX!=mouseArea.mouseXclick) &&(mouseArea.mouseY!=mouseArea.mouseYclick) )
            {
                space_ship.x=Defs.shipMoveX(mouseArea.mouseX>mouseArea.mouseXclick?false:true)
                space_ship.y=Defs.shipMoveY(mouseArea.mouseY>mouseArea.mouseYclick?false:true)

                joyRect.x=mouseArea.mouseX>mouseArea.mouseXclick?mouseArea.mouseXclick:mouseArea.mouseX
                joyRect.y=mouseArea.mouseY>mouseArea.mouseYclick?mouseArea.mouseYclick:mouseArea.mouseY
                joyRect.width= mouseArea.mouseX>mouseArea.mouseXclick?(mouseArea.mouseX-mouseArea.mouseXclick):(mouseArea.mouseXclick-mouseArea.mouseX)
                joyRect.height= mouseArea.mouseY>mouseArea.mouseYclick?(mouseArea.mouseY-mouseArea.mouseYclick):(mouseArea.mouseYclick-mouseArea.mouseY)
            }
        }
    }


    SpaceField {
        z:11
        id: spaceField
    }

    FontLoader {
        id: webFont;
        //source: "file:///Users/anthony/qt_code/SpaceHighway01/fonts/HanaleiFill-Regular.ttf"
        source: "../../fonts/HanaleiFill-Regular.ttf"
    }

    Rectangle {
        id: toolBar
        objectName: "tool_bar"
        width: parent.width; height: (applicationData.getDevice()=="ios")?(main_window.height/7):(main_window.height/10)
        color: activePalette.window
        anchors.bottom: main_window.bottom
        Row {
            anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 5

            Rectangle{
                id:spacialRect1
                width:main_window.width/20
                color:"transparent"
                visible:true
                opacity:1
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }

            Button {
                id: btnShoot
                visible:true
                objectName: "btn_shoot"
                anchors { left: spacialRect1.right; verticalCenter: parent.verticalCenter }
                text: ""
                color:"black"
                height: toolBar.height - (toolBar.height/29)
                width: toolBar.height - (toolBar.height/29)
                onClicked: applicationData.shootBullet()
                Image {
                    id: buttonImageShoot
                    source: "../../images/images/meteor1.png"
                    anchors.fill:parent
                }
            }

            Column
            {
                id:distanceRectCol
                width:main_window.width/2.5
                height: parent.height
                visible:true
                opacity:1
                //anchors.left: btnShoot.right
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                Rectangle {
                    id:distanceRect
                    objectName: "distance_rect"
                    width:parent.width// main_window.width/3.5
                    height: parent.height/2
                    //color:"blue"
                    visible:true
                    opacity:1
                    //anchors { left: btnTest2.right; verticalCenter: parent.verticalCenter }
                    anchors.left: parent .left
                    //anchors.verticalCenter: parent.verticalCenter
                    Text {
                        id:distanceLabel
                        //anchors.rightMargin: score
                        anchors.left: parent.left

                        color:"yellow"
                        smooth: true
                        //font.family: "Helvetica"
                        font.pixelSize: (main_window.height*17)/600
                        font.bold: true
                        font.family: webFont.name
                        anchors.verticalCenter: parent.verticalCenter
                        text:"Distance "
                    }

                    Text {
                        id: score
                        anchors.left: distanceLabel.right
                        //anchors.verticalCenter: parent.verticalCenter
                        smooth: true
                        //font.family: "Helvetica"
                        font.family: webFont.name
                        font.pixelSize: (main_window.height*17)/600
                        font.bold: true
                        //color:"white"
                        anchors.verticalCenter: parent.verticalCenter
                        //text: currentDateTime//applicationData.getCurrentDateTime()
                        text:applicationData.distanceTraveled;

                        Component.onCompleted:
                        {
                            //applicationData.distanceTraveled;  // invokes setDistanceTraveled()
                        }

                        Connections {
                            target: applicationData
                            onDataChanged: console.log("The application data changed! ",currentDateTime)
                        }
                    }
                }

                Rectangle {
                    id:scoreRect
                    objectName: "score_rect"
                    //anchors.left: distanceRect.right
                    //color:"red"
                    visible:true
                    opacity:1
                    anchors.top: distanceRect.bottom
                    height: parent.height/2
                    //anchors.left: spacialRect.right
                    //anchors.verticalCenter: parent.verticalCenter
                    Text {
                        id:scoreHeroLabel
                        //anchors.rightMargin: scoreHeroQ.left
                        color:"white"
                        smooth: true
                        font.pixelSize: (main_window.height*17)/600
                        font.bold: true
                        font.family: webFont.name
                        anchors.verticalCenter: parent.verticalCenter
                        text:"Score "
                    }

                    Text {
                        id: scoreHeroQ
                        anchors.left: scoreHeroLabel.right
                        smooth: true
                        font.family: webFont.name
                        font.pixelSize: (main_window.height*17)/Defs.heigtFactor
                        font.bold: true
                        anchors.verticalCenter: parent.verticalCenter
                        text:applicationData.scoreHero;
                    }
                }
            }



            Button {
                id: btnNewGame
                visible:false
                objectName: "btn_newgame"
                anchors { left: parent.left; verticalCenter: parent.verticalCenter }
                text: "New Game"
                onClicked: applicationData.setTheTime()
            }

            Button {
                id: btnTest
                visible:false
                objectName: "btn_test"
                anchors { left: btnNewGame.right; verticalCenter: parent.verticalCenter }
                text: "test"
                onClicked:
                {
                    main_window.qmlSignal2(main_window)
                    applicationData.testMethod2()
                }
            }

            Button {
                signal qmlSignal(string msg)
                id: btnTest2
                visible:false
                objectName: "btn_test2"
                anchors { left: btnTest.right; verticalCenter: parent.verticalCenter }
                text: "test"
                onClicked:
                {
                    btnTest2.qmlSignal("Hello from QML")
                    applicationData.propertyFromCpp()
                }
            }
        }
    }

    function flog(a) {
        console.log("log is ", a);
    }

    Item {
        objectName: "functionItem"
        function myQmlFunction(msg) {
            console.log("Got message:", msg)
            return "some return value"
        }
    }

    function generateRandom()
    {
        return Defs.randomNumber();
    }

    function generateRandomX(randX)
    {
        //console.log("random number is ", a);
        return Defs.randomNumberX(randX);
    }


    SensorGesture {
        id: sensorGesture
        enabled: false
        onDetected:{
            if (gesture !== oldgesture)
                count = 0;

            console.log(gesture + " " + count);
            //valueText.text = gesture + " " + count;
            oldgesture = gesture;
            count++;
        }
        onEnabledChanged: {
            console.log(" ");
        }
        //gestures : ["QtSensors.shake", "QtSensors.SecondCounter"]
    }

    Ship
    {
        id:space_ship
        objectName: "spaceShip"
        scale:0.3
        opacity: 0.3
        visible: true
        x:main_window.width/2
        y:main_window.height-space_ship.height-toolBar.height-11
        z:3
        focus: true

        //GyroscopeReading.onXChanged: space_ship.x = Defs.shipMoveX(true)
        //GyroscopeReading.onYChanged: space_ship.x = Defs.shipMoveY(true)

        Keys.onUpPressed: space_ship.y = Defs.shipMoveY(true)
        Keys.onDownPressed: space_ship.y = Defs.shipMoveY(false)
        Keys.onLeftPressed: space_ship.x = Defs.shipMoveX(true)
        Keys.onRightPressed: space_ship.x = Defs.shipMoveX(false)
    }

    SequentialAnimation {
        id:seqanim
        NumberAnimation {
            target: space_ship;
            properties: "scale"
            from: 0.3;
            to: 1.0;
            duration: 1000
            //running:seqanim.running
        }

        PauseAnimation {
            duration: 10
            //running:seqanim.running

        }

        NumberAnimation {
            target: space_ship;
            properties: "opacity"
            from: 0.3; to: 1.0;
            duration: 1000
            //running:seqanim.running
        }

        running: false
    }

    ParallelAnimation {
        id:paranim
        NumberAnimation {
            //running:paranim.running

            target: space_ship;
            properties: "x"
            from: 1.0;
            to: (main_window.width/2)-(space_ship.width/2);
            duration: 500
        }
        NumberAnimation {
            //running:paranim.running

            target: space_ship;
            properties: "y"
            from: main_window.height/2;
            to: main_window.height-(space_ship.height/space_ship.scale)-toolBar.height-11;
            duration: 500
        }
        running: false
    }

    //not working
    /* PathAnimation {
        duration: 2000
        easing.type: Easing.InOutQuad
        target: space_ship
        orientation: PathAnimation.RightFirst
        anchorPoint: Qt.point(space_ship.width/2,space_ship.height/2)
        path: Path {
            startX: space_ship.width/2
            startY: space_ship.height/2
            PathCubic {
                x: main_window.width - space_ship.width/2
                y: main_window.height - space_ship.height/2
                control1X: space_ship.x;
                control1Y: space_ship.height/2
                control2X: space_ship.width/2;
                control2Y: space_ship.y
            }
        }
    }*/


    /* Accelerometer {
           id: accel
           active: true
           dataRate: 20

           property double pitch: 0.0
           property double roll: 0.0

           onReadingChanged: {
               pitch = -(Math.atan2(reading.x, Math.sqrt(reading.y * reading.y + reading.z * reading.z)) * 180) / Math.PI;
               roll = (Math.atan2(reading.y, Math.sqrt(reading.x * reading.x + reading.z * reading.z)) * 180) / Math.PI;
           }
       }*/

    /*OrientationSensor{
        id:orisens
        active:true

        property bool goingL: true
        property bool goingUp: false

        onReadingChanged: {
                    if (reading.orientation == OrientationReading.TopUp)
                        goingUp=true
                    else if (reading.orientation == OrientationReading.TopDown)
                        goingUp=false
                    else if (reading.orientation == OrientationReading.LeftUp)
                        goingL=true
                    else if (reading.orientation == OrientationReading.RightUp)
                        goingL=false
                    //else if (reading.orientation == OrientationReading.FaceUp)
                    //    content.state = "FaceUp";
                    //else if (reading.orientation == OrientationReading.FaceDown)
                    //    content.state = "FaceDown";
                    //else
                    //    content.state = "";
                }
    }*/

    Accelerometer {
        id: accel
        active: true
        dataRate: 20

        //property double pitch: 0.0
        //property double roll: 0.0

        onReadingChanged: {
            if(reading.x>=0.0)
            {
                accelRectX.width=reading.x*10
                accelRectX.color="yellow"
                accelRectX.x=(main_window.width/3)*2
            }
            else
            {
                accelRectX.width=reading.x*(-10)
                accelRectX.color="red"
                accelRectX.x=((main_window.width/3)*2)-accelRectX.width
            }


            if(reading.z>=0.0)
            {
                accelRectY.height=reading.z*10
                accelRectY.color="yellow"
                accelRectY.y=(main_window.height/3)
            }
            else
            {
                accelRectY.height=reading.z*(-40)
                accelRectY.color="red"
                accelRectY.y=(main_window.height/3)-accelRectY.height
            }

            if((reading.x+reading.z)!=0 && applicationData.getDevice().indexOf("pc") == -1)
            {
                //console.log("x:",reading.x,"   z=",reading.z)
                //console.log("x:",reading.x,"   y=",reading.y)
                //console.log("z:",reading.z,"   y=",reading.y)
                //if(reading.x>0.0)
                space_ship.x = Defs.shipMoveXV(reading.x*(-8))
                //else
                //    space_ship.x = Defs.shipMoveX(false)

                // if(reading.z>1.1)
                space_ship.y = Defs.shipMoveYV(reading.z*(-10))
                //else
                //    space_ship.y = Defs.shipMoveY(false)
                //pitch = -(Math.atan2(reading.x, Math.sqrt(reading.y * reading.y + reading.z * reading.z)) * 180) / Math.PI;
                //roll = (Math.atan2(reading.y, Math.sqrt(reading.x * reading.x + reading.z * reading.z)) * 180) / Math.PI;
            }
        }
    }

    property double accelHubPosX: (width/3)*2
    property double accelHubPosY: (height/3)

    Rectangle {
        id:accelRectX
        width: 50
        height: 2
        x:accelHubPosX
        y:accelHubPosY
        opacity: 1
        visible: (applicationData.getDevice()=="android" ||applicationData.getDevice()=="blackberry")?true:false
        color:"yellow"
    }

    Rectangle {
        id:accelRectY
        width: 2
        height: 50
        x:accelHubPosX
        y:accelHubPosY
        opacity: 1
        visible: (applicationData.getDevice()=="android" ||applicationData.getDevice()=="blackberry")?true:false
        color:"yellow"
    }


    Rectangle {
        id:joyRect
        width: 0
        height: 0
        x:0
        y:0
        opacity: 1
        visible: true
        color:"red"
    }

    //must stop the thread on destroy
    Component.onDestruction: {
        applicationData.stopThread()
    }

    Connections {
        target: applicationData
        onScreenSizeChanged: console.log("*-*-*-*-*-*-*-*-*-*-**--**-*-*-*-*-*RESIZE*-*-*-*-*-*-*-*-*-**-*-*-*-*-*"+width+" "+height)
    }


    /*Timer {
        id:timerShipMove
        interval: 50;
        running: true;
        repeat: true
        onTriggered: {
            //if(orisens.goingL)
                //space_ship.x = Defs.shipMoveX(orisens.goingL)
            //else if (orisens.reading.orientation == OrientationReading.RightUp)
                //space_ship.y = Defs.shipMoveY(orisens.goingUp)
        }
    }*/

    /*    Gyroscope{
        id:gyro
        active:true

        property double posXg: 0.0
        property double posYg: 0.0

        onReadingChanged: {
            if (reading.x>posXg)
            {
                space_ship.x = Defs.shipMoveX(true)
            }
            else
            {
                space_ship.x = Defs.shipMoveX(false)
            }

            posXg=reading.x
            posYg=reading.y
        }
    }*/
}



/*Rectangle {
    width: 360
    height: 360
    Text {
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }
}*/
