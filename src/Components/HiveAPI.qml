import QtQuick 2.0

Item {
    property var apiOptions: [
        { value: 'https://techcoderx.com', text: 'techcoderx.com' },
        { value: 'https://api.hive.blog', text: 'api.hive.blog' },
        { value: 'https://api.openhive.network', text: 'api.openhive.network' },
        { value: 'https://api.deathwing.me', text: 'api.deathwing.me' },
        { value: 'https://api.c0ff33a.uk', text: 'api.c0ff33a.uk' },
        { value: 'https://anyx.io', text: 'anyx.io' },
        { value: 'https://hive-api.arcange.eu', text: 'hive-api.arcange.eu' },
        { value: 'https://hived.emre.sh', text: 'hived.emre.sh' },
        { value: 'https://rpc.ausbit.dev', text: 'rpc.ausbit.dev' },
        { value: 'https://rpc.ecency.com', text: 'rpc.ecency.com' },
        { value: 'https://hived.privex.io', text: 'hived.privex.io' },
        { value: 'https://hive.roelandp.nl', text: 'hive.roelandp.nl' },
        { value: 'https://api.pharesim.me', text: 'api.pharesim.me' },
    ]

    function getIndex(val) {
        for (let i in apiOptions)
            if (val === apiOptions[i].value)
                return i
        return 0
    }
}
