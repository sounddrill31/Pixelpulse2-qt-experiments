import QtQuick 2.15
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls
//import QtQuick.Controls.Styles 1.1

Window {
  title: "Acquisition Settings"
  minimumWidth: 400
  minimumHeight: 180
  maximumWidth: minimumWidth
  maximumHeight: minimumHeight
  modality: Qt.NonModal
  flags: Qt.Window | Qt.WindowSystemMenuHint | Qt.WindowCloseButtonHint | Qt.WindowTitleHint

  property real timeDelay: delay.value
  property bool showStatusBar: toggleStatusBar.checked

  property real timeDelayOld: 0;

  function delayToSamples(delayVal)
  {
    var timeInSeconds = delayVal / 1000.0;
    var sampleCount = Math.floor(controller.sampleRate * timeInSeconds + 0.5);

    return sampleCount;
  }

  function samplesToSecondsDelay(samplesCount)
  {
    return (samplesCount / controller.sampleRate);
  }

  function onContinuousModeChanged(continuous)
  {
    if (continuous) {
      timeDelayOld = timeDelay;
      delay.value = 0;
    } else {
      delay.value = timeDelayOld;
    }

    delay.enabled = !continuous;
  }

  Rectangle {
    id: rectangle
    anchors.fill: parent
    color: '#222'

    ColumnLayout {
      anchors.fill: parent
      anchors.leftMargin: 25
      anchors.rightMargin: 25
      anchors.topMargin: 35
      anchors.bottomMargin: 35
      spacing: 0

      Text {
        text: "Amount of time the received data should be delayed with:"
        color: 'white'
        font.pixelSize: 14
      }

      RowLayout {
        spacing: 15

        Text {
          id: delayLabel
          text: "Delay (ms)"
          color: 'white'
          font.pixelSize: 14
        }

        SpinBox {
          id: delay
          to: 1000
          from: 0
          stepSize: 1
          editable: true

          // For decimal support, you might need to use a custom validator
          property real realValue: value / 100.0

          onValueChanged: {
            var sampleCount = delayToSamples(realValue);

            if (sampleCount !== controller.delaySampleCount) {
              controller.delaySampleCount = sampleCount;
            }
          }
          Keys.onPressed: {
            switch (event.key) {
            case Qt.Key_PageDown:
              value -= 50; // Adjusted for integer-based SpinBox
              break;
            case Qt.Key_PageUp:
              value += 50; // Adjusted for integer-based SpinBox
              break;
            }
          }
        } // SpinBox
      } // RowLayout

      CheckBox {
        id: toggleStatusBar
        text: 'Show delay value on main window'
        
        // Style the text appearance
        contentItem: Text {
          text: toggleStatusBar.text
          color: 'white'
          font.pixelSize: 14
          leftPadding: toggleStatusBar.indicator.width + toggleStatusBar.spacing
          verticalAlignment: Text.AlignVCenter
        }
      } // Checkbox
    } // ColumnLayout
  } // Rectangle
} // Window
