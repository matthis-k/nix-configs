const systemtray = await Service.import("systemtray")

export function Tray() {
    return Widget.Box({
        class_names: ["tray", "module-lvl2"],
        spacing: 5,
        setup: (self) => {
            self.hook(systemtray, () => {
                const items = systemtray.items;
                // @ts-expect-error
                self.children = items.map((item) => {
                    if (item.id.trim() != "nm-applet" && item.id.trim() != "BlueBerry") {
                        return Widget.CenterBox({
                            center_widget: Widget.EventBox({
                                child: Widget.Icon({ icon: item.bind("icon") }),
                                on_primary_click_release: (_, event) => item.activate(event),
                                on_secondary_click_release: (_, event) => item.openMenu(event),
                                tooltip_markup: item.bind("tooltip_markup")
                            })
                        })
                    } else {
                        return undefined;
                    }
                });
                if (self.children.length > 0) self.visible = true;
                else self.visible = false;
            });
        }
    });
}
export { }
