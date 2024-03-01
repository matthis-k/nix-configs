import Gtk from "gi://Gtk?version=3.0";
import { toggle_settings } from "modules/settings/main";

const systemtray = await Service.import("systemtray")
const network = await Service.import("network")

export function Wifi() {
    return Widget.CenterBox({
        class_names: ["bar_wifi", "applet"],
        end_widget: Widget.EventBox({
            on_primary_click_release: () => {
                toggle_settings();
            },
            on_secondary_click_release: (_, event) => {
                const nm_applet = systemtray.items.find((item) => item.id == "nm-applet");
                if (nm_applet) {
                    nm_applet.openMenu(event);
                } else {
                    Utils.execAsync("nm-connection-editor").catch(print);
                }
            },
            child: Widget.Icon({
                icon: "network-wireless-disconnected-symbolic",
                hpack: "center",
                vpack: "center",
            }),
            tooltip_text: "Disabled"
        }).hook(network, (self) => {
            if (network.wifi.enabled) {
                self.tooltip_text = network.wifi.ssid || "Unknown";
                self.child.icon = network.wifi.icon_name || "network-wireless-disconnected-symbolic";
            } else {
                self.tooltip_text = "Disabled";
                self.child.icon = "network-wireless-disconnected-symbolic";
            }
        })
    })
}

