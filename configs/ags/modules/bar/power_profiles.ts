const powerProfiles = await Service.import('powerprofiles')
import Gtk from "gi://Gtk?version=3.0";
import { toggle_settings } from "modules/settings/main";

export function PowerProfiles() {
    const icon_name = powerProfiles.bind("icon_name")
    function get_classes() {
        return ["power-profiles", "applet", powerProfiles.active_profile]
    }

    return Widget.CenterBox({
        class_names: Utils.watch(get_classes(), powerProfiles, get_classes),
        end_widget: Widget.EventBox({
            child: Widget.Icon({
                icon_name
            }),
            on_primary_click_release: () => toggle_settings(),
            on_secondary_click_release: () => {
                switch (powerProfiles.active_profile) {
                    case 'balanced':
                        powerProfiles.active_profile = 'performance';
                        break;
                    case 'performance':
                        powerProfiles.active_profile = 'power-saver';
                        break;
                    default:
                        powerProfiles.active_profile = 'balanced';
                        break;
                };
            },
        })
    })

}

export { }
