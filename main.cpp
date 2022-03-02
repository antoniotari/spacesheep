#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer/qtquick2applicationviewer.h"
#include <QQuickView>
#include <QQmlContext>
#include "qtquick2applicationviewer/mainview.h"
#include <QUrl>
#include <QQuickView>
#include <QQuickItem>
#include <QDebug>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQmlProperty>
#include "qtquick2applicationviewer/global.h"

int main(int argc, char *argv[])
{
    //initialize the game variables
    Global::InitializeGame();

    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    viewer.rootContext()->setContextProperty("applicationData", &viewer);
    viewer.setMainQmlFile(QStringLiteral("qml/SpaceSheepMobile/main.qml"));
    viewer.showExpanded();
    //viewer.showFullScreen();
    viewer.setMainView();

    return app.exec();
}
