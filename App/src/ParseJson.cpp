#include "ParseJson.h"
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QTextStream>
#include <QDebug>
#include <QDir>
ParseJson::ParseJson(const QString jsonFilePath, QObject *parent ) : QObject{parent}, m_jsonFilePath(jsonFilePath)
{
    qDebug()<<Q_FUNC_INFO<<"Inside Constructor"<<Qt::endl;
}

bool ParseJson::parseAndGenerateQml(const QString &outputQmlPath)
{
    QFile file(m_jsonFilePath);
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning()<<"Failed to open JSON File: "<< m_jsonFilePath;
        return false;
    }
    QByteArray jsonData = file.readAll();
    file.close();

    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonData);

    if (jsonDoc.isNull() || !jsonDoc.isObject()) {
        qWarning()<<"Invalid JSON format in file: "<<m_jsonFilePath;
        return false;
    }
    QJsonObject jsonObj = jsonDoc.object();

    QJsonObject windowObject = jsonObj.value("Window").toObject();


    QString result = parseWindow(windowObject);

    qDebug()<< result;

    this->saveQmlToFile(result, outputQmlPath);

    // qDebug()<< qml;
    return true;
}

QString ParseJson::generateQmlContent(const QJsonObject &jsonObj)
{
    QString qmlContent;
    QTextStream stream(&qmlContent);

    QJsonObject windowObject = jsonObj.value("Window").toObject();
    QString windowTitle = windowObject.value("title").toString();
    int windowWidth = windowObject.value("width").toInt();
    int windowHeight = windowObject.value("height").toInt();

    // Start generating QML
    stream << "import QtQuick 2.15\n";
    stream << "import QtQuick.Controls 2.15\n\n";
    stream << "import QtQuick.Layouts 2.15\n\n";
    stream << "ApplicationWindow {\n";
    stream << "    id: root\n";
    stream << "    visible: true\n";
    stream << "    title: \"" << windowTitle << "\"\n";
    stream << "    width: " << windowWidth << "\n";
    stream << "    height: " << windowHeight << "\n\n";

    stream << "    ColumnLayout {\n";
    stream << "        anchors.fill: parent\n";
    stream << "        spacing: 10\n\n";

    // Process components
    QJsonArray componentsArray = windowObject.value("components").toArray();
    for (const QJsonValue &componentValue : componentsArray) {
        QJsonObject componentObject = componentValue.toObject();
        QString componentType = componentObject.value("type").toString();
        QJsonObject propertiesObject = componentObject.value("properties").toObject();

        stream << "        " << componentType << " {\n";
        for (const QString &key : propertiesObject.keys()) {
            QJsonValue propertyValue = propertiesObject.value(key);

            // Handle different property types
            if (propertyValue.isString()) {
                stream << "            " << key << ": \"" << propertyValue.toString() << "\"\n";
            } else if (propertyValue.isDouble()) {
                stream << "            " << key << ": " << propertyValue.toDouble() << "\n"; // Convert numeric values
            } else if (propertyValue.isBool()) {
                stream << "            " << key << ": " << (propertyValue.toBool() ? "true" : "false") << "\n";
            } else {
                stream << "            // Unknown type for key: " << key << "\n"; // Add a placeholder for debugging
            }
        }

        stream << "        }\n\n";
    }

    stream << "    }\n"; // Close ColumnLayout
    stream << "}\n";     // Close ApplicationWindow

    return qmlContent;
}

QString ParseJson::parseWindow(const QJsonObject &windowObject)
{
    QString qml = "import QtQuick 2.15\n"
                  "import QtQuick.Controls 2.15\n"
                  "import QtQuick.Layouts 1.15\n\n"
                  "ApplicationWindow {\n";

    if (windowObject.contains("width")) {
        qml += QString("    width: %1\n").arg(windowObject["width"].toInt());
    }
    if (windowObject.contains("height")) {
        qml += QString("    height: %1\n").arg(windowObject["height"].toInt());
    }
    if (windowObject.contains("title")) {
        qml += QString("    title: \"%1\"\n").arg(windowObject["title"].toString());
    }

    qml += "    visible: true\n\n";
    qml += parseTab(windowObject["tabs"].toArray());
    qml += "}\n";

    return qml;
}


