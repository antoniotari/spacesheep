import QtQuick 2.1
import "defs.js" as Defs
import QtQuick.Particles 2.0

Item{
    id:sprite
    property int rotationSpeed: 5
    property int meteorSpeed: 1
    opacity: 0
    property bool isActive: false
    width: Defs.sxmet
    height: Defs.symet
    z:2;
    //x:Defs.randomNumber()
    y:30

    clip: true
    property alias running: timer.running;
    property int frame:0
    property int frameCount: Defs.frameMeteor;

    property double randomizeNumb;

    Rectangle
    {
        anchors.centerIn: parent
        color:"transparent"
        id:meteorRectangle
        objectName:"meteor_rectangle"
        width:sprite.width-144// Defs.scaledDim(Defs.sxmet,parent.height)-144
        height:sprite.height-144// Defs.scaledDim(Defs.symet,parent.height)-144
        Image{
            anchors.fill: parent
            id:metImage
            source:"../../images/images/meteor"+sprite.frame+".png"
                //"assets:/images/meteor"+sprite.frame+".png"

            RotationAnimation on rotation {
                id:rotationanimation
                //from: parent.rotation; to: parent.rotation+11
                direction: RotationAnimation.Counterclockwise
                duration: sprite.rotationSpeed*10
            }

            Timer {
                id:timer3
                interval: sprite.rotationSpeed*10;
                running: true;
                repeat: true
                onTriggered: {
                    parent.rotation-=(360/5)
                }
            }
        }

        //on clicking the meteor it explodes
        /*MouseArea {
            anchors.fill: parent
            onClicked: {
                sprite.dying=true
            }
        }*/
    }

    Timer {
        id:timer
        interval: 10*sprite.rotationSpeed; running: true; repeat: true
        onTriggered: {
            sprite.nextFrame();
            //metImage.source="../../images/meteor"+frame+".png"
        }
    }

    //timer for generating the meteor
    Timer {
        id:timerBorn
        objectName: "timer_born"
        interval: Defs.randomRebornTime(3200);
        running: false;
        repeat: false
        onTriggered: {
            sprite.setOpacityMax()
        }
    }

    function createMeteor(windowWidth)
    {
        randomizeNumb=windowWidth;
        timerBorn.running=true;
    }

    function setOpacityMax()
    {
        sprite.y=-(sprite.height-meteorRectangle.height)
        sprite.x=Defs.randomRebornX(randomizeNumb);
        sprite.rotationSpeed=Defs.randomNumberX(30)+1
        sprite.meteorSpeed=Defs.randomNumberX(3)+1
        timerBorn.running=false;
        sprite.isActive=true;
        sprite.dying=false;

        sprite.opacity=1;
    }

    function nextFrame() {
        sprite.frame = ++sprite.frame  % sprite.frameCount
    }

    function explode()
    {
        dying=true;
    }

    property bool dying: false
    states: [
        State {
            name: "AliveState"
            when: dying == false && isActive
            PropertyChanges { target: metImage; opacity: 1 }
            //StateChangeScript { script: timerBorn.running=true; }
        },

        State {
            name: "DeathState"
            when: dying == true
            StateChangeScript { script: particles.burst(50); }
            //StateChangeScript { script: timer.running=false; }
            PropertyChanges { target: metImage; opacity: 0 }
            StateChangeScript { script: sprite.isActive=false;}//sprite.destroy(9000); }//
            //StateChangeScript { script: sprite.isBorning=true;}
        }
    ]

    ParticleSystem {
        id: sys
        anchors.centerIn: parent
        ImageParticle {
            source: "../../images/images/meteor"+sprite.frame+".png"
            rotationVelocityVariation: 360
        }

        Emitter {
            id: particles
            anchors.centerIn: parent
            emitRate: 0
            lifeSpan: 700
            velocity: AngleDirection {angleVariation: 360; magnitude: 80; magnitudeVariation: 40}
            size: 32
        }
    }
}
