import QtQuick 2.15
import QtQuick.Controls 2.15
import "../Components"

Item {
    ScrollView {
        id: scrollView
        clip: true
        anchors.fill: parent
        contentHeight: userSettingsRect.height
        onVisibleChanged: {
            if (visible) {
                let settingsJson = JSON.parse(userSettingsInstance.readJson())
                if (settingsJson.devMode && strToBool(settingsJson.devMode))
                    devModeSwitch.checked = true
            }
        }

        Rectangle {
            id: userSettingsRect
            anchors {
                left: parent.left
                leftMargin: 40
                right: parent.right
                rightMargin: 40
                top: parent.top
                topMargin: 0
            }
            color: "#36393f"

            Text {
                id: devModeLbl
                height: 22
                color: "#ffffff"
                text: qsTr("Developer mode")
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 20
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 18
            }

            Switch {
                id: devModeSwitch
                anchors.leftMargin: 20
                anchors.topMargin: -7
                anchors.left: devModeLbl.right
                anchors.top: devModeLbl.top


                indicator: Rectangle {
                    implicitWidth: 48
                    implicitHeight: 26
                    x: devModeSwitch.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: 13
                    color: devModeSwitch.checked ? "#ff5555" : "#ffffff"
                    border.color: devModeSwitch.checked ? "#ff5555" : "#cccccc"

                    Rectangle {
                        x: devModeSwitch.checked ? parent.width - width : 0
                        width: 26
                        height: 26
                        radius: 13
                        color: devModeSwitch.down ? "#cccccc" : "#ffffff"
                        border.color: devModeSwitch.checked ? (devModeSwitch.down ? "#ff5555" : "#ff4444") : "#999999"
                    }
                }
            }

            BigButton {
                id: settingsSaveBtn
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: devModeLbl.bottom
                anchors.topMargin: 30
                anchors.bottomMargin: 30
                btnLabel: qsTr("Save")
                btnMouseArea.onClicked: {
                    userSettingsInstance.set("devMode",boolToStr(devModeSwitch.checked))
                    userSettingsInstance.write()
                    toast.show(qsTr("Saved successfully"),3000,0)
                }
            }
        }
    }

    function boolToStr(val) {
        return val ? "on" : "off"
    }

    function strToBool(val) {
        return val === "on"
    }
}
