import QtQuick 2.15
import QtQuick.Window 2.15
import QtMultimedia
import ApiWrapper 1.0

import QtQuick.Dialogs


Window {
    id: root_window
    width: 500 //Screen.width
    height: 400 //Screen.height
    visible: true
    //visibility: Window.FullScreen
    title: qsTr("Video Player")

    ApiWrapper { id: api_wrapper }

    Rectangle {
        id: root_rectangle
        state: "promptingVideo"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: parent.height

        states: [
            State {
                name: "promptingVideo"
                when: video_player.playbackState == MediaPlayer.StoppedState
                PropertyChanges { target: root_rectangle; color: "#2676f1" }
                PropertyChanges { target: video_button; visible: true; enabled: true }
                PropertyChanges { target: progress_slider_control; visible: false; enabled: false }
                PropertyChanges { target: play_pause_button; visible: false; enabled: false }
                StateChangeScript { script: api_wrapper.setTimerEnabled() }
            },
            State {
                name: "playingVideo"
                when: video_player.playbackState != MediaPlayer.StoppedState
                PropertyChanges { target: root_rectangle; color: "black" }
                PropertyChanges { target: video_button; visible: false; enabled: false }
                PropertyChanges { target: progress_slider_control; visible: true; enabled: true }
                PropertyChanges { target: play_pause_button; visible: true; enabled: true }
                StateChangeScript { script: api_wrapper.setTimerDisabled() }
            }
        ]

        Rectangle {
            id: video_button
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: video_button_text.width + 15
            height: video_button_text.height + 15
            color: "white"
            radius: 10

            Text {
                id: video_button_text
                text: qsTr("Open Video..")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 18
            }

            TapHandler {
                onTapped: {
                    file_dialog.open()
                    //video_player.setPosition(0)
                    //video_player.play()
                }
            }
        }
    }

    FileDialog {
        id: file_dialog
        onAccepted: {
            video_player.play()
            file_dialog.close()
        }
    }

    MediaPlayer {
        id: video_player
        source: file_dialog.selectedFile
        //source: "file:///Users/vc/Movies/cat.mp4"
        audioOutput: AudioOutput {}
        videoOutput: video_output
    }

    VideoOutput {
        id: video_output
        anchors.fill: parent

        ProgressSlider {
            id: progress_slider_control
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            width: parent.width * 3 / 4
            height: 4
            radius: 5
            y: (parent.y + parent.height) * 7 / 8

            currentValue: video_player.position
            maxValue: video_player.duration

            onDragStarted: { video_player.pause() }
            onDragReleased: { video_player.setPosition(progress_slider_control.newCurrentValue) }
        }

        PlayPauseButton {
            id: play_pause_button
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            opacity: 0.5

            TapHandler {
                onTapped: {
                    video_player.playbackState == MediaPlayer.PausedState ? video_player.play() : video_player.pause()
                }
            }
        }
    }
}
