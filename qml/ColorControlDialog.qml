import QtQuick 2.15
import QtQuick.Layouts 1.0
import QtQuick.Controls
//import QtQuick.Controls.Styles 1.1
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects

Dialog {
    title: "Display settings"
    width: 300
    height: 300
    //modality: Qt.NonModal
    property alias plotCheckBox: plotsCheckBox
    property alias sigCheckBox: signalCheckBox
    property alias sliderB: sliderBrightness
    property alias sliderC: sliderContrast
    property alias sliderDot: sliderDotSize
    property alias sliderPh: sliderPhosphorRender

    contentItem:
        RowLayout {
        id: layout

        Rectangle{
            id: rectangle
            color: '#333'
            anchors.fill: parent
            Layout.preferredWidth: 300
            Layout.preferredHeight: 300
            Layout.maximumHeight: 300
            Layout.maximumWidth: Layout.preferredWidth
            Layout.minimumHeight: Layout.maximumHeight
            Layout.minimumWidth: Layout.maximumWidth
            property var lastModified;
            property color intermPlotColor: '#0c0c0c';
            property color intermPlotAxes: '#222';
            property color intermSignalColor: '#0c0c0c';
            property color intermSignalAxes: '#222';


            CheckBox {
                id: signalCheckBox
                focus: true
                checked: true
                text: 'Time Plots'
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 5/100 * parent.height
                anchors.leftMargin: 15/100 * parent.width

                contentItem: Text {
                    text: signalCheckBox.text
                    color: "white"
                    font.pixelSize: 14
                    leftPadding: signalCheckBox.indicator.width + signalCheckBox.spacing
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    sliderContrast.valueHasChanged(signalCheckBox);
                    sliderPhosphorRender.valueHasChanged(signalCheckBox);
                    sliderDotSize.valueHasChanged(signalCheckBox);

                }
            }

            CheckBox {
                id: plotsCheckBox
                focus: true
                checked: xyPane.visible ? true : false
                text: 'XY Plots'
                anchors.top: parent.top
                anchors.left: signalCheckBox.right
                anchors.topMargin: 5/100 * parent.height
                anchors.leftMargin: 30

                contentItem: Text {
                    text: plotsCheckBox.text
                    color: "white"
                    font.pixelSize: 14
                    leftPadding: plotsCheckBox.indicator.width + plotsCheckBox.spacing
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    sliderContrast.valueHasChanged(plotsCheckBox);
                    sliderPhosphorRender.valueHasChanged(plotsCheckBox);
                    sliderDotSize.valueHasChanged(plotsCheckBox);

                }
            }

            Text{
                id: brightLabel
                visible: true
                text: 'Brightness'
                font.pixelSize: 14
                color: 'white'
                anchors.top: plotsCheckBox.bottom
                anchors.left: signalCheckBox.left
                anchors.topMargin: 5/100 * parent.height
            }
            Slider {
                id: sliderBrightness
                focus: true
                anchors.top: brightLabel.bottom
                anchors.topMargin: 1/100 * parent.height
                anchors.left: signalCheckBox.left
                value: 0.0
                from: 0.0
                to: 1.0
                stepSize: 0.01
                width: 70/100 * parent.width

                property real factor
                property real oldValue: 0.0

                background: Rectangle {
                    x: sliderBrightness.leftPadding
                    y: sliderBrightness.topPadding + sliderBrightness.availableHeight / 2 - height / 2
                    implicitWidth: 200
                    implicitHeight: 8
                    width: sliderBrightness.availableWidth
                    height: implicitHeight
                    radius: 8
                    gradient: Gradient {
                        GradientStop { position: 1.0; color: Qt.rgba(1,1,1,0.08)}
                        GradientStop { position: 0.0; color: Qt.rgba(0,0,0,0.0)}
                    }
                }

                handle: Rectangle {
                    x: sliderBrightness.leftPadding + sliderBrightness.visualPosition * (sliderBrightness.availableWidth - width)
                    y: sliderBrightness.topPadding + sliderBrightness.availableHeight / 2 - height / 2
                    implicitWidth: 20
                    implicitHeight: 20
                    radius: 8
                    color: sliderBrightness.pressed ? "#858484" : "#4E4E4E"
                    border.color: "#4E4E4E"
                    border.width: 2
                }

                function valueHasChanged(obj){
                    factor = (sliderBrightness.value)
                    if (plotsCheckBox.checked && (obj !== signalCheckBox)) {
                        var rPlot = parent.intermPlotColor.r + (100 * factor) / 255
                        var rAxes = parent.intermPlotAxes.r + (100 * factor) / 255
                        window.xyplotColor = Qt.rgba(rPlot, rPlot,  rPlot, 1.0)
                        window.gridAxesColor = Qt.rgba(rAxes, rAxes, rAxes, 1.0)
                    }

                    if (signalCheckBox.checked && (obj !== plotsCheckBox)){
                        rPlot = parent.intermSignalColor.r + (100 * factor) / 255
                        rAxes = parent.intermSignalAxes .r + (100 * factor) / 255
                        window.signalRowColor = Qt.rgba(rPlot, rPlot,  rPlot, 1.0)
                        window.signalAxesColor = Qt.rgba(rAxes, rAxes, rAxes, 1.0)
                    }
                    if(signalCheckBox.checked && plotsCheckBox.checked){
                        oldValue = value
                    }
                }
                onValueChanged: valueHasChanged(sliderBrightness)

            }

            Text{
                id: contrastLabel
                visible: true
                text: 'Contrast'
                font.pixelSize: 14
                color: 'white'
                anchors.top: sliderBrightness.bottom
                anchors.left: signalCheckBox.left
                anchors.topMargin: 5/100 * parent.height
            }
        Slider {
            id: sliderContrast
            anchors.top: contrastLabel.bottom
            anchors.topMargin: 1/100 * parent.height
            anchors.left: signalCheckBox.left
            value: 0.0
            from: 0.0
            focus: true
            to: 1.0
            stepSize: 0.01
            width: 70/100 * parent.width

            property real factor
            property real oldValue: 0.0
            property color plotC: '#0c0c0c'
            property color gridC: '#222'

            background: Rectangle {
                x: sliderContrast.leftPadding
                y: sliderContrast.topPadding + sliderContrast.availableHeight / 2 - height / 2
                implicitWidth: 200
                implicitHeight: 8
                width: sliderContrast.availableWidth
                height: implicitHeight
                radius: 8
                gradient: Gradient {
                    GradientStop { position: 1.0; color: Qt.rgba(1,1,1,0.08)}
                    GradientStop { position: 0.0; color: Qt.rgba(0,0,0,0.0)}
                }
            }

            handle: Rectangle {
                x: sliderContrast.leftPadding + sliderContrast.visualPosition * (sliderContrast.availableWidth - width)
                y: sliderContrast.topPadding + sliderContrast.availableHeight / 2 - height / 2
                implicitWidth: 20
                implicitHeight: 20
                radius: 8
                color: sliderContrast.pressed ? "#858484" : "#4E4E4E"
                border.color: "#4E4E4E"
                border.width: 2
            }

            function valueHasChanged(obj){
                factor = (sliderContrast.value)
                var rPlot = plotC.r - (100 * factor) / 255
                var rAxes = gridC.r + (100 * factor) / 255

                if (plotsCheckBox.checked && (obj !== signalCheckBox)) {
                    parent.intermPlotAxes = Qt.rgba(rAxes, rAxes, rAxes, 1.0)
                    parent.intermPlotColor = Qt.rgba(rPlot, rPlot,  rPlot, 1.0)
                    if (factor === 1.0) {parent.intermPlotAxes = '#fdfdfd'}
                }
                if (signalCheckBox.checked && (obj !== plotsCheckBox)){
                    parent.intermSignalAxes = Qt.rgba(rAxes, rAxes, rAxes, 1.0)
                    parent.intermSignalColor = Qt.rgba(rPlot, rPlot,  rPlot, 1.0)
                    if (factor === 1.0) {parent.intermSignalAxes = '#fdfdfd' }
                }
                if(signalCheckBox.checked && plotsCheckBox.checked){
                    oldValue = value
                }
                /* Check for value updates in brightness slider */
                sliderBrightness.valueHasChanged(sliderContrast)
            }
            onValueChanged: sliderContrast.valueHasChanged(sliderContrast)
        }
            Text{
                id: phosphorLabel
                visible: true
                text: 'Dot Brightness'
                font.pixelSize: 14
                color: 'white'
                anchors.top: sliderContrast.bottom
                anchors.left: signalCheckBox.left
                anchors.topMargin: 5/100 * parent.height
            }
            Slider {
                id: sliderPhosphorRender
                anchors.top: phosphorLabel.bottom
                anchors.topMargin: 1/100 * parent.height
                anchors.left: signalCheckBox.left
                value: 0.0
                from: 0.0
                focus: true
                to: 1.0
                stepSize: 0.01
                width: 70/100 * parent.width

                property real factor
                property color dotCurrent: Qt.rgba(0.2, 0.2, 0.03, 1)
                property color dotVoltage: Qt.rgba(0.03, 0.3, 0.03, 1)

                background: Rectangle {
                    x: sliderPhosphorRender.leftPadding
                    y: sliderPhosphorRender.topPadding + sliderPhosphorRender.availableHeight / 2 - height / 2
                    implicitWidth: 200
                    implicitHeight: 8
                    width: sliderPhosphorRender.availableWidth
                    height: implicitHeight
                    radius: 8
                    gradient: Gradient {
                        GradientStop { position: 1.0; color: Qt.rgba(1,1,1,0.08)}
                        GradientStop { position: 0.0; color: Qt.rgba(0,0,0,0.0)}
                    }
                }

                handle: Rectangle {
                    x: sliderPhosphorRender.leftPadding + sliderPhosphorRender.visualPosition * (sliderPhosphorRender.availableWidth - width)
                    y: sliderPhosphorRender.topPadding + sliderPhosphorRender.availableHeight / 2 - height / 2
                    implicitWidth: 20
                    implicitHeight: 20
                    radius: 8
                    color: sliderPhosphorRender.pressed ? "#858484" : "#4E4E4E"
                    border.color: "#4E4E4E"
                    border.width: 2
                }

                function valueHasChanged(obj){
                    factor = (sliderPhosphorRender.value)
                    var rCurrent = dotCurrent.r + (300 * factor) / 255
                    var gCurrent = dotCurrent.g + (500 * factor) / 255
                    var bCurrent = dotCurrent.b + (100 * factor) / 255

                    var rVoltage = dotVoltage.r + (100 * factor) / 255
                    var gVoltage = dotVoltage.g + (500 * factor) / 255
                    var bVoltage = dotVoltage.b + (100 * factor) / 255
                    if (plotsCheckBox.checked && (obj !== signalCheckBox)) {
                        window.dotPlotsCurrent = Qt.rgba(rCurrent, gCurrent, bCurrent, 1.0)
                        window.dotPlotsVoltage = Qt.rgba(rVoltage, gVoltage,  bVoltage, 1.0)
                    }
                    if(signalCheckBox.checked && (obj !== plotsCheckBox)){
                        window.dotSignalCurrent = Qt.rgba(rCurrent, gCurrent, bCurrent, 1.0)
                        window.dotSignalVoltage = Qt.rgba(rVoltage, gVoltage,  bVoltage, 1.0)
                    }
                }
                onValueChanged: sliderPhosphorRender.valueHasChanged(sliderPhosphorRender)
            }
            Text{
                id: dotSizeLabel
                visible: true
                text: 'Dot Size'
                font.pixelSize: 14
                color: 'white'
                anchors.top: sliderPhosphorRender.bottom
                anchors.left: signalCheckBox.left
                anchors.topMargin: 5/100 * parent.height
            }
            Slider {
                id: sliderDotSize
                anchors.top: dotSizeLabel.bottom
                anchors.topMargin: 1/100 * parent.height
                anchors.left: signalCheckBox.left
                value: 0.1
                from: 0.1
                focus: true
                to: 1.0
                stepSize: 0.1
                width: 70/100 * parent.width

                property real factor

                background: Rectangle {
                    x: sliderDotSize.leftPadding
                    y: sliderDotSize.topPadding + sliderDotSize.availableHeight / 2 - height / 2
                    implicitWidth: 200
                    implicitHeight: 8
                    width: sliderDotSize.availableWidth
                    height: implicitHeight
                    radius: 8
                    gradient: Gradient {
                        GradientStop { position: 1.0; color: Qt.rgba(1,1,1,0.08)}
                        GradientStop { position: 0.0; color: Qt.rgba(0,0,0,0.0)}
                    }
                }

                handle: Rectangle {
                    x: sliderDotSize.leftPadding + sliderDotSize.visualPosition * (sliderDotSize.availableWidth - width)
                    y: sliderDotSize.topPadding + sliderDotSize.availableHeight / 2 - height / 2
                    implicitWidth: 20
                    implicitHeight: 20
                    radius: 8
                    color: sliderDotSize.pressed ? "#858484" : "#4E4E4E"
                    border.color: "#4E4E4E"
                    border.width: 2
                }

                function valueHasChanged(obj){
                    factor = sliderDotSize.value
                    if (plotsCheckBox.checked && (obj !== signalCheckBox)){
                        window.dotSizePlots = factor
                    }
                    if (signalCheckBox.checked && (obj !== plotsCheckBox)){
                        window.dotSizeSignal = factor
                    }
                }
                onValueChanged: sliderDotSize.valueHasChanged(sliderDotSize)
            }
        }
    }
}
