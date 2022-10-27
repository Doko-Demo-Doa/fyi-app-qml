#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>
#include <qqml.h>
#include <windows.h>
#include <string.h>

class Backend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString newSource READ newSource WRITE setNewSource NOTIFY mediaSourceChanged)
    QML_ELEMENT

public:
    explicit Backend(QObject *parent = nullptr);

    QString newSource();
    void setNewSource(const QString &newSource);

    Q_INVOKABLE void openFileDialog();

signals:
    void mediaSourceChanged();

private:
    QString m_newSource;
};

#endif // BACKEND_H
