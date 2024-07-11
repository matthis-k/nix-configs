const bluetooth = await Service.import("bluetooth")
const systemtray = await Service.import("systemtray")

export function Bluetooth() {
    return Widget.EventBox({
        class_names: ["bar_bluetooth", "applet"],
        on_primary_click_release: () => {
            //OpenSettings("bluetooth");
            Utils.execAsync("blueberry").catch(print);
        },
        on_secondary_click_release: (_, event) => {
            const blueberry = systemtray.items.find((item) => item.id == "BlueBerry");
            if (blueberry) {
                blueberry.openMenu(event);
            } else {
                Utils.execAsync("blueberry").catch(print);
            }
        },
        child: Widget.Icon({
            icon: "bluetooth-disabled-symbolic",
            hpack: "center",
            vpack: "center",
        }),
    }).hook(bluetooth, (self) => {
        if (bluetooth.enabled) {
            self.child.icon = "bluetooth-symbolic";
        } else {
            self.child.icon = "bluetooth-disabled-symbolic";
        }
    });
}

export { }
