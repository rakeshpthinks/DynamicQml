#include "Application.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qdir.h>
int main(int argc, char *argv[])
{
    Application app(argc, argv);


    return app.exec();

}