bool ParseJson::saveQmlToFile(const QString &qmlContent, const QString &outputQmlPath)
{

    // Ensure the directory exists
    QFileInfo fileInfo(outputQmlPath);
    QDir dir = fileInfo.absoluteDir();
    if (!dir.exists() && !dir.mkpath(".")) {
        qWarning() << "Failed to create directory:" << dir.absolutePath();
        return false;
    }

    QFile outputFile(outputQmlPath);
    if (!outputFile.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qWarning() << "Failed to open output QML file for writing:" << outputQmlPath;
        return false;
    }

    QTextStream outStream(&outputFile);
    outStream << qmlContent;
    outputFile.close();
    return true;


}

QString ParseJson::parseComponent(const QJsonObject &componentObject)
{
    QString qml;

    if (!componentObject.contains("type") || !componentObject.contains("properties"))
        return qml;
    QString type = componentObject["type"].toString();
    qml += QString("                    %1 {\n").arg(type);
    QJsonObject properties = componentObject["properties"].toObject();
    for (const QString& key : properties.keys()) {
        QJsonValue value = properties[key];

        // Handle different value types
        QString valueString;
        if (value.isString()) {
            valueString = QString("\"%1\"").arg(value.toString());
        } else if (value.isDouble()) {
            // Handle integer and floating-point values
            valueString = QString::number(value.toDouble());
        } else if (value.isBool()) {
            valueString = value.toBool() ? "true" : "false";
        } else {
            qWarning() << "Unhandled property type for key:" << key << "in component:" << componentObject;
            continue;
        }

        qml += QString("                        %1: %2\n").arg(key, valueString);

    }
    qml += "                    }\n";
    return qml;
}

QString ParseJson::parseLayout(const QJsonObject &tabObject)
{
    QString layoutType = tabObject["layout"].toString();
    QString layoutQml = QString("            %1 {\n").arg(layoutType);

    if (tabObject.contains("layoutProperties")) {
        QJsonObject layoutProperties = tabObject["layoutProperties"].toObject();

        for (const QString& key : layoutProperties.keys()) {
            QJsonValue value = layoutProperties[key];

            QString valueString;
            if (value.isString()) {
                valueString = QString("\"%1\"").arg(value.toString());
            } else if (value.isDouble()) {
                valueString = QString::number(value.toDouble());
            } else if (value.isBool()) {
                valueString = value.toBool() ? "true" : "false";
            } else {
                qWarning() << "Unhandled layout property type for key:" << key;
                continue;
            }

            layoutQml += QString("                %1: %2\n").arg(key, valueString);
        }
    }


    // Add components if present
    if (!tabObject.contains("components") || !tabObject["components"].isArray()) {
        qWarning() << "No components specified in layout for tab:" << tabObject;
        return layoutQml + "                }\n";
    }

    QJsonArray components = tabObject["components"].toArray();
    for (const auto& comp : components) {
        layoutQml += parseComponent(comp.toObject());
    }

    layoutQml += "                }\n";
    return layoutQml;
}

QString ParseJson::parseTab(const QJsonArray &tabsArray)
{
    QString qml = "    ColumnLayout {\n"
                  "        anchors.fill: parent\n\n"
                  "        TabBar {\n"
                  "            id: tabBar\n"
                  "            Layout.fillWidth: true\n";

    for (int i = 0; i < tabsArray.size(); ++i) {
        const QJsonObject tab = tabsArray[i].toObject();
        qml += QString("            TabButton {\n"
                       "                text: \"%1\"\n"
                       "                onClicked: contentStack.currentIndex = %2\n"
                       "            }\n")
                   .arg(tab["title"].toString())
                   .arg(i);
    }

    qml += "        }\n\n"
           "        StackLayout {\n"
           "            id: contentStack\n"
           "            Layout.fillWidth: true\n"
           "            Layout.fillHeight: true\n\n";

    for (const auto& tab : tabsArray) {
        qml += "            Item {\n";
        qml += parseLayout(tab.toObject());
        qml += "            }\n";
    }

    qml += "        }\n"
           "    }\n";

    return qml;

}
