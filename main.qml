import QtQuick 2.15
import QtQuick.Layouts 1.11
import QtQuick.Window 2.15
import QtQuick.Controls 2.0
import QtMultimedia 5.15
import QtQuick.Extras 1.4

import io.qt.examples.backend 1.0

// More about slots: https://subscription.packtpub.com/book/application-development/9781784394615/1/ch01lvl1sec13/connecting-c-slots-to-qml-signals
ApplicationWindow {
    id: root
    width: 300
    height: 480
    visible: true
    title: qsTr("FYI QML")

    Backend {
        id: backend
        onMediaSourceChanged: {
            player.source = backend.newSource
            player.stop()
            player.play()
        }
    }

    property int margin: 12

    Component.onCompleted: {
        width = mainLayout.implicitWidth + 2 * margin
        height = mainLayout.implicitHeight + 2 * margin
    }
    minimumWidth: mainLayout.Layout.minimumWidth + 2 * margin
    minimumHeight: mainLayout.Layout.minimumHeight + 2 * margin

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        Layout.fillWidth: true
        Layout.minimumWidth: 860
        Layout.minimumHeight: 480
        anchors.margins: root.margin

        Rectangle {
            color: "#000"
            anchors.fill: parent
            Layout.fillWidth: true
            Layout.fillHeight: true

            MediaPlayer {
                id: player
                objectName: "player"
                autoPlay: false
                onPlaying: {
                    playButton.text = "Pause"
                }
                onPaused: {
                    playButton.text = "Play"
                }
            }

            VideoOutput {
                anchors.fill: parent
                anchors.verticalCenter: parent.verticalCenter
                Layout.preferredHeight: 860
                Layout.preferredWidth: 480
                source: player
            }
        }

        Rectangle {
            color: "white"
            Layout.preferredHeight: 64
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            RowLayout {
                id: rowLayout
                anchors.fill: parent
                anchors.leftMargin: 14
                anchors.rightMargin: 14
                Layout.fillWidth: true
                Layout.leftMargin: 12
                anchors.bottomMargin: 24

                Button {
                    id: playButton
                    text: "Play"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 90
                    onClicked: {
                        player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()
                    }
                }

                Button {
                    id: openFileButton
                    text: "Open File..."
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 90
                    onClicked: {
                        backend.openFileDialog()
                    }
                }

                Slider {
                    id: control
                    value: player.position / player.duration
                    onMoved: {
                        player.seek(value * player.duration)
                    }

                    background: Rectangle {
                        x: control.leftPadding
                        y: control.topPadding + control.availableHeight / 2 - height / 2
                        implicitWidth: 200
                        implicitHeight: 4
                        width: control.availableWidth
                        height: implicitHeight
                        radius: 2
                        color: "#bdbebf"

                        Rectangle {
                            width: control.visualPosition * parent.width
                            height: parent.height
                            color: "#21be2b"
                            radius: 2
                        }
                    }

                    handle: Rectangle {
                        x: control.leftPadding + control.visualPosition
                           * (control.availableWidth - width)
                        y: control.topPadding + control.availableHeight / 2 - height / 2
                        implicitWidth: 26
                        implicitHeight: 26
                        radius: 13
                        color: control.pressed ? "#f0f0f0" : "#f6f6f6"
                        border.color: "#bdbebf"
                    }
                    anchors.verticalCenter: parent.verticalCenter
                    Layout.fillWidth: true
                }
            }
        }
    }
}
