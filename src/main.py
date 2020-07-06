# This Python file uses the following encoding: utf-8
import sys
import os

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2 import QtCore

import dtc

def handle_exit():
    workerThread.quit()

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Worker thread
    workerThread = QtCore.QThread()
    workerThread.start()

    # Signal slots
    dtcLogin = dtc.DTCLogin()
    dtcLogin.moveToThread(workerThread)
    dtcLoginBridge = dtc.DTCLoginBridge(dtcLogin)
    engine.rootContext().setContextProperty("dtcLoginBridge", dtcLoginBridge)

    dtcGetAccount = dtc.GetAccount()
    dtcGetAccount.moveToThread(workerThread)
    dtcGetAccountBridge = dtc.GetAccountBridge(dtcGetAccount)
    engine.rootContext().setContextProperty("dtcGetAccountBridge", dtcGetAccountBridge)

    # Load QML files
    engine.load(os.path.join(os.path.dirname(__file__), "main.qml"))

    # Handle app termination
    app.lastWindowClosed.connect(handle_exit)

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
