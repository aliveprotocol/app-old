import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.platform 1.1
import "../Components"

Item {
    property var communitiesList: [{ value: 'hive-169420', text: 'Alive Protocol (hive-169420)' }]
    onVisibleChanged: {
        if (visible) {
            let username = credInstance.get_username_by_network('hive')
            hiveCommunitySubBridge.startSignal(username)
        }
    }

    ScrollView {
        id: scrollView
        clip: true
        anchors.fill: parent
        contentHeight: newStreamRect.height + newStreamTabBar.height + (proceedCreateStreamBtn.height * 2)

        TabBar {
            id: newStreamTabBar
            width: 300
            height: 34
            anchors.left: newStreamRect.left
            anchors.top: parent.top

            background: Rectangle {
                color: '#36393f'
            }

            TabButton {
                height: 34
                contentItem: Text {
                    text: qsTr('Basics')
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 20
                }
            }

            TabButton {
                height: 34
                contentItem: Text {
                    text: qsTr('Advanced')
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 20
                }
            }
        }

        StackLayout {
            id: newStreamRect
            anchors {
                left: parent.left
                leftMargin: 40
                right: parent.right
                rightMargin: 40
                top: newStreamTabBar.bottom
                topMargin: 0
            }
            Layout.fillHeight: false
            currentIndex: newStreamTabBar.currentIndex

            Item {
                id: basicsTab
                width: parent.width
                height: 420

                AliveTextFieldFormGroup {
                    id: titleField
                    fieldLabel: qsTr('Title:')
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin: 10
                }

                Text {
                    id: descriptionLbl
                    height: 22
                    color: "#ffffff"
                    text: qsTr("Description:")
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: titleField.bottom
                    anchors.topMargin: 20
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 18
                }

                AliveScrollableTextArea {
                    id: descriptionItm
                    height: 100
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: descriptionLbl.bottom
                    anchors.topMargin: 10
                }

                AliveTextFieldFormGroup {
                    id: tagsField
                    fieldLabel: qsTr('Tags:')
                    fieldPlaceholder: qsTr('Up to 8, separated by space')
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: descriptionItm.bottom
                    anchors.topMargin: 20
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                }

                AliveTextFieldFormGroup {
                    id: thumbnailDirField
                    fieldLabel: qsTr('Upload a thumbnail:')
                    fieldPlaceholder: qsTr('Thumbnail hash goes here')
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: tagsField.bottom
                    anchors.topMargin: 25
                    anchors.right: parent.right
                    anchors.rightMargin: 85
                }

                MediumButton {
                    id: thumbnailDirSelectBtn
                    anchors.verticalCenter: thumbnailDirField.verticalCenter
                    anchors.verticalCenterOffset: 15
                    btnLabel: qsTr("Browse")
                    anchors.left: thumbnailDirField.right
                    anchors.leftMargin: 5
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    btnMouseArea.onClicked: fileDialog.open()
                    width: 80
                    height: 30
                }

                Text {
                    id: hiveCommunityLbl
                    height: 22
                    color: '#ffffff'
                    text: qsTr('Hivemind community')
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: thumbnailDirField.bottom
                    anchors.topMargin: 20
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 18
                }

                DropdownSelection {
                    id: hiveCommunityDropdown
                    height: 25
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: hiveCommunityLbl.bottom
                    anchors.topMargin: 10
                    model: communitiesList
                }

                /*
                Text {
                    id: dtcVwLbl
                    height: 22
                    color: "#ffffff"
                    text: qsTr("Avalon vote weight: 1%")
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: thumbnailDirField.bottom
                    anchors.topMargin: 20
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 18
                }

                Slider {
                    id: dtcVwSlider
                    height: 40
                    from: 1
                    to: 100
                    stepSize: 1
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: dtcVwLbl.bottom
                    anchors.topMargin: 10
                    value: 1
                    snapMode: Slider.SnapOnRelease
                    background: Rectangle {
                        x: dtcVwSlider.leftPadding
                        y: dtcVwSlider.topPadding + dtcVwSlider.availableHeight / 2 - height / 2
                        implicitWidth: parent.width
                        implicitHeight: 4
                        width: dtcVwSlider.availableWidth
                        height: implicitHeight
                        radius: 2
                        color: "#bdbebf"

                        Rectangle {
                            width: dtcVwSlider.visualPosition * parent.width
                            height: parent.height
                            color: "#ff0000"
                            radius: 2
                        }
                    }
                    onMoved: dtcVwLbl.text = "Avalon vote weight: " + dtcVwSlider.value + "%"
                }

                Text {
                    id: dtcBurnLbl
                    height: 22
                    color: "#ffffff"
                    text: qsTr("Promote with DTC burn:")
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: dtcVwSlider.bottom
                    anchors.topMargin: 20
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 18
                }

                AliveTextField {
                    id: dtcBurnField
                    height: 25
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: dtcBurnLbl.bottom
                    anchors.topMargin: 10
                    validator: RegularExpressionValidator { regularExpression: /\d+(\.\d{1,2})?/ }
                }
                */
            }

            Item {
                id: advancedTab
                Layout.fillHeight: true
                Layout.fillWidth: true
                width: parent.width
                height: 20

                AliveTextFieldFormGroup {
                    id: permlinkField
                    fieldLabel: qsTr('Post permlink:')
                    fieldPlaceholder: qsTr('Auto-generated if left blank')
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                }

                Text {
                    id: benefLbl
                    text: qsTr('Post beneficiaries')
                    height: 22
                    color: "#ffffff"
                    anchors.leftMargin: 0
                    anchors.top: permlinkField.bottom
                    anchors.topMargin: 20
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 18
                }

                AliveTextField {
                    id: newBenefUserField
                    placeholderText: qsTr('New beneficiary username')
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: benefLbl.bottom
                    anchors.topMargin: 10
                    width: 300
                }

                AliveTextField {
                    id: newBenefWeightField
                    placeholderText: qsTr('%')
                    anchors.left: newBenefUserField.right
                    anchors.leftMargin: 10
                    anchors.top: benefLbl.bottom
                    anchors.topMargin: 10
                    anchors.verticalCenter: newBenefUserField.verticalCenter
                    width: 60
                }

                MediumButton {
                    id: newBenefAddBtn
                    btnLabel: '+'
                    anchors.verticalCenter: newBenefWeightField.verticalCenter
                    anchors.left: newBenefWeightField.right
                    anchors.leftMargin: 10
                    width: 40
                    height: 30
                }
            }
        }

        // TODO: should we fix the position to the bottom right like in peakd?
        BigButton {
            id: proceedCreateStreamBtn
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newStreamRect.bottom
            anchors.topMargin: 30
            anchors.bottomMargin: 30
            btnLabel: qsTr("Create")
            btnMouseArea.onClicked: {
                // basic checks
                if (titleField.text === "")
                    return toast.show(qsTr("Title is required"),3000,3)
                else if (tagsField.text === "")
                    return toast.show(qsTr("Tags are required"),3000,3)
                else if (tagsField.text.split(' ').length > 8)
                    return toast.show(qsTr("Please use only 8 tags maximum"),3000,3)
                else if (thumbnailDirField.text === "")
                    return toast.show(qsTr("Please enter a thumbnail hash or upload one"),3000,3)

                toast.show('Create stream...',3000,0)
            }
        }
    }


    FileDialog {
        id: fileDialog
        title: "Upload a thumbnail"
        // folder: shortcuts.home
        nameFilters: ["Image files (*.jpg *.png)"]
        onAccepted: {
            let selectedFSize = getFilesize.getFSize(fileDialog.currentFile)
            if (selectedFSize > 0 && selectedFSize <= 4194304) // 4 MB limit
                thumbnailDirField.text = fileDialog.currentFile
            else
                toast.show("Thumbnail file size must be under 4 MB",3000,3)
        }
    }

    Connections {
        target: hiveCommunitySubBridge
        function onHiveCommunitySubResult(result) {
            let r = JSON.parse(result)
            if (r.result) {
                communitiesList = [{ value: 'hive-169420', text: 'Alive Protocol (hive-169420)' }]
                for (let i in r.result) if (r.result[i][0] !== 'hive-169420')
                    communitiesList.push({ value: r.result[i][0], text: r.result[i][1] + ' (' + r.result[i][0] + ')' })
            }
            hiveCommunityDropdown.model = communitiesList
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:1280;width:640}
}
##^##*/
