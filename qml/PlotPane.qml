import QtQuick 2.1
import QtQuick.Layouts 1.0
import QtQuick.Controls

ColumnLayout {
  spacing: 32
  id: xyplot
  Layout.minimumWidth: 0.3*parent.width
  Layout.maximumWidth: 0.6*parent.width

  property alias devRep: dev_rep

  ToolbarStyle {
    Layout.fillWidth: true
    Layout.minimumWidth: parent.Layout.minimumWidth
    Layout.maximumWidth: parent.Layout.maximumWidth
    height: toolbarHeight
  }

  Repeater {
    id: dev_rep
    model: session.devices

    Repeater {
      model: modelData.channels

      XYPlot {
        // if mode == SIMV, current is independent variable
        // if mode == SVMI (or Hi-Z), voltage is independent variable
        Layout.minimumWidth: parent.width
        Layout.maximumWidth: parent.width
        isignal: modelData.signals[1]
        vsignal: modelData.signals[0]
      }
    }
  }
}
