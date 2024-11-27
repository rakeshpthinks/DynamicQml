#ifndef APPLICATION_H
#define APPLICATION_H
#include "ParseJson.h"
#include <QApplication>
#include<QDebug>
#include <qqmlapplicationengine.h>
class Application: public QApplication
{
    Q_OBJECT
public:
    explicit Application(int &argc, char **argv);

private:
    std::unique_ptr<ParseJson> m_parseJson;
    std::unique_ptr<QQmlApplicationEngine> m_engine;
    void init();
};

#endif // APPLICATION_H
