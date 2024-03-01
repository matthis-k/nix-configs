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
    vpack: "fill",
    children: [Tray(), Applets()],
});

export { }
