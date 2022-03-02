#include "global.h"

Global::Global(QObject *parent) :QObject(parent)
{
    ingame=false;
    gamealive=true;
    trackscore=true;
    spashscreenswitch=true;
    pause=false;
    dx=0;
    dy=0;shield=0;
    line1=-90;
    line2=-90;
    distance=0;
    maxdist=2000;
    rcnt=0;
    enemySpeedCoeff=0;
    speedCoeff=6;
    numStars=30;
    speed=11;
    rndcnt=1111;
}

int Global::difficultylevel;
bool Global::pause;
int Global::startTimeoutThread;
int Global::score;

void Global::InitializeGame()
{
    Global::difficultylevel=0;
    Global::pause=false;
    Global::startTimeoutThread=11000;
    Global::score=0;
}


const QString Global::device()
{
    QString *retS;
#if defined(Q_OS_IOS)
    retS=new QString("ios");
#elif defined(Q_OS_MAC)
    retS=new QString("macpc");
#elif defined(Q_OS_BLACKBERRY)
    retS=new QString("blackberry");
#elif defined(Q_OS_ANDROID)
    retS=new QString("android");
#elif defined(Q_OS_ANDROID_NO_SDK)
    retS=new QString("android");
#elif defined(Q_OS_LINUX)
    retS=new QString("linuxpc");
#else
    retS=new QString("windowspc");
#endif

    return *retS;
}
