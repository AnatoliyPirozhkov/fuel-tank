import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "./component"


Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Fuel Tank")

    Tank {
        id: _tank
    }

    ExTextField {
        id: _tf
        labelText: qsTr("Percent fuel level")
        fieldWidth: 100
        validator: RegExpValidator { regExp: /^([1-9][0-9]?|100)$/ }
        fieldText: "50"
        onTextChanged: _slider.value = fieldText
    }

    Slider {
        id: _slider
        anchors.top: _tf.bottom
        orientation: Qt.Vertical
        from: 1
        value: 50
        to: 100
        stepSize: 1
        live: false

        onValueChanged: {
            _tf.fieldText = value
            _tank.new_fuel_level = value
        }
    }
}
