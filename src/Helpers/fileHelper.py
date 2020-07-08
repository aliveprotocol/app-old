from PySide2 import QtCore
import os

class GetFilesize(QtCore.QObject):
    @QtCore.Slot(str, result=int)
    def getFSize(self,dir):
        if dir.startswith('file://'):
            dir = dir.replace('file://','')
        try:
            size = os.path.getsize(dir)
        except:
            size = -1
        return size
