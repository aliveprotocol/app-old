import QtQuick 2.15

/**
  * adapted from StackOverflow:
  * http://stackoverflow.com/questions/26879266/make-toast-in-android-by-qml
  * @brief Manager that creates Toasts dynamically
  */
ListView {
    /**
      * Public
      */

    /**
      * @brief Shows a Toast
      *
      * @param {string} text Text to show
      * @param {real} duration Duration to show in milliseconds, defaults to 3000
      * @param {real} toastType Type of toast to show (0: info, 1: success, 2: warning, 3: error)
      */
    function show(text, duration, toastType) {
        model.insert(0, {text: text, duration: duration, toastType: toastType});
    }

    /**
      * Private
      */

    id: root

    z: Infinity
    spacing: 5
    anchors.fill: parent
    anchors.bottomMargin: 10

    // ListView.TopToBottom - Toasts at top
    // ListView.BottomToTop - Toasts at bottom
    verticalLayoutDirection: ListView.TopToBottom

    interactive: false

    displaced: Transition {
        NumberAnimation {
            properties: "y"
            easing.type: Easing.InOutQuad
        }
    }

    delegate: Toast {
        Component.onCompleted: {
            if (typeof duration === "undefined")
                show(text);
            else if (typeof toastType !== "number")
                show(text, duration);
            else
                show(text, duration, toastType)
        }
    }

    model: ListModel {id: model}
}
