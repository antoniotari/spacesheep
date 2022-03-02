#include "threadtest.h"
//#include <QTest>
#include <QDebug>
//-------------------------------------------------------------

ThreadTest::ThreadTest(QObject *parent):QThread(parent)
{

}

//-------------------------------------------------------------

void ThreadTest::run()
{
    if(Global::device().compare("ios")!=0 && Global::device().compare("android")!=0)
    {
        connect(&timer, SIGNAL(timeout()), this, SLOT(doWork()));
        timer.start(timerTimeout());
        exec();
    }
    else
    {
        _running=true;
        while(_running)
        {
            //QTest::qSleep( 30 );
            int coeff=1000;
            QThread::usleep(Global::startTimeoutThread-((Global::difficultylevel>=((Global::startTimeoutThread)/coeff)-1)?Global::startTimeoutThread-coeff:Global::difficultylevel*coeff));
            emit(updateInterface());
        }
    }
}

//-------------------------------------------------------------

void ThreadTest::doWork()
{
    //qDebug()<<"timerTimeout()"<<timerTimeout();
    if(timer.interval() != timerTimeout())
        timer.setInterval(timerTimeout());
    emit(updateInterface());
}

//-------------------------------------------------------------

int ThreadTest::timerTimeout(const int coeff)
{
    return (Global::startTimeoutThread-((Global::difficultylevel>=((Global::startTimeoutThread)/coeff)-1)?Global::startTimeoutThread-coeff:Global::difficultylevel*coeff))/1000;
}

//-------------------------------------------------------------
