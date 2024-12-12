#include "Application.h"

#include <QQmlContext>
Application::Application(int &argc, char **argv) :QApplication(argc,argv),
    m_engine(std::make_unique<QQmlApplicationEngine>(this)),
    m_parseJson(std::make_unique<ParseJson>(QCoreApplication::applicationDirPath() + "/Jsons/config.json"))
{
    qDebug()<<Q_FUNC_INFO;
    QCoreApplication::setApplicationName("DynamicQmlApp");
    QCoreApplication::setApplicationVersion("v1.0.0");
    this->init();
    qInfo() << qApp->applicationName() << qApp->applicationVersion();
    m_engine.get()->load(QCoreApplication::applicationDirPath() + "/resources/qml/main.qml");
}

void Application::init()
{
    m_parseJson.get()->
        parseAndGenerateQml(QCoreApplication::applicationDirPath() + "/resources/qml/main.qml");
}
