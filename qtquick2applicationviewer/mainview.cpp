#include "mainview.h"
#include <QDebug>


// implicitly call the superclass constructore with argument parent
MainView::MainView(QQuickView *parent): QtQuick2ApplicationViewer(parent)
{
    global=new Global();
}

//destructor not needed, the superclass destructor will be calle automatically
//MainView::~MainView(){}


