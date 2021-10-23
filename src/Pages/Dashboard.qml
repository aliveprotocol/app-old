import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    ScrollView {
        id: scrollView
        clip: true
        anchors.fill: parent
        contentHeight: dashboardRect.height
        onVisibleChanged: {
            if (visible)
                adbInstallStatusBridge.startSignal()
        }

        Rectangle {
            id: dashboardRect
            anchors {
                left: parent.left
                leftMargin: 40
                right: parent.right
                rightMargin: 40
                top: parent.top
                topMargin: 0
            }
            color: "#36393f"

            Rectangle {
                id: jumbotron
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }
                radius: 10
                color: '#ff5555'
                height: 95

                Text {
                    id: jumbotronTitle
                    text: qsTr('Welcome Back!')
                    color: '#ffffff'
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.top: parent.top
                    anchors.topMargin: 15
                    font.pixelSize: 25
                }

                Text {
                    id: jumbotronDesc
                    text: qsTr('Start streaming to decentralized protocols.')
                    color: '#ffffff'
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.top: jumbotronTitle.bottom
                    anchors.topMargin: 15
                    font.pixelSize: 16
                }
            }

            Rectangle {
                id: alivedbStatusRect
                anchors {
                    left: parent.left
                    right: parent.right
                    top: jumbotron.bottom
                    topMargin: 20
                }
                radius: 10
                color: 'transparent'
                border.color: '#ffffff'
                border.width: 2
                height: 95

                Text {
                    id: alivedbStatusTitle
                    text: qsTr('AliveDB')
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.top: parent.top
                    anchors.topMargin: 15
                    font.pixelSize: 25
                }

                Text {
                    id: alivedbStatusDesc
                    text: qsTr('Checking AliveDB installation...')
                    color: '#ffffff'
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.top: alivedbStatusTitle.bottom
                    anchors.topMargin: 15
                    font.pixelSize: 16
                }
            }
        }
    }

    Connections {
        target: adbInstallStatusBridge
        function onAdbInstallStatusResult(result) {
            switch (result) {
            case 0:
                alivedbStatusDesc.text = qsTr('Installation not found.')
                break
            case 1:
                alivedbStatusDesc.text = qsTr('Installation up to date.')
                break
            case 2:
                alivedbStatusDesc.text = qsTr('Installation from source code used.')
                break
            }
        }
    }
}
