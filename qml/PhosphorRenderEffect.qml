import QtQuick 2.15

Item {
    id: root
    property alias buffer: phosphor.buffer
    property alias xBuffer: phosphor.xBuffer
    property alias xmin: phosphor.xmin
    property alias xmax: phosphor.xmax
    property alias ymin: phosphor.ymin
    property alias ymax: phosphor.ymax
    property alias pointSize: phosphor.pointSize
    property alias color: phosphor.color

    // Reference to the C++ PhosphorRender component for data
    PhosphorRender {
        id: phosphor
        anchors.fill: parent
        visible: false // Hidden since rendering is handled by ShaderEffect
    }

    // Custom rendering using ShaderEffect
    ShaderEffect {
        id: effect
        anchors.fill: parent
        vertexShader: "qrc:/shaders/phosphor.vert.qsb"
        fragmentShader: "qrc:/shaders/phosphor.frag.qsb"
        property matrix matrix: {
            var m = Qt.matrix4x4();
            var bounds = root.boundingRect;
            var width = bounds.width / (phosphor.xmax - phosphor.xmin);
            var height = bounds.height / (phosphor.ymin - phosphor.ymax);
            m.scale(width, height, 1.0);
            m.translate(-phosphor.xmin, -phosphor.ymax, 0);
            return m;
        }
        property real opacity: 1.0
        property color color: phosphor.color
        // Future enhancement: Use a texture or buffer to render actual points
    }
}
