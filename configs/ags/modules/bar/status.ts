import Gtk from "gi://Gtk?version=3.0";
import { Battery } from "./battery";
import { Volume } from "./audio";
import { Wifi } from "./wifi";
import { Bluetooth } from "./bluetooth";
import { Tray } from "./tray";
import { PowerProfiles } from "./power_profiles";

const Applets = () =>
    Widget.Box({
        class_names: ["applets", "module-lvl2"],
        spacing: 3,
        halign: Gtk.Align.CENTER,
        valign: Gtk.Align.CENTER,
        vpack: "fill",
        children: [
            Volume(),
            Bluetooth(),
            Wifi(),
            PowerProfiles(),
            Battery()
        ]
    });

export const SystemStatus = () => Widget.Box({
    spacing: 5,
    class_names: ["status", "module-lvl1"],
    halign: Gtk.Align.CENTER,
    valign: Gtk.Align.CENTER,
    vpack: "fill",
    children: [Tray(), Applets()],
});

export { }
