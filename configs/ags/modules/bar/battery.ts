import Gtk from "gi://Gtk?version=3.0";
import { toggle_settings } from "modules/settings/main";
const battery = await Service.import("battery")

export function Battery() {
    function battery_tooltip() {
        return `<span font_weight="bold" font_size="larger">${battery.charging ? "Charging" : "Discharging"} at ${battery.percent}%</span>\n` +
            `${battery.charging ? "Full" : "Empty"} in ~${Math.floor(battery.time_remaining / 60 / 60)}h${(Math.floor((battery.time_remaining / 60) % 60))}m`
    }
    function battery_classes() {
        const thresholds = [{ v: 10, c: "critical" }, { v: 20, c: "low" }, { v: 90, c: "" }, { v: 100, c: "high" }]
        return [
            "battery",
            "applet",
            battery.charging ? "charging" : "discharging",
            (thresholds.find((threshold) => threshold.v >= battery.percent) || { c: "" }).c
        ]
    }
    function battery_icon() {
        return `battery-level-${Math.floor(battery.percent / 10) * 10}-${battery.charging ? "charging-" : ""}symbolic`
    }
    const value = battery.bind("percent").as(p => p > 0 ? p / 100 : 0)
    const icon = Utils.watch(battery_icon(), battery, battery_icon)
    const reveal = Variable(false)
    return Widget.CenterBox({
        class_names: Utils.watch(battery_classes(), battery, battery_classes),
        visible: battery.bind("available"),
        tooltip_markup: Utils.watch(battery_tooltip(), battery, "changed", battery_tooltip),
        start_widget:
            Widget.Revealer({
                reveal_child: reveal.bind(),
                transition: "slide_right",
                child:
                    Widget.LevelBar({
                        widthRequest: 50,
                        vpack: "center",
                        value,
                    }),
            }),
        end_widget: Widget.EventBox({
            child: Widget.Icon({
                icon,
            }),
            on_primary_click_release: () => {
                toggle_settings()
            },
            on_secondary_click_release: () => {
                reveal.setValue(!reveal.value)
            },
        })
    })
}

export { }
