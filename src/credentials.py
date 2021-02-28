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

class CredentialsInstance(QtCore.QObject):
    current_credentials: list = []
    is_hive: bool = False
    is_dtc: bool = False

    @QtCore.Slot(str, str, str, result=bool)
    def add_credential(self,network,username,key):
        if network == 'hive' and self.is_hive:
            return False
        elif network == 'dtc' and self.is_dtc:
            return False
        new_cred = Credential(network,username,key)
        self.current_credentials.append(new_cred)
        return True

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