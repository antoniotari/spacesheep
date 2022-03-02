#ifndef THREADTEST_H
#define THREADTEST_H

#include <QThread>
#include "qtquick2applicationviewer/global.h"
#include <QTimer>

class ThreadTest : public QThread
{
    Q_OBJECT
public:
    explicit ThreadTest(QObject *parent = 0);
    int timerTimeout(const int coeff=1000);

protected:
    void run();

    bool _running;

private:
    QTimer timer;


signals:
    void updateInterface();

private slots:
    void doWork();

public slots:
    
};



#endif // THREADTEST_H
