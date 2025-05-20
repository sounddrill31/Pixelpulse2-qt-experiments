import QtQuick 2.1
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0

Rectangle {
  gradient: Gradient {
    GradientStop { position: 0.0; color: '#565666' }
    GradientStop { position: 0.15; color: '#6a6a7d' }
    GradientStop { position: 0.5; color: '#5a5a6a' }
    GradientStop { position: 1.0; color: '#585868' }
  }



  default property alias data: inner.data
  RowLayout {
    anchors.fill: parent
    id: inner
  }
}
