# This Python file uses the following encoding: utf-8
import sys
import os
from PySide6 import QtCore, QtGui, QtQml
from Helpers import fileHelper
import dtc

def handle_exit():
    workerThread.quit()

if __name__ == "__main__":
    app = QtGui.QGuiApplication(sys.argv)
    engine = QtQml.QQmlApplicationEngine()

    # Worker thread
    workerThread = QtCore.QThread()
    workerThread.start()

    # Signal slots
    dtcLogin = dtc.DTCLogin()
    dtcLogin.moveToThread(workerThread)
    dtcLoginBridge = dtc.DTCLoginBridge(dtcLogin)
    engine.rootContext().setContextProperty("dtcLoginBridge", dtcLoginBridge)

    dtcGetAcc = dtc.GetAccount()
    dtcGetAcc.moveToThread(workerThread)
    dtcGetAccBridge = dtc.GetAccountBridge(dtcGetAcc)
    engine.rootContext().setContextProperty("dtcGetAccBridge", dtcGetAccBridge)

    getFilesize = fileHelper.GetFilesize()
    engine.rootContext().setContextProperty("getFilesize", getFilesize)

    # Load QML files
    engine.load(os.path.join(os.path.dirname(__file__), "main.qml"))

    # Handle app termination
    app.lastWindowClosed.connect(handle_exit)

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
