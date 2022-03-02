// checksum 0xfde6 version 0x90005
/*
  This file was generated by the Qt Quick 2 Application wizard of Qt Creator.
  QtQuick2ApplicationViewer is a convenience class containing mobile device specific
  code such as screen orientation handling. Also QML paths and debugging are
  handled here.
  It is recommended not to modify this file, since newer versions of Qt Creator
  may offer an updated version of it.
*/

#ifndef QTQUICK2APPLICATIONVIEWER_H
#define QTQUICK2APPLICATIONVIEWER_H

#include <QtQuick/QQuickView>
#include "global.h"
#include <QDateTime>
#include <QDebug>
#include <QUrl>
#include <QQmlProperty>
#include <QQuickItem>
#include <QQuickView>
//#include <QtMultimedia/QSound>
#include <QSoundEffect>
#include <QtMultimedia/QMediaPlayer>
#include "bullet.h"
#include <QSoundEffect>
#include "threadtest.h"
#include <QTest>

class QtQuick2ApplicationViewer : public QQuickView
{
    Q_OBJECT
    Q_PROPERTY(int distanceTraveled READ distanceTraveled WRITE setDistanceTraveled NOTIFY distanceTraveledChanged) //this is readable from qml
    Q_PROPERTY(int scoreHero READ scoreHero WRITE setScoreHero NOTIFY scoreHeroChanged) //this is readable from qml


public:
    explicit QtQuick2ApplicationViewer(QWindow *parent = 0);
    virtual ~QtQuick2ApplicationViewer();

    void setMainQmlFile(const QString &file);
    void addImportPath(const QString &path);
    void showExpanded();
    void setMainView();//(QQuickView *v);
    Q_INVOKABLE void shootBullet();

    void InvocQmlFunctions();

    Q_INVOKABLE void setTheTime();
    Q_INVOKABLE void testMethod(const QString &msg);
    Q_INVOKABLE void testMethod2();
    Q_INVOKABLE QDateTime getCurrentDateTime() const
    {
        return QDateTime::currentDateTime();
    }
    Q_INVOKABLE void propertyFromCpp();

    //returns what kind of device we are running on
    Q_INVOKABLE QString getDevice();
    //stop the thread on close app
    Q_INVOKABLE QString stopThread();

    void createMeteor();

    //getter setter for function readable from qml
    void setDistanceTraveled(const int a)
    {
        if (a != m_distance)
        {
            m_distance = a;
            emit distanceTraveledChanged();
        }
    }

    int distanceTraveled() const
    {
        return m_distance;
    }

    //getter setter for function readable from qml
    void setScoreHero(const int a)
    {
        if (a != Global::score)
        {
            Global::score = a;
            emit scoreHeroChanged();
        }
    }

    int scoreHero() const
    {
        return Global::score;
    }

private:
    class QtQuick2ApplicationViewerPrivate *d;
    int m_distance;
    int m_scoreHero;

    ThreadTest *thread;

    qreal GenerateRandom(qreal x);
    qreal GenerateRandom();

    //QQuickView *view;
    QQuickItem *mainItem;
    QQuickItem *spaceShip;
    QObject *mainObject;

    QList<QQuickItem*> meteorList;
    QList<Bullet*> bulletList;
    QMediaPlayer *player;
    QMediaPlaylist *palylist;
    QSoundEffect *weaponBoom;

    bool event(QEvent *e) Q_DECL_OVERRIDE
    {
        int type = e->type();
        //qDebug() << "Got an event of type" << type;
        if (type == QEvent::GraphicsSceneResize)
        {
            emit(screenSizeChanged());
            //qDebug() << "Got an event of type" << type<<"*-*-*-*-*-*-*-*-*-*-**--**-*-*-*-*-*RESIZE";
        }

        if (type == QEvent::Close)
            stopThread();
        return QQuickView::event(e);
    }

signals:
    void dataChanged();
    void distanceTraveledChanged();
    void scoreHeroChanged();
    void screenSizeChanged();

public slots:
    void gameLoop();
    //void generateMeteor();

    void cppSlot(const QString &msg)
    {
        qDebug() << "Called the C++ slot with message:" << msg;
    }

    void cppSlot2(const QVariant &v);
};



#endif // QTQUICK2APPLICATIONVIEWER_H
