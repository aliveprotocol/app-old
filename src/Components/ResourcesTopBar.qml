import QtQuick 2.15
import "../Helpers/growInt.js" as GrowInt

Item {
    id: resourcesTopBar
    height: 50
    onVisibleChanged: {
        getResourcesInterval()
        resourcesInterval.start()
    }

    Timer {
        id: resourcesInterval
        interval: 30000
        repeat: true
        onTriggered: getResourcesInterval()
    }

    Connections {
        target: dtcGetAccBridge
        function onAvalonAccResult(result) {
            if (result !== "Error")
                updateDisplayAvalon(result)
        }
    }

    Connections {
        target: hivePowerBridge
        function onHivePowerResult(result) {
            if (result !== "Error")
                updateBalDisplayHive(result)
        }
    }

    Connections {
        target: hiveGetRcBridge
        function onHiveRcResult(result) {
            if (result !== "Error")
                updateRCDisplayHive(result)
        }
    }

    Text {
        id: bandwidthInfo
        x: 512
        y: 15
        width: 150
        height: 20
        color: "#ffffff"
        text: qsTr("Loading bandwidth...")
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 16
    }

    Text {
        id: balanceInfo
        x: 306
        y: 6
        width: 160
        height: 20
        color: "#ffffff"
        text: qsTr("Loading balance...")
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 16
        anchors.right: bandwidthInfo.left
        anchors.rightMargin: 50
        verticalAlignment: Text.AlignVCenter
    }

    function getResourcesInterval() {
        // Load balance and bandwidth info
        if (resourcesTopBar.visible) {
            let network = credInstance.get_preferred_network()
            let username = credInstance.get_username_by_network(network)
            switch (network) {
                case 'hive':
                    hivePowerBridge.startSignal(username)
                    hiveGetRcBridge.startSignal(username)
                    break
                case 'dtc':
                    dtcGetAccBridge.startSignal(username)
                    break
            }
        }
    }

    function updateDisplayAvalon(detail) {
        let detailObj = JSON.parse(detail)
        let grownBw = new GrowInt.GrowInt(detailObj.bw, {
                growth: detailObj.balance / 36000000,
                max: 64000
            }).grow(new Date().getTime()).v

        balanceInfo.text = "Balance: " + thousandSeperator(detailObj.balance / 100) + " DTC"
        bandwidthInfo.text = "BW: " + thousandSeperator(grownBw) + " bytes"
    }
    
    function updateBalDisplayHive(detail) {
        balanceInfo.text = "Balance: " + thousandSeperator(Math.round(detail * 1000) / 1000) + ' HP'
    }

    function updateRCDisplayHive(detail) {
        let detailObj = JSON.parse(detail)
        let maxRC = parseInt(detailObj.result.rc_accounts[0].max_rc)
        let grownRC = new GrowInt.GrowInt({
            v: parseInt(detailObj.result.rc_accounts[0].rc_manabar.current_mana),
            t: detailObj.result.rc_accounts[0].rc_manabar.last_update_time * 1000
        }, {
            growth: maxRC / 432000000,
            max: maxRC
        }).grow(new Date().getTime()).v
        bandwidthInfo.text = "RC: " + (Math.round(grownRC / maxRC * 10000) / 100) + '%'
    }

    function thousandSeperator(num) {
        var num_parts = num.toString().split(".")
        num_parts[0] = num_parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",")
        num_parts[0] = num_parts[0].replace(",,",",")
        return num_parts.join(".")
    }
}
