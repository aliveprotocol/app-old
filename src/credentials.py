import os
import json
from dataclasses import dataclass
from PySide6 import QtCore

@dataclass
class Credential:
    network: str
    username: str
    private_key: str

    def __post_init__(self) -> None:
        assert self.network == 'dtc' or self.network == 'hive', 'invalid network'
        assert self.username, 'no username?'
        assert self.private_key, 'no key?'

    def to_object(self) -> dict:
        return {
            'network': self.network,
            'username': self.username,
            'private_key': self.private_key
        }

class CredentialsInstance(QtCore.QObject):
    current_credentials: list = []
    is_hive: bool = False
    is_dtc: bool = False
    data_dir = os.path.expanduser(os.path.join('~', '.alive'))

    def __init__(self):
        super().__init__()
        self.load_credentials()

    def load_credentials(self):
        if os.path.exists(self.data_dir+'/credentials.json'):
            # Read file
            f = open(self.data_dir+'/credentials.json','r')
            r = json.loads(f.read())
            for c in r:
                self.add_credential(c['network'],c['username'],c['private_key'])
            f.close()

            # Update networks
            for c in range(len(self.current_credentials)):
                if self.current_credentials[c].network == 'hive':
                    self.is_hive = True
                elif self.current_credentials[c].network == 'dtc':
                    self.is_dtc = True

    @QtCore.Slot()
    def write_credentials(self):
        f = open(self.data_dir+'/credentials.json','w')
        w = []
        for c in self.current_credentials:
            w.append(c.to_object())
        f.write(json.dumps(w))
        f.close()

    @QtCore.Slot(str, str, str, result=bool)
    def add_credential(self,network,username,key):
        if network == 'hive' and self.is_hive:
            return False
        elif network == 'dtc' and self.is_dtc:
            return False
        if network == 'hive':
            self.is_hive = True
        elif network == 'dtc':
            self.is_dtc = True
        new_cred = Credential(network,username,key)
        self.current_credentials.append(new_cred)
        return True

    @QtCore.Slot(str, result=bool)
    def remove_credential(self,network):
        if network == 'hive':
            if self.is_hive is False:
                return False
            self.is_hive = False
        elif network == 'dtc':
            if self.is_dtc is False:
                return False
            self.is_dtc = False
        return self.__pop_credential_by_index__(network)

    def __pop_credential_by_index__(self, network: str) -> bool:
        for i in range(len(self.current_credentials)):
            if self.current_credentials[i].network == network:
                del self.current_credentials[i]
                return True
        return False

    def __get_credential_index_by_network__(self,network) -> int:
        for c in range(len(self.current_credentials)):
            if self.current_credentials[c].network == network:
                return c
        return -1

    @QtCore.Slot(str, result=str)
    def get_username_by_network(self,network):
        idx = self.__get_credential_index_by_network__(network)
        if idx < 0:
            return ''
        else:
            return self.current_credentials[idx].username

    @QtCore.Slot(str, result=str)
    def get_pk_by_network(self,network):
        idx = self.__get_credential_index_by_network__(network)
        if idx < 0:
            return ''
        else:
            return self.current_credentials[idx].private_key

    @QtCore.Slot(result=str)
    def get_preferred_network(self):
        if self.is_hive:
            return 'hive'
        elif self.is_dtc:
            return 'dtc'
        return ''

    @QtCore.Slot(result=bool)
    def contains_credential(self):
        return self.is_hive or self.is_dtc