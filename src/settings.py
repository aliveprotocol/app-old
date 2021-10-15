from PySide6 import QtCore
import json
import os

class UserSettingsInstance(QtCore.QObject):
    user_settings = {}
    data_dir = os.path.expanduser(os.path.join('~', '.alive'))
    defaults = {
        'devMode': 'off',
        'hiveAPI': 'https://techcoderx.com'
    }

    def __init__(self) -> None:
        """User settings JSON constructor"""
        super().__init__()
        if os.path.exists(self.data_dir) is False:
            os.mkdir(self.data_dir)
        if os.path.exists(self.data_dir+'/settings.json'):
            f = open(self.data_dir+'/settings.json','r')
            self.user_settings = json.loads(f.read())
            f.close()

    @QtCore.Slot(str, result=str)
    def get(self,key):
        """Get one value"""
        try:
            r = self.user_settings[key]
            return r
        except KeyError:
            try:
                d = self.defaults[key]
                return d
            except KeyError:
                return None
    
    @QtCore.Slot(str, str, result=bool)
    def set(self,key,value):
        """Set one value"""
        self.user_settings[key] = value
        print('SET',key,value)
        return True

    @QtCore.Slot(result=str)
    def readJson(self):
        """Read full settings JSON"""
        return json.dumps(self.user_settings)

    @QtCore.Slot()
    def write(self):
        """Write settings JSON to disk"""
        f = open(self.data_dir+'/settings.json','w')
        f.write(json.dumps(self.user_settings))
        f.close()
        print('settings saved '+json.dumps(self.user_settings))