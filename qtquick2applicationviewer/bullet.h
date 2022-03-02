#ifndef BULLET_H
#define BULLET_H

#include <QQuickItem>
#include <QQuickView>
#include <QTimer>
//#include <QtMultimedia/QSound>
#include <QSoundEffect>

class Bullet : public QQuickItem
{
    Q_OBJECT
public:
    Bullet( QQuickView *mainItem=0);
    Bullet(QQuickView *mainItem,double x,double y);

    ~Bullet();
    void AddToView(QQuickItem *mainView);
    bool collision(const double metX, const double metY, const double metW, const double metH);
    void reshoot(const double newX,const double newY);

    bool available() const;
    bool visible() const;
    void setAvailable(const bool);
    void setVisible(const bool);

private:
    void initialize(QQuickView *mainItem);
    void shoot();

    //QQuickItem *mainItemL;
    QTimer *timer;
    QSoundEffect *laserSound;
    QSoundEffect *hitSound;

    bool available_;
    bool visible_;

signals:

    
public slots:
    void updatePosition();
};

#endif // BULLET_H
