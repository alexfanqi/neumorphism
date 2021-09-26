/****************************************************************************
** Copyright (C) 2021 smr.
** Contact: http://s-m-r.ir
**
** This file is part of the SMR Neumorphism Toolkit.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
**
** Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
****************************************************************************/

pragma Singleton
import QtQuick 2.15

QtObject {
    property color backgroundColor: '#f3e3ff';
    property color forgoundColor:   '#f3e3ff';

    function blend(color1, color2, alpha) {
        var color = color1;
        color.r = (color.r + color2.r) / 2;
        color.g = (color.g + color2.g) / 2;
        color.b = (color.b + color2.b) / 2;
        color.a = alpha;

        return color;
    }
}