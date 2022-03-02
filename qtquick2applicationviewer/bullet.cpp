#include "bullet.h"
#include <QQmlEngine>
#include <QQmlComponent>
#include <QDebug>

void Bullet::initialize(QQuickView *mainItem)
{
    //setAvailable(true);
    //setVisible(true);
    //mainItemL=mainItem;

    //QUrl finalUrl = (QUrl(QLatin1String("assets:/")+"qml/androidqml/Bullet.qml"));
    QUrl finalUrl = (QUrl("qrc:///qml/SpaceSheepMobile/Bullet.qml"));

    qDebug() <<"meteor: "<< finalUrl;
    QQmlComponent component(mainItem->engine(),finalUrl);
    //QQmlComponent component(mainItem->engine(),QUrl::fromLocalFile("assets:/qml/androidqml/Bullet.qml"));
    if(component.isReady())
    {
         qDebug() <<"component.isReady(: "<< finalUrl;
        QObject *myObject = component.create();
        QQuickItem *bullet = qobject_cast<QQuickItem*>(myObject);
        bullet->setParentItem(this);
        this->setParentItem(qobject_cast<QQuickItem*>(mainItem->rootObject()));

        /*laserSound=new QSound("qrc:///audio/audio/blast.au");
        hitSound=new QSound("qrc:///audio//audio/move.wav");*/
        laserSound=new QSoundEffect;
        laserSound->setSource(QUrl("qrc:///audio/audio/baseball_hit1.wav"));
        hitSound=new QSoundEffect;
        hitSound->setSource(QUrl("qrc:///audio/audio/bad_disk_x1.wav"));
    }
}

void Bullet::shoot()
{
    timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(updatePosition()));
    timer->start(10);
    if(laserSound!=NULL)
        laserSound->play();
}

void Bullet::reshoot(const double newX,const double newY)
{
    setOpacity(1);
    setX(newX);
    setY(newY);

    if(laserSound!=NULL)
        laserSound->play();
}

Bullet::Bullet(QQuickView *mainItem) //: QQuickView(parent)
{  

    initialize(mainItem);
    // add the new created meteor to the list
    //meteorList.append(item);
}

Bullet::Bullet(QQuickView *mainItem,double x,double y)
{
    initialize(mainItem);
    this->setX(x);
    this->setY(y);

    shoot();
}

Bullet::~Bullet()
{
   // delete bullet;
}


void Bullet::updatePosition()
{
   // if(getVisible()&&getAvailable())
   // {
        double newY=this->y()-6;
        if(newY<=0)
        {
            //setVisible(false);
            //setAvailable(false);
            //qDebug()<<"opacity zero";
            this->setOpacity(0);
        }
        else
        {
            //setOpacity(1);
            this->setY(newY);
        }
    //}
}

bool Bullet::collision(const double metX,const double metY,const double metW,const double metH)
{
    if(
            this->x() > metX &&
            this->x() <metX+metW &&
            this->x()+this->width() > metX &&
            this->x()+this->width() < metX+metW &&
            this->y()+this->height()>=metY &&
            this->y() < metY+metH)
    {
        if(hitSound!=NULL)
             hitSound->play();
        return true;
    }
    return false;
}

void Bullet::AddToView(QQuickItem *mainView)
{
    this->setParentItem(mainView);
}

//setter getter
bool Bullet::available() const
{
    return available_;
}

void Bullet::setAvailable(const bool newValue)
{
    available_=newValue;
}

bool Bullet::visible() const
{
    return visible_;
}

void Bullet::setVisible(const bool newValue)
{
    visible_=newValue;
}
