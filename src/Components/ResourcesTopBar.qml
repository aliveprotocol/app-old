import QtQuick 2.0
import "../Helpers/growInt.js" as GrowInt

Item {
    id: resourcesTopBar
    height: 50
    onVisibleChanged: {
        // Load balance and bandwidth info
        if (resourcesTopBar.visible)
            dtcGetAccBridge.startSignal("techcoderx")
    }

    Connections {
        target: dtcGetAccBridge
        function onAccountResult(result) {
            if (result !== "Error")
                updateDisplay(result)
        }
    }

    Text {
        id: bandwidthInfo
        x: 512
        y: 15
        width: 150
        height: 20
        color: "#ffffff"
        text: qsTr("BW: Loading...")
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
        text: qsTr("Balance: Loading...")
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 16
        anchors.right: bandwidthInfo.left
        anchors.rightMargin: 50
        verticalAlignment: Text.AlignVCenter
    }

    function updateDisplay(detail) {
        let detailObj = JSON.parse(detail)
        let grownBw = new GrowInt.GrowInt(detailObj.bw, {
                growth: detailObj.balance / 36000000,
                max: 64000
            }).grow(new Date().getTime()).v

        balanceInfo.text = "Balance: " + thousandSeperator(detailObj.balance / 100) + " DTC"
        bandwidthInfo.text = "BW: " + thousandSeperator(grownBw) + " bytes"
    }

    function thousandSeperator(num) {
        var num_parts = num.toString().split(".")
        num_parts[0] = num_parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",")
        num_parts[0] = num_parts[0].replace(",,",",")
        return num_parts.join(".")
    }
}
