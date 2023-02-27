import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
Item {
    id: _root
    property alias       labelText: _label.text
    property alias       fieldText: _field.text
    property alias placeholderText: _field.placeholderText
    property alias      fieldFocus: _field.focus
    property alias        readOnly: _field.readOnly
    property alias    labelVisible: _label.visible
    property alias       validator: _field.validator
    property int        fieldWidth: 100
    property int       fieldHeight: 30
    property string     background: "transparent"
    property bool         isEdited: _field.isСhanged
    signal textChanged()
    signal textEdited()

    onIsEditedChanged: {
        if (isEdited === false)
        {
            _textBackground.border.color = "#FFBDBDBD";
            _textBackground.border.width = 1;
        } else {
            _textBackground.border.color = "#FFE57439";
            _textBackground.border.width = 2;
        }
    }

    anchors.margins: 6
    implicitWidth: fieldWidth > _label.width ? fieldWidth : _label.width
    implicitHeight: _field.height+_label.height

    ColumnLayout {
        spacing: 1

        Label {
          id: _label
          text: qsTr("Name")
          font.pixelSize: 14
          Layout.alignment: Qt.AlignLeft
        }

        TextField {
            id: _field
            property bool isСhanged: false
            property bool isUndo:    false
            property bool isEdit:    false

            Layout.alignment: Qt.AlignLeft
            Layout.preferredHeight: fieldHeight
            Layout.preferredWidth:  fieldWidth
            font.pixelSize: 12
            background: _textBackground
            selectByMouse: true

            Keys.onPressed: {
                if (event.matches(StandardKey.Undo))
                    isUndo = true;
                else if (event.matches(StandardKey.Redo))
                    isUndo = false;
            }
        }

        Rectangle {
            id: _textBackground
            border {
                width: 1
                color: "#FFBDBDBD"
            }
        }

        Connections {
            target: _field
            function onTextEdited() {
                if (!_field.isUndo)
                {
                    _field.isEdit = true;
                    _field.isСhanged = true;
                    _root.isEdited = true;
                    _root.textEdited();
                }
            }

            // Always called, including programmatically
            function onTextChanged() {
                if (!_field.isEdit)
                {
                    _field.isСhanged = false;
                    _root.isEdited = false;
                }
                _field.isEdit = false;
                _field.isUndo = false;
            }

            function onEditingFinished() {
                _root.textChanged();
            }
        }
    }

    function clear() {_field.clear()}
}
