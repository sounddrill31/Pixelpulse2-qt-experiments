import QtQuick 2.1
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls
//import QtQuick.Controls.Styles 1.1

Rectangle {
  id: channelBlock
  property var channel
  property alias signalRepeater:signalRepeater
  color: '#333'

  ToolButton {
    anchors.top: parent.top
    anchors.left: parent.left
    width: timelinePane.spacing
    height: timelinePane.spacing
  
    property var icons: [
      'mv',
      'svmi',
      'simv',
    ]
    icon.source: 'qrc:/icons/' + icons[channel.mode] + '.png'
  
    background: Rectangle {
      opacity: parent.pressed ? 0.3 : parent.checked ? 0.2 : 0.1
      color: 'black'
    }

    function updateMode() {
      var chIdx = {A: 0, B: 1}[channel.label];
      var devIdx = parent.parent.parent.currentIndex * 2;
      var xyPlot = xyPane.devRep.itemAt(parent.parent.parent.currentIndex).itemAt(chIdx);

      xyPlot.ysignal = (channel.mode == 1) ? xyPlot.isignal : xyPlot.vsignal;
      xyPlot.xsignal = (channel.mode == 1) ? xyPlot.vsignal : xyPlot.isignal;
    }

    onClicked: contextMenu.popup()
    
    Menu {
      id: contextMenu
      MenuItem { text: "Measure Voltage"
        onTriggered: channel.mode = 0
      }
      MenuItem { text: "Source Voltage, Measure Current"
        onTriggered: channel.mode = 1
      }
      MenuItem { text: "Source Current, Measure Voltage"
        onTriggered: channel.mode = 2
      }
    }
  }


  Text {
    text: "Channel " + channel.label
    color: 'white'
    rotation: -90
    transformOrigin: Item.TopLeft
    font.pixelSize: 18 / session.devices.length
    y: width + timelinePane.spacing + 8
    x: (timelinePane.spacing - height) / 2
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.leftMargin: timelinePane.spacing
    spacing: 0

    Repeater {
      id: signalRepeater
      model: modelData.signals

      SignalRow {
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.minimumHeight: channelBlock.height / 2

        signal: model
        xaxis: timeline_xaxis
      }
    }
  }
}
