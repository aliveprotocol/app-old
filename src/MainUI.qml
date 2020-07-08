import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import "./Components"
import "./Pages"

Item {
    id: mainUI
    property var toast
    property int tabIndex: 0

    anchors.fill: parent

    // Menu
    Rectangle {
        width: 200

        color: "#222222"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        ColumnMenuButton {
            id: dashboardMenuBtn
            btnLabel: qsTr("Dashboard")
            anchors.top: parent.top
            anchors.topMargin: 50
            selected: tabIndex == 0
            btnMouseArea.onClicked: tabIndex = 0
        }

        ColumnMenuButton {
            id: createStreamMenuBtn
            btnLabel: qsTr("Create Stream")
            anchors.top: dashboardMenuBtn.bottom
            selected: tabIndex == 1
            btnMouseArea.onClicked: tabIndex = 1
        }
        ColumnMenuButton {
            id: goLiveMenuBtn
            btnLabel: qsTr("Go Live")
            anchors.top: createStreamMenuBtn.bottom
            selected: tabIndex == 2
            btnMouseArea.onClicked: tabIndex = 2
        }

        ColumnMenuButton {
            id: recentStreamsMenuBtn
            btnLabel: qsTr("Recent Streams")
            anchors.top: goLiveMenuBtn.bottom
            selected: tabIndex == 3
            btnMouseArea.onClicked: tabIndex = 3
        }
        ColumnMenuButton {
            id: settingsMenuBtn
            btnLabel: qsTr("Settings")
            anchors.bottom: accountMenuBtn.top
            selected: tabIndex == 4
            btnMouseArea.onClicked: tabIndex = 4
        }

        ColumnMenuButton {
            id: accountMenuBtn
            btnLabel: qsTr("Account")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            selected: tabIndex == 5
            btnMouseArea.onClicked: tabIndex = 5
        }
    }

    // Top bar for available balances and bandwidth
    ResourcesTopBar {
        id: resourcesTopBar
        anchors.left: parent.left
        anchors.leftMargin: 200
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: stackLayout.top
        anchors.bottomMargin: 0
    }

    // Content
    StackLayout {
        id: stackLayout
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 200
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 50
        currentIndex: tabIndex

        Dashboard { id: dashboard }
        NewStream { id: newStream }
        GoLive { id: goLive }
        RecentStreams { id: recentStreams }
        UserSettings { id: userSettings }
        AccountSettings { id: accountSettings }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
