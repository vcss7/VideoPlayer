import QtQuick 2.0

Rectangle {
    id: root
    width: 40
    height: 40
    radius: 20
    color: "white"

    Image {
        id: playPauseButton
        width: root.width * 3 / 4
        height: root.height * 3 / 4
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        source: "Images/play_pause.png"
    }
}
