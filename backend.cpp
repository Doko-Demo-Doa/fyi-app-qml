#include <windows.h>
#include <QFileDialog>
#include <QMessageBox>
#include <string.h>
#include "backend.h"

Backend::Backend(QObject *parent) : QObject(parent)
{
}

QString Backend::newSource()
{
    return m_newSource;
}

// Not in use, for now.
wchar_t *convertCharArrayToLPCWSTR(const char *charArray)
{
    wchar_t *wString = new wchar_t[4096];
    MultiByteToWideChar(CP_ACP, 0, charArray, -1, wString, 4096);
    return wString;
}

void Backend::openFileDialog()
{
    QString filename =  QFileDialog::getOpenFileName(
          nullptr,
          "Open video",
          QDir::currentPath(),
          "Video files (*.mkv *.mp4 *.avi)");

    if( !filename.isNull() )
    {
      setNewSource(filename.toUtf8());
    }
}

// Signal: https://doc.qt.io/qt-5/qtqml-cppintegration-topic.html
void Backend::setNewSource(const QString &newSource)
{
    if (newSource == m_newSource)
           return;

       m_newSource = newSource;
       emit mediaSourceChanged();
}
