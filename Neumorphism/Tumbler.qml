// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Tumbler {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    font.bold: true
    font.pixelSize: 12

    property real xrad: gapsize / 2 + 0.18 ;
    property real gapsize: implicitContentWidth / control.width;

    delegate: Text {
        text: modelData
        color: control.visualFocus ? control.palette.highlight : control.palette.text
        font: control.font
        opacity: Math.abs(Tumbler.displacement) / (control.visibleItemCount)
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    contentItem: PathView {
        id: pathView
        implicitWidth: 60
        implicitHeight: 200
        clip: true
        model: control.model
        delegate: control.delegate
        pathItemCount: control.visibleItemCount + 1
        path: Path {
            startX: control.contentItem.width / 2
            startY: -control.contentItem.delegateHeight / 2
            PathLine {
                x: control.contentItem.width / 2
                y: (control.visibleItemCount + 1) * control.contentItem.delegateHeight - control.contentItem.delegateHeight / 2
            }
        }
        property real delegateHeight: control.availableHeight / control.visibleItemCount
    }

    background: ShaderEffect {
        id: effect

        width:  parent.width;
        height: parent.height;

        readonly property color _shade: Qt.darker(control.palette.button, 1.1)
        readonly property color _highlight: Qt.lighter(control.palette.button, 1.1)
        readonly property real _xrad: control.xrad;
        readonly property real _gapsize: control.gapsize/2;

        fragmentShader: "qrc:/Neumorphism/shaders/tumbler.frag.qsb"
    }
}
