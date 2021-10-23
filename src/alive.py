from PySide6 import QtCore
from Daemon import alivedb
from settings import UserSettingsInstance

class ADBInstallStatusBridge(QtCore.QObject):
    startSignal = QtCore.Signal()
    adbInstallStatusResult = QtCore.Signal(int, arguments=['result'])

    def __init__(self, obj, parent=None):
        super().__init__(parent)
        self.m_obj = obj
        self.m_obj.adbInstallStatusResult.connect(self.adbInstallStatusResult)
        self.startSignal.connect(self.m_obj.getStatus)

class ADBInstallation(QtCore.QObject):
    adbInstallStatusResult = QtCore.Signal(int)

    def __init__(self, settingsInstance: UserSettingsInstance) -> None:
        super().__init__()
        self.settingsInstance = settingsInstance

    @QtCore.Slot()
    def getStatus(self):
        return self.adbInstallStatusResult.emit(alivedb.alivedb_installation_check(dev_mode=self.settingsInstance.get('devMode')))