import QtQuick 2.0

Item {
    property var accounts: []
    property int total: 0
    property string network: 'hive'

    function addAccount(account,weight) {
        if (!account || !weight)
            return toast.show(qsTr('No account or weight?'),3000,3)
        if (accounts.length === 8)
            return toast.show(qsTr('Maximum number of beneficiary accounts is 8.'),3000,3)
        if (credInstance.get_username_by_network('hive') === account)
            return toast.show(qsTr('Cannot set beneficiary to own account.'),3000,3)
        if (weight <= 0)
            return toast.show(qsTr('Beneficiary percentage must be more than 0.'),3000,3)
        if (total + weight > 10000)
            return toast.show(qsTr('Cannot set beneficiaries totalling more than 100%.'),3000,3)
        for (let i = 0; i < accounts.length; i++)
            if (accounts[i].account === account)
                return toast.show(qsTr('Account specified already added as beneficiaries.'),3000,3)

        accounts.push({
            account: account,
            weight: weight
        })
        total += weight
        toast.show(qsTr('%1 account %2 added to beneficiaries').arg(capitalizedNetwork()).arg(account),3000,1)
    }

    function removeAccount(account) {
        for (let i = 0; i < accounts.length; i++)
            if (accounts[i].account === account) {
                total -= accounts[i].weight
                accounts.splice(i,1)
                return
            }
        toast.show(qsTr('Account %1 does not exist in beneficiaries list').arg(account),3000,3)
    }

    function capitalizedNetwork() {
        return network.charAt(0).toUpperCase() + network.slice(1)
    }
}
