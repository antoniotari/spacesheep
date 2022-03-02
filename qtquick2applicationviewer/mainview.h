#include "qtquick2applicationviewer.h"
#include "global.h"
#include <QDateTime>

#ifndef MAINVIEW_H
#define MAINVIEW_H

class MainView : public QtQuick2ApplicationViewer
{
public:
    explicit MainView(QQuickView *parent = 0);
private:
    Global *global;

};

#endif // MAINVIEW_H
