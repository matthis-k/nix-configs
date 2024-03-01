import Gtk from "gi://Gtk?version=3.0";


export function Wallpaper(monitor: number) {
    const image = App.configDir + "/assets/wallpaper.png"
    return Widget.Window({
        name: `wallpaper-${monitor}`,
        class_name: "wallpaper",
        monitor,
        anchor: ["top", "bottom", "left", "right"],
        exclusivity: "ignore",
        layer: "bottom",
        child: Widget.Box({
            css: `background-image: url("${image}");`
                + `background-size: cover;`
                + `background-repeat: no-repeat;`
                + `background-position: center;`,
        }),
    })
}


export { }
