#ifndef GLOBAL_H
#define GLOBAL_H

#include <QObject>
#include "defs.h"

class Global : public QObject
{
    Q_OBJECT
private:

public:
    explicit Global(QObject *parent = 0);
    static void InitializeGame();

    static const QString device();

    long bestscore;
    static int difficultylevel;
    static bool pause;
    static int startTimeoutThread;
    static int score;

    bool ingame;
    bool gamealive;
    bool trackscore;
    bool spashscreenswitch;


    int x,y,mousex,mousey;
    int oldx,oldy,dx,dy,count,shield;
    int line1;
    int line2;
    int	distance,maxdist; // the distance,needed to switch level
    int	shieldlevel; //how strong shield coefficient
    int bulletlevel; //how many bullets coefficient
    int	shieldmax; // max strenght of shield, set in gamestart()
    int bulletmax; // max number of bullets, set in gamestart()
    int	shieldcurrent; // current value of the shield
    int bulletcurrent; // current number of bullets
    int renew;
    int rcnt, sstretch;
    //long score;

    int* bx; // bx and by are the position of the bullet
    int* by;

    int* frameMeteorCount;
    bool* clockWiseRotation;
    int	enemymax; // number of max enemies possible on screen
    int enemycount, mtotal,mrenew, enemySpeedCoeff;
    int* metx;
    int* mety;
    int* metf;
    bool* metr;
    int* rotationSpeed;
    int speedCoeff;

    // the Highway
    int* starsX;
    int* starsY;
    int numStars;
    int speed;	//speed the background moves

    int	rndbx, rndby; //position of the explosion x and y
    int rndcnt; // random number, should be bigger than bframes

    signals:
    
public slots:
    
};

#endif // GLOBAL_H
