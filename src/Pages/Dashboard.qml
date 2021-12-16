import QtQuick 2.15
import QtQuick.Controls 2.15
import '../Components'

Item {
    property string alivedbVersion: ''
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

                MediumButton {
                    id: alivedbInstallBtn
                    visible: false
                    btnLabel: qsTr("Install")
                    anchors.left: alivedbStatusTitle.right
                    anchors.leftMargin: 15
                    anchors.verticalCenter: alivedbStatusTitle.verticalCenter
                    width: 60
                    height: 30
                    btnMouseArea.onClicked: {
                        if (!disabled) {
                            disabled = true
                            btnLabel = qsTr('Installing...')
                            width = 110
                            adbInstaller.startSignal()
                        }
                    }
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
        target: adbInstaller
        function onAdbInstallResult(result) {
            alivedbInstallBtn.disabled = false
            alivedbInstallBtn.btnLabel = qsTr('Install')
            alivedbInstallBtn.width = 80
            if (result) {
                alivedbInstallBtn.visible = false
                alivedbStatusDesc.text = qsTr('Installation up to date. Version: %1').arg(alivedbVersion)
                toast.show('AliveDB installed successfully',3000,1)
            } else {
                toast.show('Alivedb failed to install',3000,3)
            }
        }
    }

    Connections {
        target: adbInstallStatusBridge
        function onAdbInstallStatusResult(result,version) {
            alivedbVersion = version
            switch (result) {
            case 0:
                alivedbStatusDesc.text = qsTr('Installation not found. Install AliveDB to live stream and manage live chats.')
                alivedbInstallBtn.visible = true
                break
            case 1:
                alivedbStatusDesc.text = qsTr('Installation up to date. Version: %1').arg(version)
                break
            }
        }
    }
}
