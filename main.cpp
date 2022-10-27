#include <Windows.h>
#include <QApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QMessageBox>
#include <QtCore/QCommandLineParser>
#include <QtCore/QCommandLineOption>
#include <QtCore/QDir>
#include <QSharedMemory>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);
    QSharedMemory sharedMemory;

    // https://stackoverflow.com/questions/34445164/qt5-preventing-another-instance-of-the-application-doesnt-work-anymore
    sharedMemory.setKey("fyi-memory-key");
    if (sharedMemory.create(1) == false)
    {
        QMessageBox::warning(NULL, "Info", "Another instance of the app is already running.");
        app.exit();
        return 0;
    }

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    // https://learn.microsoft.com/vi-vn/windows/win32/api/winbase/nf-winbase-setthreadexecutionstate?redirectedfrom=MSDN
    SetThreadExecutionState(ES_CONTINUOUS | ES_SYSTEM_REQUIRED | ES_AWAYMODE_REQUIRED);
    int resp = app.exec();

    // Reset the state and allow the system to sleep normally:
    SetThreadExecutionState(ES_CONTINUOUS);

    return resp;
}
