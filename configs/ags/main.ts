import { Bar } from "modules/bar/main"


const scss = `${App.configDir}/style.scss`
const css = `/tmp/ags/style.css`
Utils.exec(`sassc ${scss} ${css}`)

Utils.monitorFile(scss, () => {
    Utils.exec(`sassc ${scss} ${css}`)
    App.resetCss()
    App.applyCss(css)
})

App.config({
    style: css,
    windows: [
        Bar(),
    ],
})


export { }
