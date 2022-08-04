import QtQuick 2.0

Rectangle {
    // a qml type to use as a progress slider for a video
    id: sliderContainer

    property color sliderColor: "#2676f1"
    property int currentValue   // of video
    property int maxValue       // of video
    // max width for containing slider
    readonly property int maxSliderPosition: sliderContainer.width - slider.width
    // calculate current slider position in relation to the video playing
    readonly property int currentSliderPosition: sliderContainer.maxSliderPosition * sliderContainer.currentValue / sliderContainer.maxValue
    // calculate playback position of video based on the slider position (used with drag event)
    property int newCurrentValue: slider.x * sliderContainer.maxValue / sliderContainer.maxSliderPosition

    signal dragStarted()
    signal dragReleased()

    Rectangle {
        id: slider
        anchors.verticalCenter: parent.verticalCenter
        color: sliderColor
        width: 5
        height: 15
        radius: 5
        x: sliderContainer.currentSliderPosition
    }

    MouseArea {
        id: sliderMouseArea
        anchors.fill: parent

        drag {
            target: slider
            axis: Drag.XAxis
            minimumX: 0
            maximumX: sliderContainer.maxSliderPosition
            onActiveChanged: {
                if (sliderMouseArea.drag.active)
                    sliderContainer.dragStarted()
                else
                    sliderContainer.dragReleased()
            }
        }
    }
}
