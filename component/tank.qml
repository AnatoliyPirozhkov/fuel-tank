import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtGraphicalEffects 1.12 as GE

Item {
    id: _t
    property real xr: 70
    property real yr: 20
    property real fuel_level    : 51
    property real new_fuel_level: 0
    property real yellow_level  : 45
    property real red_level     : 13

    implicitWidth: _rec.width
    implicitHeight: _rec.height
    anchors.fill: parent

    onNew_fuel_levelChanged: {
        if (new_fuel_level < 0)   fuel_level=new_fuel_level=0
        if (new_fuel_level > 100) fuel_level=new_fuel_level=100
        _anim.to = new_fuel_level;
        _anim.running = true;

    }
    NumberAnimation on fuel_level {
        id:_anim
        duration: 700
        running: false
    }

    Rectangle {
        id: _rec
        anchors.fill: parent
        color: "white"

        Shape {
            id: _bottom_tank
            anchors.fill: parent

            // The bottom of the tank to form a shadow
            ShapePath {
                strokeWidth: 2
                strokeColor: "#708090"
                strokeStyle: ShapePath.SolidLine

                startX: _tank.width / 2 + _t.xr
                startY: _tank.height - _t.yr*2
                PathArc {
                    x: _tank.width / 2 - _t.xr
                    y: _tank.height - _t.yr*2
                    radiusX: _t.xr; radiusY: _t.yr
                    useLargeArc: true
                }
                PathArc {
                    x: _tank.width / 2 + _t.xr
                    y: _tank.height - _t.yr*2
                    radiusX: _t.xr; radiusY: _t.yr
                    useLargeArc: true
                }
                fillColor: "#FF8396A9"
            }
        }

        GE.DropShadow {
            anchors.fill: parent
            horizontalOffset: 1
            verticalOffset: 2
            radius: 17.0
            samples: 17
            color: "#FF000000"
            source: _bottom_tank
        }


        Shape {
            id: _tank
            anchors.fill: parent
            onHeightChanged: if (_tank.height < _t.yr*4) _tank.height = _t.yr*4

            // Fuel
            ShapePath {
                strokeColor: "transparent"
                startX: _tank.width / 2 + _t.xr
                startY: _tank.height - _t.yr*2

                PathArc {
                    x: _tank.width / 2 - _t.xr
                    y: _tank.height - _t.yr*2
                    radiusX: _t.xr; radiusY: _t.yr
                    useLargeArc: true
                }

                PathLine {
                    id: _line1
                    x: _tank.width / 2 - _t.xr;
                    y: _t.yr*2 + (_tank.height-_t.yr*4) - ((_tank.height-_t.yr*4)*_t.fuel_level/100);

                }
                PathArc {
                    x: _tank.width / 2 + _t.xr
                    y: _t.yr*2 + (_tank.height-_t.yr*4) - ((_tank.height-_t.yr*4)*_t.fuel_level/100);
                    radiusX: _t.xr; radiusY: _t.yr
                    useLargeArc: true
                }

                PathLine { x: _tank.width / 2 + _t.xr; y: _tank.height - _t.yr*2; }

                onChanged: {
                    if (_t.fuel_level > _t.yellow_level)  fillColor = "#FF27FF09"
                    if (_t.fuel_level <= _t.yellow_level) fillColor = "#FFFFE609"
                    if (_t.fuel_level <= _t.red_level)    fillColor = "#FFFF0909"
                }
            }

            // Fuel level
            ShapePath {
                property string fill_color: ""
                property string border_color: ""
                strokeWidth: 2
                strokeColor: border_color
                strokeStyle: ShapePath.SolidLine

                startX: _tank.width / 2 - _t.xr
                startY: _t.yr*2 + _tank.height-_t.yr*4 - ((_tank.height-_t.yr*4)*_t.fuel_level/100)
                PathArc {
                    x: _tank.width / 2 + _t.xr
                    y: _t.yr*2 + _tank.height-_t.yr*4 - ((_tank.height-_t.yr*4)*_t.fuel_level/100)
                    radiusX: _t.xr; radiusY: _t.yr
                    useLargeArc: true
                }

                PathArc {
                    x: _tank.width / 2 - _t.xr
                    y: _t.yr*2 + _tank.height-_t.yr*4 - ((_tank.height-_t.yr*4)*_t.fuel_level/100)
                    radiusX: _t.xr; radiusY: _t.yr
                    useLargeArc: true
                }
                fillColor: fill_color

                onChanged: {
                    // The color of the fuel depending on the percentage of filling
                    if (_t.fuel_level <= _t.red_level)
                       {fill_color = "#FFD5382C"; border_color = "#FFCD3232"}
                    else if (_t.fuel_level <= _t.yellow_level)
                            {fill_color = "#FFD5B92C"; border_color = "#FFCDB332"}
                          else  {fill_color = "#FF41D52C"; border_color = "#FF32CD32"}
                }
            }

            // Tank
            ShapePath {
                strokeWidth: 3
                strokeColor: "#708090"
                strokeStyle: ShapePath.SolidLine

                startX: _tank.width / 2 + _t.xr
                startY: _tank.height - _t.yr*2

                PathArc {
                    x: _tank.width / 2 - _t.xr
                    y: _tank.height - _t.yr*2
                    radiusX: _t.xr; radiusY: _t.yr
                    useLargeArc: true
                }

                PathLine { x: _tank.width / 2 - _t.xr; y: _t.yr*2; }

                PathArc {
                    x: _tank.width / 2 + _t.xr
                    y: _t.yr*2
                    radiusX: _t.xr; radiusY: _t.yr
                    useLargeArc: true
                }

                PathLine { x: _tank.width / 2 + _t.xr; y: _tank.height - _t.yr*2; }

                fillGradient: LinearGradient {
                            x1: _tank.width / 2 - _t.xr; y1: _tank.height / 2
                            x2: _tank.width / 2 + _t.xr; y2: _tank.height / 2
                            GradientStop { position: 0;    color: "#50797979" }
                            GradientStop { position: 0.15; color: "#507D7D7D" }
                            GradientStop { position: 0.18; color: "#50979797" }
                            GradientStop { position: 0.46; color: "#50979797" }
                            GradientStop { position: 0.51; color: "#504B4B4B" }
                            GradientStop { position: 0.70; color: "#50767676" }
                            GradientStop { position: 0.86; color: "#50A4A4A4" }
                            GradientStop { position: 0.93; color: "#508D8D8D" }
                            GradientStop { position: 1;    color: "#508D8D8D" }
                }
            }

            // Tank cap
            ShapePath {
                strokeWidth: 0

                startX: _tank.width / 2 - _t.xr
                startY: _t.yr*2
                PathArc {
                    x: _tank.width / 2 + _t.xr
                    y: _t.yr*2
                    radiusX: _t.xr; radiusY: _t.yr
                    useLargeArc: true
                }

                PathArc {
                    x: _tank.width / 2 - _t.xr
                    y: _t.yr*2
                    radiusX: _t.xr; radiusY: _t.yr
                    useLargeArc: true
                }
                fillColor: "#708090"
            }
        }
    }
}
