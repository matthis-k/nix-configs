const network = await Service.import("network")
const bluetooth = await Service.import("bluetooth")

const revealWifi = Variable(false)
const revealBluetooth = Variable(false)

export function Wifi() {
    return Widget.EventBox({
        class_names: Utils.merge([
            network.bind("primary"),
            network.bind("connectivity")
        ], (primary, connectivity) => { return ["network-fast-settings", `${primary}`, `${connectivity}`] }),
        on_primary_click: () => { revealWifi.setValue(!revealWifi.value); revealBluetooth.setValue(false); },
        on_secondary_click: network.toggleWifi,
        child: Widget.Box({
            children: [
                Widget.Icon({
                    size: 64,
                    icon: network.wifi.bind('icon_name'),
                    tooltip_text: network.wifi.bind('ssid')
                        .as(ssid => ssid || 'Unknown'),
                }),
            ],
        })
    })
}
export function Bluetooth() {
    return Widget.EventBox({
        class_names: Utils.merge([
            bluetooth.bind("enabled"),
        ], (enabled) => { return ["bluetooth-fast-settings", `${enabled ? "enabled" : "disabled"}`,] }),
        on_primary_click: () => { revealBluetooth.setValue(!revealBluetooth.value); revealWifi.setValue(false); },
        on_secondary_click: bluetooth.toggle,
        child: Widget.Box({
            children: [
                Widget.Icon({
                    size: 64,
                    icon: Utils.merge([bluetooth.bind('enabled'),],
                        (enabled) => enabled ? "bluetooth-active-symbolic" : "bluetooth-disabled-symbolic"),
                    tooltip_text: bluetooth.bind("connected_devices").as(devs => {
                        return devs.map((device) => `${device.name} (${device.battery_level}%)`).join("\n")
                    }),
                }),
            ],
        })
    })
}

export function FastSettings() {
    return Widget.Box({
        vertical: true,
        children: [
            Widget.Box({
                vertical: false,
                spacing: 10,
                homogeneous: true,
                children: [
                    Wifi(),
                    Bluetooth(),
                ],
            })
        ],
    })
}

export function dashboard() {
    return Widget.Box({
        vertical: true,
        children: [
            FastSettings(),
        ]
    })
}

export { }
