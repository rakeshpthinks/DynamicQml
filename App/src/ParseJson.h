#ifndef PARSEJSON_H
#define PARSEJSON_H

#include <QObject>

class ParseJson : public QObject
{
    Q_OBJECT
public:
    explicit ParseJson(const QString jsonFilePath = QString(),QObject *parent = nullptr);
    bool parseAndGenerateQml(const QString &outputQmlPath);
signals:

private:
    QString m_jsonFilePath;
    QString parseWindow(const QJsonObject &windowObject);
    bool saveQmlToFile(const QString &qmlContent, const QString &outputQmlPath);
    QString parseComponent(const QJsonObject &componentObject);
    QString parseLayout(const QJsonObject & layoutObject);
    QString parseTab(const QJsonArray &tabObjects);
    QString formatJsonValue(const QJsonValue& value);
};

#endif // PARSEJSON_H
