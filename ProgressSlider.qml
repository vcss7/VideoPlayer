import QtQuick 2.0

Rectangle {
    id: sliderContainer

    property color sliderColor: "#2676f1"
    property int currentValue
    property int maxValue
    readonly property int maxSliderPosition: sliderContainer.width - slider.width
    readonly property int currentSliderPosition: sliderContainer.maxSliderPosition * sliderContainer.currentValue / sliderContainer.maxValue
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
