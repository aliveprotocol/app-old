import QtQuick 2.15
import QtQuick.Controls 2.15
import "../Components"

Item {
    property var uploadProtocols: [
        { value: 'ipfs', text: 'IPFS' },
        { value: 'sia', text: 'Skynet' }
    ]
    property var uploadEndpoints: [
        // IPFS
        { value: 'https://uploader.oneloved.tube', text: 'OneLoveIPFS', protocol: 'ipfs' },
        { value: '/ip4/127.0.0.1/tcp/5001/http', text: 'Local IPFS node', protocol: 'ipfs' },

        // Skynet
        { value: 'https://siasky.net', text: 'siasky.net', protocol: 'sia' },
        { value: 'https://skydrain.net', text: 'skydrain.net', protocol: 'sia' },

        // Debug (dev mode only)
        ...(devModeSwitch.checked ? [{ value: 'debug', text: 'Debug Endpoint', protocol: 'custom' }] : [])
    ]
    readonly property int settingIndentation: 150

    ScrollView {
        id: scrollView
        clip: true
        anchors.fill: parent
        contentHeight: userSettingsRect.height
        onVisibleChanged: {
            if (visible) {
                let settingsJson = {}
                try {
                    settingsJson = JSON.parse(userSettingsInstance.readJson())
                } catch (e) {}
                if (settingsJson.devMode && strToBool(settingsJson.devMode))
                    devModeSwitch.checked = true
                if (settingsJson.hiveAPI)
                    hiveAPINodeDropdown.currentIndex = hiveAPIObj.getIndex(settingsJson.hiveAPI)
                if (settingsJson.uploadProtocol)
                    uploadProtocolDropdown.currentIndex = getIndex(uploadProtocols,settingsJson.uploadProtocol)
                if (settingsJson.uploadEndpoint)
                    uploadEndpointDropdown.currentIndex = getIndex(filterUploadEndpoints(settingsJson.uploadProtocol),settingsJson.uploadEndpoint)
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

            // Developer mode
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
                anchors.leftMargin: settingIndentation
                anchors.left: parent.left
                anchors.verticalCenter: devModeLbl.verticalCenter

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

            // Hive API node
            Text {
                id: hiveAPINodeLbl
                height: 22
                color: "#ffffff"
                text: qsTr("Hive API node")
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: devModeLbl.bottom
                anchors.topMargin: 20
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 18
            }

            HiveAPI {
                id: hiveAPIObj
            }

            DropdownSelection {
                id: hiveAPINodeDropdown
                height: 25
                width: 200
                anchors.leftMargin: settingIndentation
                anchors.left: parent.left
                anchors.verticalCenter: hiveAPINodeLbl.verticalCenter
                model: hiveAPIObj.apiOptions
            }

            // UPLOADER SETTINGS
            // Upload Protocol (IPFS or Skynet)
            Text {
                id: uploadProtocolLbl
                height: 22
                color: "#ffffff"
                text: qsTr("Upload Protocol")
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: hiveAPINodeLbl.bottom
                anchors.topMargin: 20
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 18
            }

            DropdownSelection {
                id: uploadProtocolDropdown
                height: 25
                width: 100
                anchors.leftMargin: settingIndentation
                anchors.left: parent.left
                anchors.verticalCenter: uploadProtocolLbl.verticalCenter
                model: uploadProtocols
            }

            // Upload Endpoint
            Text {
                id: uploadEndpointLbl
                height: 22
                color: "#ffffff"
                text: qsTr("Upload Endpoint")
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: uploadProtocolLbl.bottom
                anchors.topMargin: 20
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 18
            }

            DropdownSelection {
                id: uploadEndpointDropdown
                height: 25
                width: 200
                anchors.leftMargin: settingIndentation
                anchors.left: parent.left
                anchors.verticalCenter: uploadEndpointLbl.verticalCenter
                model: filterUploadEndpoints(uploadProtocols[uploadProtocolDropdown.currentIndex].value)
            }

            // SAVE
            BigButton {
                id: settingsSaveBtn
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: uploadEndpointLbl.bottom
                anchors.topMargin: 30
                anchors.bottomMargin: 30
                btnLabel: qsTr("Save")
                btnMouseArea.onClicked: {
                    userSettingsInstance.set("devMode",boolToStr(devModeSwitch.checked))
                    userSettingsInstance.set("hiveAPI",hiveAPINodeDropdown.model[hiveAPINodeDropdown.currentIndex].value)
                    userSettingsInstance.set("uploadProtocol",uploadProtocolDropdown.model[uploadProtocolDropdown.currentIndex].value)
                    userSettingsInstance.set("uploadEndpoint",uploadEndpointDropdown.model[uploadEndpointDropdown.currentIndex].value)
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

    function getIndex(model = [], val = '') {
        for (let i in model)
            if (model[i].value === val)
                return i
        return 0
    }

    function filterUploadEndpoints(protocol = 'ipfs') {
        let filtered = []
        for (let i in uploadEndpoints)
            if (uploadEndpoints[i].protocol === protocol || uploadEndpoints[i].protocol === 'custom')
                filtered.push(uploadEndpoints[i])
        return filtered
    }
}
